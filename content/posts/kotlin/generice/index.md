# Generic

What is Generic in Java or Kotlin? What is `Invariance`, `Convariance`, and `Contravariance`? I have been asking those things for a long day. So, we're gonna dive into **"Generic"** in Kotlin. There are a lot of concepts that we have to know. We're gonna break down those concepts.

Before we dive into it, we have to know what `Derived type` is. This is an important `term` if you don't know it.

## Derived Type

The first thing is `Derived Type`. It is a class that **inherits** properties from its superclass.

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

As you can see, we can **omit some properties** by inheriting a class. That's why we use inherit in `kotlin`. But this one is a problem when we use `Generic` in Kotlin. Before we dive into what the problems are, we have to know what is **Generic** in Kotlin.

## Generic

According to Wikipedia, **Generic** means the following sentences below.

> Generic programming is a style of computer programming in which algorithms are written in terms of data types to-be-specified-later that are then instantiated when needed for specific types provided as parameters

Which means we can pass a specific type as an argument to **Generic parameters**. Seeing the Generic as a parameter is important to understand the concept of how it works.

Imagine we write the code below.

```kotlin
class TrashBox(
    val list: List<Any> = listOf()
) {

    fun add(ele: Any) = Box(list + listOf(ele))
}

class Box<T>(
    val list: List<T> = listOf()
) {

    fun add(ele: T) = Box(list + listOf(ele))
}

fun main() {
    val box: TrashBox = TrashBox()
    val box2: TrashBox = TrashBox()

    box.add(
        OriginalClass(
            name = "roach",
            age = 24
        ),
    ).add(
        DerivedClass()
    ).list.prettyPrint()

    println("====================")

    box2.add(DerivedClass()).list.prettyPrint()
}

private fun List<*>.prettyPrint(): Unit {
    for (ele in this) {
        println(ele)
    }
}
```

What if we write code like the above? This code will be working correctly without error. Because, we use `Any` type. But What if we use a **specific method of the Derived class not contained in Original Class** to the element popping out from the list?

```kotlin
(box.list[0] as DerivedClass).hello()
```

We must write code like this above. Do you think Is it really type-safety? The answers is not!. This is why you have to use "Generic" in Kotlin. So, we're gonna dive into Generic in the next step.

## Generic

If we use Generic, we can write the code like below **without compile errors**. and Even helping the auto-correction from Idea to find what method we have. It would be a safer way of writing code.

```kotlin
fun main() {
    val box: Box<OriginalClass> = Box<OriginalClass>()
    val box2: Box<DerivedClass> = Box<DerivedClass>()

    box.add(
        OriginalClass(
            name = "roach",
            age = 24
        ),
    ).add(
        DerivedClass()
    ).list.prettyPrint()

    println("====================")
    val _box2 = box2.add(DerivedClass())
    _box2.list.prettyPrint()

    println(_box2.list[0].hello()) // hello
}
```

How does it work and can we see the logical errors even at **compile time**? We have changed only Generic type of Box. According to [Oracle docs](https://www.oracle.com/technical-resources/articles/java/juneau-generics.html), The Generic type of the container will **be gone** (or replaced into a specific type) after compile-time. So, This is because of how **the compiler knows exactly what type is being stored**. It is the most important feature because you can save your time in **compile time**, not runtime. It is called the fail fast approach.