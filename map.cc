#include <bits/stdc++.h>
using namespace std;

int main() {
  string str;
  unordered_map<string, int> strmp;
  bool isRenzoku = true;
  while (cin >> str) {
    if (strmp[str]!=-1) {
      strmp[str] = -1;
      cout << str << endl;
    }
  }
}

