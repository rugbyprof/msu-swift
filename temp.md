# What is a Bash Script?

Source: http://ryanstutorials.net/bash-scripting-tutorial/
## Introduction

A Bash script is a plain text file which contains a series of commands. These commands are a mixture of commands we would normally type ourselves on the command line (such as ls or cp for example) and commands we could type on the command line but generally wouldn't (you'll discover these over the next few pages). An important point to remember though is:

>Anything you can run normally on the command line can be put into a script and it will do exactly the same thing. Similarly, anything you can put into a script can also be run normally on the command line and it will do exactly the same thing.

It is convention to give files that are Bash scripts an extension of .sh (`myscript.sh` for example). Linux is an extension-less system so a script doesn't necessarily have to have this characteristic in order to work.

##How do you run a script?

- Permission need to be correct. The file has to be executable.

```bash
chmod 755 myscript.sh # Sets executable for Owner, Group, and All (as well as readable by all and writable by the owner)
```

or

```bash
chmod u+x myscript.sh # Sets executable for owner
chmod a+x myscript.sh # Sets executable for all
```

- `u`: the user who owns it
- `g`: other users in the file's group
- `o`: other users not in the file's group
- `a` or all users

You can add more than just execute with the `+x`, but that's not for this lesson.


```bash
./myscript.sh
# Output: ./myscript.sh: Permission denied
ls -l myscript.sh
#Output: -rw-r--r-- 18 owner group 4096 Feb 17 09:12 myscript.sh
chmod 755 myscript.sh
ls -l myscript.sh
# Output: -rwxr-xr-x 18 owner group 4096 Feb 17 09:12 myscript.sh
./myscript.sh
# Output: Hello World!
```

