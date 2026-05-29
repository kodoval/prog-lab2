fun main() {
    print("Enter string: ")
    val s = readLine() ?: ""
    val unique = s.filter { it in 'a'..'z' }.toSet()
    println(if (unique.size == 26) "Yes" else "No")
}
