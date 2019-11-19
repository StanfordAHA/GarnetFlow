#include "coreir.h"

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

int main(const int argc, const char** argv) {

  Context* c = newContext();
  if (!loadFromFile(c, "/tmp/absolute.json")) {
    cout << "Could not Load from json!!" << endl;
    c->die();
  }

  Namespace* n = c->getNamespace("global");
  Module* top = n->getModule("DesignTop");
  auto def = top->getDef();
  assert(def != nullptr);

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
  for (auto field : cpyMod->getType()->getFields()) {
    ws[def->sel("self")->sel(field)] = cpyDef->sel("self")->sel(field);
  }
  for (auto inst : def->getInstances()) {
    auto instPtr = inst.second;
    auto cpyInst = cpyDef->addInstance(inst.first, instPtr->getModuleRef(), instPtr->getModArgs());
    instances[instPtr] = cpyInst;
  }
  cpyMod->setDef(cpyDef);
  cout << "cpyMod..." << endl;
  cpyMod->print();

  // Create copy w/o reset
  n->eraseModule("DesignTop");

  // Copy module to top
  saveToFile(c, "/tmp/absolute.json");
  

  deleteContext(c);
}
