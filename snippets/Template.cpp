#include <bits/stdc++.h>
#ifndef DEBUG
#pragma GCC optimize("O3,unroll-loops")
#pragma GCC target("avx2,bmi,bmi2,popcnt")
#endif

inline auto solution() {
  int64_t n;
  std::cin >> n;
  return n;
}

int main() {
  std::ios_base::sync_with_stdio(false);
  std::cin.tie(nullptr);

  int64_t t = 1;
  std::cin >> t;
  while (t--) {
    auto ans = solution();
    std::cout << ans << "\n";
  }
}
