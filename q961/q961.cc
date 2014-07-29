// https://codeiq.jp/ace/ozy_hikoboshi/q961
// clang++ -O2 q961.cc -o q961; time ./q961
// author : @naoki_kp

#include <iostream>
using namespace std;

// φ(n) = nΠ(1-1/Pk)
// 7:25,  40:949,  41:981,  1000:607585,
// 77777:3677453621,  7777777:36775823261333

typedef unsigned long long ull;
const int S = 7777777;
unsigned int phi[S];

int main(){
    ull res = 0;
    for(int i = 2; i < S; i++) phi[i] = i;
    for(int i = 2; i < S; i++){
        if(phi[i] == i){ // is prime?
            for(int j = i; j < S; j += i){
                phi[j] = phi[j] / i * (i-1);
            }
        }
        res += phi[i];
    }
    cout << res*2+3 << endl;
    return 0;
}
