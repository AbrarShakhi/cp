import java.io.BufferedInputStream
import java.io.BufferedWriter
import java.io.OutputStreamWriter
import java.io.PrintWriter

private val LOCAL = System.getenv("LOCAL") != null

private fun Any.fmt(sep: String): String = when (this) {
    is IntArray -> joinToString(sep)
    is LongArray -> joinToString(sep)
    is DoubleArray -> joinToString(sep)
    is BooleanArray -> joinToString(sep)
    is CharArray -> String(this)
    is Array<*> -> joinToString(sep) { it?.fmt(sep) ?: "null" }
    is Iterable<*> -> joinToString(sep) { it?.fmt(sep) ?: "null" }
    is Sequence<*> -> joinToString(sep) { it?.fmt(sep) ?: "null" }
    else -> toString()
}

private class FastWriter {
    val writer = PrintWriter(BufferedWriter(OutputStreamWriter(System.out)))

    fun print(vararg args: Any, sep: String = " ", end: String = " "): FastWriter {
        writer.print(args.joinToString(sep) { it.fmt(sep) })
        writer.print(end)
        if (LOCAL) writer.flush()
        return this
    }
    fun println(vararg args: Any, sep: String = " ") = this.print(args, sep, end = "\n")
    fun debug(vararg args: Any) {
        if (LOCAL) System.err.println(args.joinToString(" ") { it.fmt(" ") })
    }
}

private class FastReader {
    private val input = BufferedInputStream(System.`in`, 1 shl 16)
    private val buffer = ByteArray(1 shl 16)
    private var ptr = 0
    private var len = 0

    private fun readByte(): Int {
        if (ptr == len) {
            len = input.read(buffer, 0, buffer.size)
            ptr = 0
        }
        if (len == -1) return -1
        return buffer[ptr++].toInt()
    }
    private fun skipWhitespace(): Int {
        var b = readByte()
        while (b != -1 && b <= ' '.code) b = readByte()
        return b
    }
    fun int(): Int {
        var b = skipWhitespace()
        val neg = b == '-'.code
        if (neg) b = readByte()
        var x = 0
        while (b in '0'.code..'9'.code) {
            x = x * 10 + (b - '0'.code)
            b = readByte()
        }
        return if (neg) -x else x
    }
    fun long(): Long {
        var b = skipWhitespace()
        val neg = b == '-'.code
        if (neg) b = readByte()
        var x = 0L
        while (b in '0'.code..'9'.code) {
            x = x * 10 + (b - '0'.code)
            b = readByte()
        }
        return if (neg) -x else x
    }
    fun string(): String {
        var b = skipWhitespace()
        val sb = StringBuilder()
        while (b > ' '.code) {
            sb.append(b.toChar())
            b = readByte()
        }
        return sb.toString()
    }
    fun line(): String {
        val sb = StringBuilder()
        var b = readByte()
        while (b != -1 && b != '\n'.code) {
            if (b != '\r'.code) sb.append(b.toChar())
            b = readByte()
        }
        return sb.toString()
    }
    fun double(): Double = string().toDouble()
    fun char(): Char = skipWhitespace().toChar()
    fun intArray(n: Int) = IntArray(n) { int() }
    fun longArray(n: Int) = LongArray(n) { long() }
    fun doubleArray(n: Int) = DoubleArray(n) { double() }
    fun stringArray(n: Int) = Array(n) { string() }
}

private val fr = FastReader()
private val fw = FastWriter()

private fun Any.log() = fw.println(this)

private const val INF = Long.MAX_VALUE / 2
private const val INF32 = Int.MAX_VALUE / 2
private const val MOD = 1_000_000_007L
private const val EPS = 1e-9

private fun solution(): Any? {
    return null
}

private val start = {
    val tc = fr.int()
    repeat(tc) { solution()?.log() }
    fw.writer.flush()
}

fun main() =
    start()
//    Thread(null, start, "main", 1 shl 26).start()
