// This file is a container for a bunch of coreir hacks
// that are needed to get the compiler flow working. Feel
// free to use it as a hook in to the build system for other hacks that
// need to be applied to the pre-mapped coreir for an application.

#include "coreir.h"
#include "coreir/libs/commonlib.h"
#include "lakelib.h"

#include <set>

using namespace std;
using namespace CoreIR;

bool hasConnection(Wireable* w) {
  if (w->getConnectedWireables().size()) return true;
  
  for (auto smap : w->getSelects()) {
    if (hasConnection(smap.second)) return true;
  }
  return false;
}

Wireable* replaceBase(Wireable* toReplace, map<Wireable*, Wireable*>& ws, map<Instance*, Instance*>& instances, ModuleDef* cpyDef) {

  if (toReplace->getKind() == Wireable::WK_Interface) {
    return map_find(toReplace, ws);
  }

  if (toReplace->getKind() == Wireable::WK_Instance) {
    return map_find(static_cast<Instance*>(toReplace), instances);
  }

  assert(toReplace->getKind() == Wireable::WK_Select);
  auto sel = static_cast<Select*>(toReplace);
  return replaceBase(sel->getParent(), ws, instances, cpyDef)->sel(sel->getSelStr());
}

void copyModuleTo(Module* top, Namespace* tmp) {
  map<Wireable*, Wireable*> ws;
  map<Instance*, Instance*> instances;

  auto def = top->getDef();
  assert(def != nullptr);

  auto c = def->getContext();

  RecordParams rc;
  for (auto field : top->getType()->getFields()) {
    auto port = def->sel("self")->sel(field);
    rc.push_back({field, c->Flip(port->getType())});
  }
  Module* cpyMod = tmp->newModuleDecl("DesignTop", c->Record(rc));
  auto cpyDef = cpyMod->newModuleDef();
  ws[def->sel("self")] = cpyDef->sel("self");
  for (auto field : cpyMod->getType()->getFields()) {
    ws[def->sel("self")->sel(field)] = cpyDef->sel("self")->sel(field);
  }
  for (auto inst : def->getInstances()) {
    auto instPtr = inst.second;
    auto cpyInst = cpyDef->addInstance(inst.first, instPtr->getModuleRef(), instPtr->getModArgs());
    instances[instPtr] = cpyInst;
  }

  cout << "Copying connections.." << endl;
  
  for (auto& oldConn : def->getSortedConnections()) {
    Wireable* fst = oldConn.first;
    Wireable* snd = oldConn.second;

    cpyDef->connect(replaceBase(fst, ws, instances, cpyDef), replaceBase(snd, ws, instances, cpyDef));
  }
  cout << "Done copying connections.." << endl;

  cpyMod->setDef(cpyDef);
  cout << "cpyMod..." << endl;
  cpyMod->print();
}

bool fromGenerator(Instance* inst, const std::string& name) {
  if (!inst->getModuleRef()->isGenerated()) {
    return false;
  }

  auto gen = inst->getModuleRef()->getGenerator();
  return gen->getRefName() == name;
}

int main(const int argc, const char** argv) {

  assert(argc == 2);

  string fileName = argv[1];
  cout << "Doing coreir hacks for: " << fileName << endl;
  Context* c = newContext();
  CoreIRLoadLibrary_commonlib(c);
  CoreIRLoadLibrary_lakelib(c);

  if (!loadFromFile(c, fileName)) {
    cout << "Could not Load from json!!" << endl;
    c->die();
  }

  Namespace* n = c->getNamespace("global");
  Module* top = n->getModule("DesignTop");
  auto def = top->getDef();
  assert(def != nullptr);
  bool changed = true;
  while (changed) {
    changed = false;
    for (auto inst : def->getInstances()) {
      //cout << "Inlining: " << CoreIR::toString(*(inst.second)) << endl;
      if (!fromGenerator(inst.second, "rom2") &&
          !fromGenerator(inst.second, "linebuffer") &&
          !fromGenerator(inst.second, "unified_buffer")) {
        changed = inlineInstance(inst.second);
      }
      //cout << "Changed = " << changed << endl;
      //top->print();
      if (changed) {
        break;
      }
    }
  }

  c->runPasses({"deletedeadinstances"});

  cout << "After inlining..." << endl;
  top->print();

  cout << "Converting rom parameterization" << endl;
  set<Instance*> roms;
  for (auto inst : top->getDef()->getInstances()) {
    if (fromGenerator(inst.second, "memory.rom2") ||
        fromGenerator(inst.second, "rom2")) {
      roms.insert(inst.second);
    }
  }

  cout << "Found: " << roms.size() << " roms" << endl;

  for (auto rom : roms) {
    Module* romMod = rom->getModuleRef();
    const Values& modArgs = rom->getModArgs();

    Values newArgs;
    for (auto arg : modArgs) {
      cout << "\tArg: " << arg.first << endl;
      if (arg.first != "init") {
        cout << "copying: " << arg.first << endl;
        newArgs[arg.first] = arg.second;
      } else {
        cout << "Replacing rom..." << endl;
        cout << "Init: " << arg.second->get<Json>() << endl;
        Json replacedInit;
        for (auto v : arg.second->get<Json>()["init"]) {
          cout << "Adding: " << v << " to replaced" << endl;
          replacedInit["init"].emplace_back(stoi(v.get<std::string>()));
        }
        newArgs[arg.first] = CoreIR::Const::make(top->getDef()->getContext(), replacedInit);
        //newArgs[arg.first] = arg.second;
      }
    }
    rom->replace(romMod, newArgs);
  }

  cout << "Removing unused ports" << endl;
  std::set<string> unusedPorts;
  RecordParams rc;
  for (auto field : top->getType()->getFields()) {
    cout << "Name: " << field << endl;
    auto port = def->sel("self")->sel(field);
    if (!hasConnection(port)) {
      cout << "\t" << field << " has no connections" << endl;
      unusedPorts.insert(field);
    } else {
      rc.push_back({field, c->Flip(port->getType())});
    }
  }

  Namespace* tmp = c->newNamespace("tmp");
  map<Wireable*, Wireable*> ws;
  map<Instance*, Instance*> instances;

  Module* cpyMod = tmp->newModuleDecl("DesignTop", c->Record(rc));
  auto cpyDef = cpyMod->newModuleDef();
  ws[def->sel("self")] = cpyDef->sel("self");
  for (auto field : cpyMod->getType()->getFields()) {
    ws[def->sel("self")->sel(field)] = cpyDef->sel("self")->sel(field);
  }
  for (auto inst : def->getInstances()) {
    auto instPtr = inst.second;
    auto cpyInst = cpyDef->addInstance(inst.first, instPtr->getModuleRef(), instPtr->getModArgs());
    instances[instPtr] = cpyInst;
  }

  cout << "Copying connections.." << endl;
  
  for (auto& oldConn : def->getSortedConnections()) {
    Wireable* fst = oldConn.first;
    Wireable* snd = oldConn.second;

    cpyDef->connect(replaceBase(fst, ws, instances, cpyDef), replaceBase(snd, ws, instances, cpyDef));
  }
  cout << "Done copying connections.." << endl;

  cpyMod->setDef(cpyDef);
  cout << "cpyMod..." << endl;
  cpyMod->print();

  // Create copy w/o reset
  n->eraseModule("DesignTop");
  copyModuleTo(cpyMod, c->getNamespace("global"));

   //Copy module to top
  saveToFile(c->getGlobal(), fileName, c->getGlobal()->getModule("DesignTop"));
  
  deleteContext(c);
}
