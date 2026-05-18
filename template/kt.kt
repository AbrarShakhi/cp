import java.io.*
import java.util.*

// ─── I/O ─────────────────────────────────────────────────────────────────────
private val br = System.`in`.bufferedReader()
private val bw = PrintWriter(BufferedWriter(OutputStreamWriter(System.out)))

private var _st = StringTokenizer("")
private fun nextTok(): String {
    while (!_st.hasMoreTokens()) _st = StringTokenizer(br.readLine() ?: "")
    return _st.nextToken()
}

fun inInt()    = nextTok().toInt()
fun inLong()   = nextTok().toLong()
fun inDouble() = nextTok().toDouble()
fun inStr()    = nextTok()
fun inLine()   = br.readLine()!!

fun inInts(n: Int)   = IntArray(n)    { inInt() }
fun inLongs(n: Int)  = LongArray(n)   { inLong() }
fun inDoubles(n: Int)= DoubleArray(n) { inDouble() }
fun inStrs(n: Int)   = Array(n)       { inStr() }

fun inIntGrid(r: Int, c: Int)  = Array(r) { inInts(c) }
fun inLongGrid(r: Int, c: Int) = Array(r) { inLongs(c) }

// ─── Output ──────────────────────────────────────────────────────────────────
private fun Any.fmt(sep: String): String = when (this) {
    is IntArray    -> joinToString(sep)
    is LongArray   -> joinToString(sep)
    is DoubleArray -> joinToString(sep)
    is BooleanArray-> joinToString(sep)
    is Array<*>    -> joinToString(sep) { it?.fmt(sep) ?: "null" }
    is Iterable<*> -> joinToString(sep) { it?.fmt(sep) ?: "null" }
    else           -> toString()
}

// out(1, 2, 3)                         => "1 2 3\n"
// out(arr)                             => elements space-separated
// out(1, 2, sep = ",", end = "")       => "1,2"
fun out(vararg args: Any, sep: String = " ", end: String = "\n") {
    bw.print(args.joinToString(sep) { it.fmt(sep) })
    bw.print(end)
}

// ─── Constants ───────────────────────────────────────────────────────────────
const val INF   = Long.MAX_VALUE / 2
const val INF32 = Int.MAX_VALUE / 2
const val MOD   = 1_000_000_007L
const val EPS   = 1e-9

// ─── Math ────────────────────────────────────────────────────────────────────
fun pw(b: Long, exp: Long, m: Long = MOD): Long {
    var r = 1L; var base = b % m; var e = exp
    while (e > 0) {
        if (e and 1L == 1L) r = r * base % m
        base = base * base % m; e = e shr 1
    }
    return r
}

fun gcd(a: Long, b: Long): Long = if (b == 0L) a else gcd(b, a % b)
fun lcm(a: Long, b: Long): Long = a / gcd(a, b) * b
fun invMod(a: Long, m: Long = MOD) = pw(a, m - 2, m)

// ─── Helpers ─────────────────────────────────────────────────────────────────
fun yes(b: Boolean = true) = bw.println(if (b) "YES" else "NO")
fun no() = yes(false)

fun <T : Comparable<T>> chmin(a: T, b: T) = minOf(a, b)
fun <T : Comparable<T>> chmax(a: T, b: T) = maxOf(a, b)

// ─── Debug (active when launched with LOCAL=1 env var) ───────────────────────
val LOCAL = System.getenv("LOCAL") != null
fun dbg(vararg args: Any) { if (LOCAL) System.err.println(args.joinToString(" ") { it.fmt(" ") }) }

// ─── Solution ────────────────────────────────────────────────────────────────
fun solution() {

}

fun main() {
    val t = inInt()
    repeat(t) { solution() }
    bw.flush()
}
