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
  cout << "Replacing: " << CoreIR::toString(*toReplace) << endl;

  if (toReplace->getKind() == Wireable::WK_Interface) {
    cout << "Is interface" << endl;
    return map_find(toReplace, ws);
  }

  if (toReplace->getKind() == Wireable::WK_Instance) {
    cout << "Is instance" << endl;
    return map_find(static_cast<Instance*>(toReplace), instances);
  }

  assert(toReplace->getKind() == Wireable::WK_Select);
  auto sel = static_cast<Select*>(toReplace);
  cout << "Is select:" << endl;
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

int main(const int argc, const char** argv) {

  //std::string fileName = "/tmp/conv_2_1_lakelib.json";
  std::string fileName = "/tmp/absolute_lakelib.json";
  //conv_2_1_lakelib.json";
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
      changed = inlineInstance(inst.second);
      //cout << "Changed = " << changed << endl;
      top->print();
      if (changed) {
        break;
      }
    }
  }

  c->runPasses({"deletedeadinstances"});

  cout << "After inlining..." << endl;
  top->print();

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
 
  //saveToFile(c->getGlobal(), fileName, c->getGlobal()->getModule("DesignTop"));
  
  deleteContext(c);
}
