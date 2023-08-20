# Generic

What is Generic in Java or Kotlin? What is `Invariance`, `Convariance`, and `Contravariance`? I have been asking those things for a long day. So, we're gonna dive into **"Generic"** in Kotlin. There are a lot of concepts that we have to know. We're gonna break down those concepts.

Before we dive into it, we have to know what `Derived type` is. This is an important `term` if you don't know it.

## Derived Type

The first thing is `Derived Type`. **Derive Type** is a class that **inherits** properties from its superclass.

```kotlin
open class OriginalClass(
    val name: String,
    val age: Int,
) {
    open fun getName_(): String = this.name
}

class DerivedClass: OriginalClass(
    name = "roach",
    age = 27
)

fun main() {
    val clazz: OriginalClass = DerivedClass()

    println(clazz.getName_())
}
```

As you can see, we can **omit some properties** by inheriting something. That's why we use inherit in `kotlin`. But this one is a problem when we use `Generic` in Kotlin. Before we dive into what the problems are, we have to know what is **Generic** in Kotlin.

## Generic

According to Wikipedia, **Generic** means the following sentences below.

> Generic programming is a style of computer programming in which algorithms are written in terms of data types to-be-specified-later that are then instantiated when needed for specific types provided as parameters

Which means we can pass a specific type as an argument to **Generic parameters**. Seeing the Generic as a parameter is important to understand the concept of how it works.

Imagine we write the code below.

```kotlin
open class OriginalClass(
    val name: String,
    val age: Int,
) {
    open fun getName_(): String = this.name

    override fun toString(): String {
        return "OriginalClass(name='$name', age=$age)"
    }
}

class DerivedClass: OriginalClass(
    name = "roach",
    age = 27
)

class Box<T>(
    val list: List<T> = listOf()
) {

    fun add(ele: T) = Box(list + listOf(ele))
}

fun main() {
    val box: Box<OriginalClass> = Box()
    val box2: Box<DerivedClass> = Box()

    box.add(
        OriginalClass(
            name = "roach",
            age = 24
        )
    ).list.prettyPrint()

    box2.add(DerivedClass()).list.prettyPrint()
}

private fun List<*>.prettyPrint(): Unit {
    for (ele in this) {
        print(ele)
    }
}
```

What if we write code like the above? Thie code will be working correctly. How does it work and can we see the logical errors even at **compile time**? We have changed only Generic type of Box.

According to [Oracle docs](https://www.oracle.com/technical-resources/articles/java/juneau-generics.html), The Generic type of the container will **replace the given type** when it is instantiated. That is why we must write the type in the angle bracket notation.

Another advantage is **the compiler knows exactly what type is being stored**. It is the most important feature because you can save your time in **compile time**, not runtime.

### What are the advantages of using Generics?

// Explain, What if there is no Generic in Type concept. (Using Go-lang (low-version) for example)

// refer to: https://www.oracle.com/technical-resources/articles/java/juneau-generics.html