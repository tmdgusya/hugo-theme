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

We must write code like this above. Do you think Is it really type-safety? The answer is not! This is why you have to use "Generic" in Kotlin. So, we're gonna dive into Generic in the next step.

## Generic

If we use Generic, we can write the code like the code below **without compile errors**. and Even helping the auto-correction from Idea to find what method we have. It would be a safer way of writing code.

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

How does it work? And can we see the logical errors even at **compile time**? We have changed only Generic type of Box. According to [Java Q&A](http://www.angelikalanger.com/GenericsFAQ/FAQSections/ParameterizedTypes.html#What%20is%20a%20parameterized%20(or%20generic)%20type?), The Generic type of the container will **replaced into a specific type or wild-card type after compile-time**. So, This is because of how **the compiler knows exactly what type is being stored**. It is the most important feature because you can save your time in **compile time**, not runtime. It is called the fail fast approach.

## The problems

I'll show you the problem. Do you think this code will be working correctly?

```kotlin
class Wrapper<T>(
    private val contained: T,
) {
    fun next(): T {
        return contained
    }
}

fun helloTo(parent: Wrapper<Any>) {
    println(parent)
}

fun main() {
    val parents = Wrapper<Parent>(Parent())

    val children = Wrapper<Child>(Child())

    helloTo(parents)
}
```

you might say it will be okay unless you know the fact that **there isn't the super-subtype-relationship of the component types**. But, Errors occur in compile time. Like the photo below.

![Screenshot from 2023-08-22 01-07-54](https://github.com/go-swagno/examples/assets/57784077/13c594b3-7ec0-48fd-bf36-797c5853dbeb)

Why did it work like this above? Why do errors occur? This is because **there isn't super-subtype-relationship**. It is so important to understand the system for Generic. So, we have to add **'extends Object'** at type parameter in Java like the code below, which indicates that the type parameter inherits the Object type. **To make a relationship** between two types.

The `term` indicating there is no relationship among the type is called **"invariance"**. So, Generic is working based on invariance.

```java
class Wrapper<T extends Object>
```

---
If you don't fully understand why it has to be working based-on invariance, see the below code.

```kotlin
fun main() {
    val children = mutableListOf(Child())
    val parents: MutableList<Parent> = children
    parents.add(Parent()) // they shared their state
    val child = children.get(1) // You must be having issues when you will get here.
}
```

## Covariant

To fix this in Kotlin, We have to add **'out' modifier** in Type parameter like the code below.

```kotlin
class Wrapper<out T>(
    private val contained: T,
) {
    fun next(): T {
        return contained
    }
}

fun helloTo(parent: Wrapper<Any>) {
    println(parent)
}

fun main() {
    val parents = Wrapper<Parent>(Parent())

    val children = Wrapper<Child>(Child())

    helloTo(parents)
```

As you can see, we can **make the type-relationship** as **added `out` in Type parameter**. Why does it work? To understand this, we should imagine the other case to put the other type instant into a contained like the code below.

```kotlin
fun main() {
    val children = mutableListOf(Child())
    val parents: MutableList<Parent> = children // compile error: Type mismatch.
    parents.add(Parent()) // they shared their state
    val child = children.get(1)
}
```

This code can not be compiled because of the way of working of Generic system I mentioned. So, we need to change the Generic type of `parents` variable into `out Parent`.

```kotlin
fun main() {
    val children = mutableListOf(Child())
    val parents: MutableList<out Parent> = children
    parents.add(Parent()) // compile error: Type mismatch.
    val child = children.get(1)
}
```

Because it can prohibit to be put the other type even if it was a super type of this. Now, we can guarantee the child variable can always be `Child` Type. We have to fix the code like the code below.

```kotlin
fun main() {
    val children = mutableListOf(Child())
    val parents: MutableList<out Parent> = children
    parents.add(Child())
    val child = children.get(1)
}
```

![Screenshot from 2023-08-22 01-48-08](https://github.com/go-swagno/examples/assets/57784077/7d9a93fb-1f9f-42e2-8801-f1ee928e1a62)

As you can see, the modifier `out` is in the Type parameter in List, however, there is no `out` modifier in MutableList. This is because they are following the rule of Joshua Bloch.

> "For maximum flexibility, use wildcard types on input parameters that represent producers or consumers", and proposes the following mnemonic: PECS stands for Producer-Extends, Consumer-Super.

In Kotlin, `List` is **Producer** not even Consumer. So, `List` can take the `out` modifier as a Producer. That means If we create the Consumer class using Generic to use it generally, we can add the `out` modifier in Our class. I guess you could fully understand it.

To use `out` modifier is in Kotlin. The type declared `out` is used in **only the out-position** in the members of a class. That means you can not this type as a member function's parameter. you can only use it as a return type.

## Contravariant

Contravariant is complementary variance annotation. I've told you the concept of `Covariant` a lot, so I won't talk as much as before in this part.

```kotlin
fun main() {
    val children = mutableListOf(Child())
    val grands = mutableListOf(
        Grand(),
        SuperGrand()
    )
    val parents: MutableList<in Parent> = grands
    val parent: Grand = parents.get(1) // Type error: Found: Any?
}
```

As you can see, there is a reason why **do not consume** the element from that. You can not expect what type of element will pop out. But, If I stop explaining this concept, you would have an wondering why it is needed for Kotlin.

Imagine that **you have to sort instants have the various types**, which inherit the same class like the code below.


```kotlin
public interface Comparable<in T> {
    /**
     * Compares this object with the specified object for order. Returns zero if this object is equal
     * to the specified [other] object, a negative number if it's less than [other], or a positive number
     * if it's greater than [other].
     */
    public operator fun compareTo(other: T): Int
}

open class Parent(
    open val age: Int,
): Grand(), Comparable<Parent> {
    open fun doSomething() {
        print("Parent-do")
    }
    
    override fun toString(): String {
        return "Parent(age: $age)"
    }

    override fun compareTo(other: Parent): Int = when {
        this.age > other.age -> 1
        this.age == other.age -> 0
        else -> -1
    }
}

fun main() {
    val children = mutableListOf(Child(30), Child(50), Child(10))
    val parents: MutableList<out Parent> = children
    val sorted = parents.sortedWith(Parent::compareTo)

    println(sorted)
}
```
So, you can easily use `in` modifier here. Because **they already have methods received from their parents**. So, we have to use `in` modifier when we only consume the type we declared in Type parameter, not produce. Imagine that you can write `out` modifier in Comparable class instead of `in` modifier, then **you can not use GrandParent method to compare children** like the code below.

```kotlin
fun main() {
    val children = mutableListOf(Child(30), Child(50), Child(10))
    val parents: MutableList<out Parent> = children
    val sorted = parents.sortedWith(Grand::compareTo)

    println(sorted)
}
```

## Conclusion

It is the hard part of Kotlin, to use it properly is also hard. So, you have to see the code that properly used those concepts we learned in Kotlin default library or open-source.