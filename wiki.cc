#include <bits/stdc++.h>
using namespace std;

int main() {
  char c;
  bool isRenzoku = true;
  while (cin >> c) {
    if (c<32||c>127) {
      cout << c;
      isRenzoku = false;
    }
    else if (!isRenzoku) {
      cout << endl;
      isRenzoku = true;
    }
  }
}

