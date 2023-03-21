#include <bits/stdc++.h>
using namespace std;

int main() {
  string str;
  unordered_map<string, int> strmp;
  bool isRenzoku = true;
  while (cin >> str) {
    if (str=="EOF") break;
    strmp[str]++;
  }
  vector<pair<int, string>> intPAIRstring(0);
  for (auto itr=strmp.begin();itr!=strmp.end();itr++) {
  	pair<int, string> tmp;
  	tmp.first = itr->second;
  	tmp.second = itr->first;
  	intPAIRstring.push_back(tmp);
  }
  sort(intPAIRstring.rbegin(), intPAIRstring.rend());
  
  for (int i=0;i<intPAIRstring.size();i++)
    cout << intPAIRstring.at(i).first << "," << intPAIRstring.at(i).second << "\n";
}

