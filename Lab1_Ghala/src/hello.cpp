#include "name.hpp"

#include <iostream>
#include <string>
using namespace std;

int main() {
    string name = ask_name();
    if (name.empty()) {
        cout << "Hello!\n";
    } else {
        cout << "Hello " << name << "!\n";
    }
    return 0;
}
