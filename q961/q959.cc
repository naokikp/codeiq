// https://codeiq.jp/ace/ozy_hikoboshi/q959
// clang++ -O2 q959.cc -o q959; time ./q959
// author : @naoki_kp

#include <iostream>
const int S = 7;
int gcd(int n, int m){return m ? gcd(m, n%m) : n;}
int main(){
    int res = 0;
    for(int y = 1; y < S; y++)
        for(int x = y + 1; x < S; x++)
            if(gcd(x,y) == 1) res++;
    std::cout << res*2+3 << std::endl;
}
