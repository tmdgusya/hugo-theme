+++
title = "What is user mode and kernel mode?" 
author = "tmdgusya" 
cover= "posts/linux_kernel/logo.png"
+++
# What is Kernel in Linux?

What is the **Linux kernel**? It might be challenging to answer if you haven't delved into this concept. When we decide to study the kernel, sometimes we find it exhausting due to the amount of information we need to grasp about the operating system.

So, I'm going to provide a brief introduction to the kernel and show you an example written in Go.

## How does process access to file?

![](https://hackmd.io/_uploads/SJP1kUDA3.png)

Have you ever wondered **how you would access a file in our directory**? And if multiple processes **need to access the same file simultaneously**, how would you control that?

## User mode / Kernel mode

**The operating system (OS)** utilizes the **kernel** to manage processes. **Typically, CPUs have two modes**. **User mode and Kernel mode.** (sometimes, there may be three modes). If our command is **executed in user mode**, we may **face restrictions** when it comes to tasks like accessing files or obtaining information from the OS. On the other hand, when our program **operates in kernel mode**, we have the freedom to execute most commands **without constraints**.

![](https://hackmd.io/_uploads/rklbr1IvCh.png)

So, the OS solved the problem by changing the process's mode to **either kernel mode or user mode**, allowing or restricting access as needed.

## System call

![](https://hackmd.io/_uploads/SJChWIP0n.png)

Before we dive into the example, we have to know what **system call** is. System call means literally **to call system to do something**.

We **must be kernel mode** when we use system call. That means we can check how many times our program is changed to Kernel mode and User mode.

## How we could figure it out?

We can find the log by **checking the OS log**, which is referred to as **'sysstat'**.

You can check the system stat how`sar` command in Linux. `sar` command show us the system stat like the photo below.

![](https://hackmd.io/_uploads/SkUZGUvCn.png)

I'll explain some keys in the photo. The **'%user' key** represents **the percentage of CPU usage in User mode**, while **the '%system' key** represents the percentage of CPU usage attributed to system calls which means the time **in the kernel mode**.

## Example

```go
package main

import (
	"os"
	"time"
)

func main() {
	for {
		time.Sleep(500)
		os.Getppid() // System call
	}
}

```

Here's the code in a nutshell: There are sleep function to pause execution and getppId function to get a parent process. 

If `Getppid` function is called, then our process will be changed to Kernel mode. In order to check this by log, we have to convert it to an executable file by `build` command.

```
go build main.go
```

Now, we can see the executable file in our dir. So, we are going to execute it by following this command.

```bash
taskset -c 0 ./main &
```

This command indicates that we want to execute the file using CPU-0. Then, we should **verify** whether our program transitions from **user mode to kernel mode** and back while the process is running.

```bash
sar -P 0 1 10
```

This command indicates that we want to check the system log 10 times per second.

```shell!
10:47:03 PM     CPU     %user     %nice   %system   %iowait    %steal     %idle
10:47:04 PM       0      2.04      0.00      2.04      0.00      0.00     95.92
10:47:05 PM       0      5.05      0.00      2.02      1.01      0.00     91.92
10:47:06 PM       0      9.71      0.00      2.91      0.00      0.00     87.38
10:47:07 PM       0      3.92      0.00      2.94      0.00      0.00     93.14
10:47:08 PM       0      4.90      0.00      3.92      0.00      0.00     91.18
10:47:09 PM       0      3.00      0.00      3.00      0.00      0.00     94.00
10:47:10 PM       0      5.83      0.00      1.94      0.00      0.00     92.23
10:47:11 PM       0      2.00      0.00      4.00      0.00      0.00     94.00
10:47:12 PM       0      3.88      0.00      4.85      0.00      0.00     91.26
10:47:13 PM       0      4.00      0.00      2.00      0.00      0.00     94.00
Average:          0      4.46      0.00      2.97      0.10      0.00     92.48
```

In this log, you can see the ratio of user mode to system mode. I'll show you the meaning of result in the drawing.

![](https://hackmd.io/_uploads/Hya8KUvAh.png)

## Conclusion

Today, I've explained what **kernel mode and user mode are**. I hope this information has been helpful to you. If you want to delve deeper into the topic of the kernel, I recommend reading an operating system book.