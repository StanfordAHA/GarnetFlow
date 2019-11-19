#include "coreir.h"

using namespace std;
using namespace CoreIR;

int main(const int argc, const char** argv) {

  Context* c = newContext();
  if (!loadFromFile(c, "/tmp/absolute.json")) {
    cout << "Could not Load from json!!" << endl;
    c->die();
  }


  Namespace* n = c->getNamespace("global");
  Module* top = n->getModule("DesignTop");

  Namespace* tmp = c->newNamespace("tmp");
  // Create copy w/o reset
  n->eraseModule("DesignTop");

  assert(false);
  // Copy module to top
  //
  saveToFile(c, "/tmp/absolute.json");
  

  deleteContext(c);
}
