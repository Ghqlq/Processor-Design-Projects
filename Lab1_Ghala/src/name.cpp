#include "name.hpp"

#include <iostream>
#include <string>
using namespace std;

string ask_name() {
    cout << "What's your name? " << flush;
    string name;
    getline(cin, name);
    return name;
}
