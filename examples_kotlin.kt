#1.1

data class Person(val name: String,
                 val age: Int? = null)

fun main(){
    val persons = listOf(Person("Alice"),
    					Person("Bob", age = 29))

    val oldest = persons.maxByOrNull {it.age ?: 0}
    println("The oldest is: $oldest")
}
==============================================

fun findAlice() = findPerson { it.name == "Alice" }
fun findBob() = findPerson { it.name == "Bob" }

==============================================

fun renderPersonList(persons: Collection<Person>) =
  createHTML().table {
    for (person in persons) {
      tr {
        td { +person.name}
        td { +person.age}
      }
    }
  }

==============================================

object CountryTable : IdTable() {
  val name = varchar("name", 250).uniqueIndex()
  val iso = varchar ("iso", 2).uniqueIndex()
}

class Country(id: EntityID) : Entity(id) {
  var name: String Ьу CountryTable.name
  var iso: String Ьу CountryTable.iso
}

val russia = Country.find {
  CountryTable.iso.eq("ru")
}.first()

println(russia.name)

==============================================

verticalLayout {
  val name = editText()
  button("Say Hello") {
      onClick { toast("Hello, ${name.text}!")}
    }
}

==============================================

В простейшем случае скомпилировать код из
командной строки можно с помощью команды kotlinc, а запустить - ко­мандой java:

kotlinc <исходный файл или каталог> -include-runtime -d <имя jаr-файла>
java -jar <имя jаr-файла>

==============================================

fun main() {
    println("Hello, world!")
}

==============================================

fun main(){
    fun max(a: Int, b: Int): Int {
	return if (a > b) a else b
	}
    println(max(1, 2))
}

==============================================

==============================================

==============================================

==============================================

==============================================

==============================================

==============================================

==============================================

==============================================

==============================================

==============================================
