+++
title = "What is redirection in OS" 
author = "tmdgusya" 
cover= "posts/unix/logo.png"
+++
# What is redirection in OS?

Have you heard about **redirection in OS**? If not then this article is for you. In this article, we will learn about redirection in OS.

## Introduce Standard Input, Output, and Error

<img width="302" alt="image" src="https://github.com/tmdgusya/Study-Java-File-Stream/assets/57784077/1653ab4c-a32b-4844-b130-11af3ca3a8fd">

[The photo is from here](https://en.wikipedia.org/wiki/Redirection_(computing))

Initially, The I/O only happened through **a physically connected system console**. (input via keyboard, output via monitor), As time passed, the I/O devices(input via mouse, or touch-pad, etc) were added to the system. So, the **standard input, output, and error** were introduced.

Standard Stream abstracts this aspect to satisfy the program's needs to customize the input and output. The standard stream is a **pre-connected input and output communication channel** between a computer program and its environment when it begins execution. The three input/output (I/O) connections are called **standard input (stdin), standard output (stdout), and standard error (stderr)**.

So, Today, we are going to learn about **redirection in OS**.  Let's get started.

## What is redirection?

**Redirection** is a feature in Linux such that when executing a command, you can change the standard input/output devices. If you do not understand what it is, then don't worry. I'll show you some examples.

What is my console's standard output of the `ls -a` command? That might be a console.

<img width="290" alt="image" src="https://github.com/tmdgusya/zoomkoding-gatsby-blog/assets/57784077/6f74830f-aa96-4838-a0aa-60840af372f3">

As you can see, the standard output of `ls -a` command is a console. But, what if I want to save the standard output of `ls -a` command to a file? Then, I can use **redirection**.

```
ls -a > output.txt
```

<img width="301" alt="image" src="https://github.com/tmdgusya/zoomkoding-gatsby-blog/assets/57784077/eb270d52-b20c-49a2-a3e1-ebbcfc6e1a82">

As you can see, the standard output of `ls -a` command is saved to `output.txt` file. This is what **redirection** is.

### Redirect Standard Input

The standard input is the default source of data for a program or process. The standard input is usually the keyboard, but it depends on the system. The standard input is usually represented in a program by the file handle `stdin`.

I'll show you how to redirect standard input. Let's say I have an `input.txt` file that contains the following text.

```
Hello, World!
```

And I want to print the text in the `input.txt` file to the console. Then, I can use **redirection**.

```
cat < input.txt
```

<img width="253" alt="image" src="https://github.com/tmdgusya/Study-Java-File-Stream/assets/57784077/a7846e72-9ad7-4456-a6b1-d9b0acbdc219">

I think you already understand what **redirection** is. Let's move on to the next section. I guess you may want to learn about how it works under the hood. So, In the next post, I'm gonna show you about **file descriptor**.



