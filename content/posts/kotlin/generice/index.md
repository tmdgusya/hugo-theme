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