import java.io.*
import java.util.*

private val br = System.`in`.bufferedReader()
private val bw = PrintWriter(BufferedWriter(OutputStreamWriter(System.out)))

private var _st = StringTokenizer("")
private fun nextTok(): String {
    while (!_st.hasMoreTokens()) _st = StringTokenizer(br.readLine() ?: "")
    return _st.nextToken()
}

private fun inInt()    = nextTok().toInt()
private fun inLong()   = nextTok().toLong()
private fun inDouble() = nextTok().toDouble()
private fun inStr()    = nextTok()
private fun inLine()   = br.readLine()!!
private fun inInts(n: Int)   = IntArray(n)    { inInt() }
private fun inLongs(n: Int)  = LongArray(n)   { inLong() }
private fun inDoubles(n: Int)= DoubleArray(n) { inDouble() }
private fun inStrs(n: Int)   = Array(n)       { inStr() }
private fun inIntGrid(r: Int, c: Int)  = Array(r) { inInts(c) }
private fun inLongGrid(r: Int, c: Int) = Array(r) { inLongs(c) }

private fun Any.fmt(sep: String): String = when (this) {
    is IntArray    -> joinToString(sep)
    is LongArray   -> joinToString(sep)
    is DoubleArray -> joinToString(sep)
    is BooleanArray-> joinToString(sep)
    is Array<*>    -> joinToString(sep) { it?.fmt(sep) ?: "null" }
    is Iterable<*> -> joinToString(sep) { it?.fmt(sep) ?: "null" }
    else           -> toString()
}

private fun out(vararg args: Any, sep: String = " ", end: String = "\n") {
    bw.print(args.joinToString(sep) { it.fmt(sep) })
    bw.print(end)
}

private const val INF   = Long.MAX_VALUE / 2
private const val INF32 = Int.MAX_VALUE / 2
private const val MOD   = 1_000_000_007L
private const val EPS   = 1e-9

private fun solution() {
}

fun main() {
    val t = inInt()
    repeat(t) {
        solution()
    }
    bw.flush()
}
