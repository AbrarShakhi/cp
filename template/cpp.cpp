#include <bits/stdc++.h>
#pragma GCC optimize("O3,unroll-loops")
#pragma GCC target("avx2,bmi,bmi2,popcnt")

// ─── Types ───────────────────────────────────────────────────────────────────
// clang-format off
using i8 = int8_t;  using i16 = int16_t;    using i32 = int32_t;    using i64 = int64_t;
using u8 = uint8_t; using u16 = uint16_t;   using u32 = uint32_t;   using u64 = uint64_t;
using f32 = float;  using f64 = double;     using f80 = long double;
using str = std::string;
template <class T> using vec = std::vector<T>;
template <class T> using pq = std::priority_queue<T>;
template <class T> using pqlo = std::priority_queue<T, vec<T>, std::greater<T>>;
using pii = std::pair<i32, i32>;    using pll = std::pair<i64, i64>;

// ─── Keywords ────────────────────────────────────────────────────────────────
#define let auto
#define def inline auto
#define fn signed
#define val const auto

// ─── Debug (compile with -DLOCAL to enable) ──────────────────────────────────
#ifdef LOCAL
template <class T> std::ostream &operator<<(std::ostream &os, vec<T> const &v) {
  os << '[';
  for (int i = 0; i < sz(v); i++) { if (i) os << ','; os << v[i]; }
  return os << ']';
}
template <class A, class B> std::ostream &operator<<(std::ostream &os, std::pair<A, B> const &p) {
  return os << '(' << p.fi << ',' << p.se << ')';
}
#define dbg(x) (std::cerr << #x << " = " << (x) << '\n')
#else
#define dbg(x) ((void)0)
#endif

// ─── Input ───────────────────────────────────────────────────────────────────
def ini32() { i32 x; std::cin >> x; return x; }
def ini64() { i64 x; std::cin >> x; return x; }
def inu64() { u64 x; std::cin >> x; return x; }
def inf64() { f64 x; std::cin >> x; return x; }
def inchar() { char x; std::cin >> x; return x; }
def instr() { str x; std::cin >> x; return x; }
def inln() { str x; std::getline(std::cin, x); return x; }

template <class T = i64> def invec(i64 n) {
  vec<T> v(n);
  for (auto &x : v) std::cin >> x;
  return v;
}
template <class T = i64> def ingrid(i64 r, i64 c) {
  vec<vec<T>> g(r, vec<T>(c));
  for (auto &row : g) for (auto &x : row) std::cin >> x;
  return g;
}
template <class A = i64, class B = A> def inpair() {
  A a; B b; std::cin >> a >> b; return std::pair<A, B>{a, b};
}

// ─── Output ──────────────────────────────────────────────────────────────────
template <class T, class = void> struct _is_range : std::false_type {};
template <class T> struct _is_range<T, std::void_t<decltype(std::begin(std::declval<T &>())),
decltype(std::end(std::declval<T &>()))>> : std::true_type {};
template <class T> constexpr bool _rangeable =
  _is_range<T>::value && !std::is_convertible<std::decay_t<T>, std::string_view>::value;

struct _Out {
  std::string_view s = " ", e = "\n";
  _Out sep(std::string_view sv) const { return {sv, e}; }
  _Out end(std::string_view ev) const { return {s, ev}; }
  template <class... Args> void operator()(Args &&...args) const {
    int i = 0;
    auto pr = [&](auto &&x) {
      if (i++) std::cout << s;
      if constexpr (_rangeable<std::decay_t<decltype(x)>>) {
        bool f = true;
        for (auto &el : x) { if (!f) std::cout << s; std::cout << el; f = false; }
      } else { std::cout << x; }
    };
    (pr(args), ...); std::cout << e;
  }
} out;

// ─── Constants ───────────────────────────────────────────────────────────────
constexpr i64 INF = 4e18;
constexpr i32 INF32 = 2e9;
constexpr f64 EPS = 1e-9;
constexpr i64 MOD = 1e9 + 7;

// ─── Math ────────────────────────────────────────────────────────────────────
def pw(i64 b, i64 exp, i64 m = MOD) -> i64 {
  i64 r = 1;
  b %= m;
  for (; exp; exp >>= 1, b = b * b % m)
    if (exp & 1) r = r * b % m;
  return r;
}
def inv_mod(i64 a, i64 m = MOD) { return pw(a, m - 2, m); }

// ─── Helpers ─────────────────────────────────────────────────────────────────
def yes(bool b = true) { std::cout << (b ? "YES" : "NO") << '\n'; }
def no() { yes(false); }

// ─── Macros ──────────────────────────────────────────────────────────────────
#define fi first
#define se second
#define all(x) std::begin(x), std::end(x)
#define rall(x) std::rbegin(x), std::rend(x)
#define sz(x) (i64)(x).size()
#define rep(i, n) for (i64 i = 0; i < (n); ++i)
#define repf(i, a, b) for (i64 i = (a); i < (b); ++i)
#define repr(i, n) for (i64 i = (n) - 1; i >= 0; --i)
#define each(x, v) for (auto &x : (v))
// clang-format on

// ─── Solution ────────────────────────────────────────────────────────────────
def solution() {
}

int main() {
  std::ios_base::sync_with_stdio(false);
  std::cin.tie(nullptr);

  let t = ini64();
  while (t--) {
    // let ans =
    solution();
  }
}
