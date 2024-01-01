// Program to count primes. Not great code, but I wanted something that
// could run in 16 KB and took time, and not optimizable (and with
// unpredictable branches). Size is for just countPrimes() with gcc -O1
//
// SZ = 1000 -> 3713160 primes, all primes up to 7919^2 = 62710561
//   2.820 sec i7 8650U @ 3900 MHz           243 bytes  11.0 billion clocks
//   2.872 sec i7 6700K @ 4200 MHz           240 bytes  12.1 billion clocks
//   4.868 sec i7 3770  @ 3900 MHz           240 bytes  19.0 billion clocks
//   9.740 sec i7 6700K qemu-riscv           182 bytes  40.9 billion clocks
//  11.445 sec Odroid XU4 A15 @ 2 GHz        204 bytes  22.9 billion clocks
//  17.394 sec RISCV U74 @1500 MHz (est)     226 bytes  26.1 billion clocks
//  19.500 sec Odroid C2 A53 @ 1536 MHz A64  276 bytes  30.0 billion clocks
//  23.940 sec Odroid C2 A53 @ 1536 MHz T32  204 bytes  36.8 billion clocks
//  24.636 sec i7 6700K qemu-arm             204 bytes 103.5 billion clocks
//  25.060 sec i7 6700K qemu-aarch64         276 bytes 105.3 billion clocks
//  30.420 sec Pi3 Cortex A53 @ 1.2 GHz T32  204 bytes  36.5 billion clocks
//  47.910 sec Pi2 Cortex A7 @ 900 MHz T32   204 bytes  42.1 billion clocks
// 112.163 sec HiFive1 RISCV E31 @ 320 MHz   182 bytes  35.9 billion clocks
// 260.907 sec RISCV U74 @ 100 MHz FPGA      226 bytes  26.1 billion clocks

#include <stdio.h>

#define SZ 1000
int primes[SZ], sieve[SZ];
int nSieve = 0;

int countPrimes(){
  primes[0] = 2; sieve[0] = 4; ++nSieve;
  int nPrimes = 1, trial = 3, sqr=2;
  while (1){
    while (sqr*sqr <= trial) ++sqr;
    --sqr;
    for (int i=0; i<nSieve; ++i){
      if (primes[i] > sqr) goto found_prime;
      while (sieve[i] < trial) sieve[i] += primes[i];
      if (sieve[i] == trial) goto try_next;
    }
    break;
  found_prime:
    if (nSieve < SZ){
      primes[nSieve] = trial;
      sieve[nSieve] = trial*trial;
      ++nSieve;
      // printf("Saved %d: %d\n", nSieve, trial);
    }
    ++nPrimes;
  try_next:
    ++trial;
  }
  return nPrimes;
}

int main(){
  int res = countPrimes();
  dprintf(2,"%d primes found\n", res);
  return 0;
}
