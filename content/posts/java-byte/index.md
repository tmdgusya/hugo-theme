+++
title = "Why Java Stream API use int type, not a byte type?" 
author = "tmdgusya" 
cover= "posts/java-byte/logo.png"
+++

# Java bytes

When you are working with **I/O** in Java, you may have heard about **bytes**. What it used for? and Why do we need to know about it when we are working with **I/O** in Java? In this article, we will learn about **bytes** in Java. Let's get started.

## How Java's numeric types work?

First of all, We have to know about what byte in the java is. The byte is primitive type in Java. It has minimum value of **-128** and the maximum value of **127**.


Java compiler always read "50", "65600" as an **int literal**, never as a **byte or a short**. So that, How does the code below work?

```java
public static void main(String[] args) {
    byte b1 = (byte) 24;
    System.out.println(b1);
}
```

The reason is the assignment conversion is performed by compiler behind the scene. Effectively **casting the int literals to the narrower types**.

If we fit the number that exceeds the range of byte into a variable of byte type, then we have to **risk data loss** and write **explicitly casting** in the code.

```java
public class ByteTest {
    public static void main(String[] args) {
        byte b1 = (byte) 65600;
        System.out.println(b1); // 64
    }
}
```

Now we know what the byte is and what Java's numeric systems are. So we are going to go over why the write method of OutputStream returns an int type, not a byte type. 

## Why Java Stream API use int type, not a byte type?

```java
    /**
     * Writes the specified byte to this output stream. The general
     * contract for {@code write} is that one byte is written
     * to the output stream. The byte to be written is the eight
     * low-order bits of the argument {@code b}. The 24
     * high-order bits of {@code b} are ignored.
     * <p>
     * Subclasses of {@code OutputStream} must provide an
     * implementation for this method.
     *
     * @param      b   the {@code byte}.
     * @throws     IOException  if an I/O error occurs. In particular,
     *             an {@code IOException} may be thrown if the
     *             output stream has been closed.
     */
    public abstract void write(int b) throws IOException;
```

This method is one of the interface of OutputStream in Java. There's an important clarification. That is a "The byte to be written is the eight low-order bits of the argument given number. The 24 high-order bits of **given number are ignored**."

That means we might going to write the unexpected number to the OutputStream. Why does the write method of OutputStream have an argument as **int type, not a byte type** even though they have recognized this problem?

You should look at the code below to understand why the system was designed like that.

![](https://github.com/tmdgusya/kotlin-leetcode/assets/57784077/e3567f83-7580-470e-b72d-2712990b778e)

I guess you might not know this. Also, their is **the another problem**. 

![](https://github.com/tmdgusya/kotlin-leetcode/assets/57784077/ff2afb72-d4f3-4b76-966a-b971439674a9)

To solve this problem, you have to write explicitly casting in the code.

![](https://github.com/tmdgusya/kotlin-leetcode/assets/57784077/29176152-882a-483b-b7c8-320e061e7683)

## Conclusion

I guess the main reason that the OutputStream in Java uses int type as an argument and return type is that using byte type in the calculation is inconvenient. So we should know how it is going to be written into the other output to consider ignorance(data loss).