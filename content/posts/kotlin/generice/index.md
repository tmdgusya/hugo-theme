# Generic

Today, we're gonna dive into **"Generic"** in Kotlin. There are a lot of concepts that we have to know. We're gonna break down those concepts.

## Derived Type

The first thing is `Derived Type`. Derive Type is a typical class that **inherites** properties from its super class.

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

We can **omit some properties** by inheriting something. That's why we use inherit in `kotlin`. But this one is a problem when we use `Generic` in Kotlin. 