# x86-64 Linux Syscalls

| Syscall Number | Name                | Description                                             |
|----------------|---------------------|---------------------------------------------------------|
| 0              | [read](#read)        | Read from a file descriptor                             |
| 1              | [write](#write)      | Write to a file descriptor                              |
| 2              | [open](#open)        | Open a file                                             |
| 3              | [close](#close)      | Close a file descriptor                                 |
| 60             | [exit](#exit)        | Exit the program with a status code                     |
| 9              | [mmap](#mmap)        | Map files or devices into memory                        |
| 10             | [mprotect](#mprotect)| Set protection on a region of memory                    |
| 19             | [lseek](#lseek)      | Reposition read/write file offset                       |
| 20             | [getpid](#getpid)    | Get process ID                                          |
| 39             | [fork](#fork)        | Create a child process                                  |
| 57             | [setuid](#setuid)    | Set the user ID of the calling process                  |
| 231            | [clone](#clone)      | Create a new process                                    |
| 122            | [ioctl](#ioctl)      | Control device operations                               |
| 138            | [fstat](#fstat)      | Get file status information                             |
| 153            | [gettid](#gettid)    | Get thread ID                                           |
| 231            | [sched_setaffinity](#sched_setaffinity) | Set CPU affinity for a process or thread         |

---

### Descriptions

#### [read](#read)
The `read` syscall reads data from a file descriptor into a buffer. It returns the number of bytes read, or -1 if an error occurs.

| Register | Usage                  |
|----------|------------------------|
| `rax`    | Syscall number (0)      |
| `rdi`    | File descriptor         |
| `rsi`    | Buffer address          |
| `rdx`    | Number of bytes to read |

#### [write](#write)
The `write` syscall writes data from a buffer to a file descriptor. It returns the number of bytes written, or -1 if an error occurs.

| Register | Usage                  |
|----------|------------------------|
| `rax`    | Syscall number (1)      |
| `rdi`    | File descriptor         |
| `rsi`    | Buffer address          |
| `rdx`    | Number of bytes to write|

#### [open](#open)
The `open` syscall opens a file and returns a file descriptor. It can specify flags like `O_RDONLY` for reading, `O_WRONLY` for writing, etc.

| Register | Usage                      |
|----------|----------------------------|
| `rax`    | Syscall number (2)          |
| `rdi`    | File path (string address)  |
| `rsi`    | Flags                       |
| `rdx`    | Mode (permissions)          |

#### [close](#close)
The `close` syscall closes a file descriptor. It returns 0 on success and -1 if an error occurs.

| Register | Usage                  |
|----------|------------------------|
| `rax`    | Syscall number (3)      |
| `rdi`    | File descriptor         |

#### [exit](#exit)
The `exit` syscall terminates the program, returning an exit status code to the operating system.

| Register | Usage                  |
|----------|------------------------|
| `rax`    | Syscall number (60)     |
| `rdi`    | Exit status code        |

#### [mmap](#mmap)
The `mmap` syscall maps files or devices into memory. It can also be used for shared memory, anonymous memory regions, or memory-mapped files.

| Register | Usage                        |
|----------|------------------------------|
| `rax`    | Syscall number (9)            |
| `rdi`    | Address (NULL for any address)|
| `rsi`    | Length                       |
| `rdx`    | Protection flags              |
| `r10`    | Flags                         |
| `r8`     | File descriptor               |
| `r9`     | Offset                        |

#### [mprotect](#mprotect)
The `mprotect` syscall sets memory protection attributes for a specified memory region. It can set permissions like `PROT_READ`, `PROT_WRITE`, etc.

| Register | Usage                      |
|----------|----------------------------|
| `rax`    | Syscall number (10)         |
| `rdi`    | Memory address              |
| `rsi`    | Length of the region        |
| `rdx`    | Protection flags            |

#### [lseek](#lseek)
The `lseek` syscall repositions the read/write file offset for a given file descriptor, typically to support random access to files.

| Register | Usage                  |
|----------|------------------------|
| `rax`    | Syscall number (19)     |
| `rdi`    | File descriptor         |
| `rsi`    | Offset                  |
| `rdx`    | Whence (seek mode)      |

#### [getpid](#getpid)
The `getpid` syscall retrieves the process ID of the calling process.

| Register | Usage                  |
|----------|------------------------|
| `rax`    | Syscall number (20)     |

#### [fork](#fork)
The `fork` syscall creates a new child process, which is a copy of the calling process.

| Register | Usage                  |
|----------|------------------------|
| `rax`    | Syscall number (39)     |

#### [setuid](#setuid)
The `setuid` syscall sets the user ID for the calling process, often used for privilege escalation or switching users.

| Register | Usage                  |
|----------|------------------------|
| `rax`    | Syscall number (57)     |
| `rdi`    | New user ID             |

#### [clone](#clone)
The `clone` syscall creates a new process, similar to `fork`, but with more control over what is shared between parent and child processes.

| Register | Usage                  |
|----------|------------------------|
| `rax`    | Syscall number (231)    |
| `rdi`    | Flags                   |
| `rsi`    | Stack address           |

#### [ioctl](#ioctl)
The `ioctl` syscall performs device-specific control operations, such as modifying hardware settings.

| Register | Usage                  |
|----------|------------------------|
| `rax`    | Syscall number (122)    |
| `rdi`    | File descriptor         |
| `rsi`    | Request code            |
| `rdx`    | Argument                |

#### [fstat](#fstat)
The `fstat` syscall retrieves information about a file, such as its size, permissions, and timestamps.

| Register | Usage                  |
|----------|------------------------|
| `rax`    | Syscall number (138)    |
| `rdi`    | File descriptor         |
| `rsi`    | Stat structure address  |

#### [gettid](#gettid)
The `gettid` syscall retrieves the thread ID of the calling thread.

| Register | Usage                  |
|----------|------------------------|
| `rax`    | Syscall number (153)    |

#### [sched_setaffinity](#sched_setaffinity)
The `sched_setaffinity` syscall sets the CPU affinity of a process or thread, restricting it to run on specific CPU cores.

| Register | Usage                      |
|----------|----------------------------|
| `rax`    | Syscall number (231)        |
| `rdi`    | PID (or 0 for the current process) |
| `rsi`    | Length of the CPU set       |
| `rdx`    | CPU set (bitmask)           |

---

## Example of Calling a Syscall (Exit)
```assembly
mov rax, 60    ; syscall number for exit
mov rdi, 0     ; exit status code (0 for success)
syscall        ; make the syscall
