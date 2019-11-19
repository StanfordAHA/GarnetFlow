#include "coreir.h"

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

  for (auto field : top->getType()->getFields()) {
    cout << "Name: " << field << endl;
    auto port = def->sel("self")->sel(field);
    if (!hasConnection(port)) {
      cout << "\t" << field << " has no connections" << endl;
    }
  }
  Namespace* tmp = c->newNamespace("tmp");
  //Module* m = tmpCpy;
  // Create copy w/o reset
  n->eraseModule("DesignTop");

  assert(false);
  // Copy module to top
  //
  saveToFile(c, "/tmp/absolute.json");
  

  deleteContext(c);
}
