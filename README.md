## What is move ? ##

Move is a bash script utils that will help you to quickly pack your files in new directory using differents patterns or regular expressions.

## Distibution ##

Theorically move will work on every system that implement a bash interpreter. <br>
<br>
It have been test on : <br>
* Ubuntu 16.06 and 18.04
* Mageia 6 
* Debian 9

And embedded devices :

* Imx 6 et 8

## How to compile it ? ##

Because move is a bash script, you do not need to compile it, you just have to install it

## How to install it ? ##

You can install move with the provided makefile :
```make
 make install # You will probably need to be root (you can use sudo)
```
If you do not want to use the default path :
```make
 make install install_loc=/path/to/your/install/location # You will probably need to be root (you can use sudo)
```
The default path is : `/usr/bin`

You can also just put the `move.sh` file weither you want and rename it at your convenance

## How to use it ? ##

Actually their is two syntaxes to use move : With and without regular expression.

The first one only move the files that contains the regular expression to the new directory.

 Exemple :
 ```sh
  move -p <dest_dir> <regexp>
 ```
 `-p` option will tell move to skip all the files that does not countain the regular expression
 whereas `-i` will tell move to ignore all the files that countain it.<br>
 If you use move without these option all the file will be move.
 
 Exemple :
```sh
 move <dest_dir>
```
By default move does not take in count hidden files (all the files that start with a dot). If you want to move them too
you will have to use the `-d` option.

Soon move will have a third syntax that will allow you to choose your source directory. Actually the source directory is the current directory.

Feel free to display help or version at anytime with `-h` and `-v` option.

## Ok it's cool but ... move is not a great name, right ? ##

I agree and thats why if you find a better one feel free to submit it.

## Contact ##

If you have any questions feel free to mail me : <antoine.braut@gmail.com>

<b>I hope this software will help you ! Have a nice day !</b>

<img src="https://images.ecosia.org/x8hEzRW0N0B1oHUTXqREorZ73aE=/0x390/smart/https%3A%2F%2Fcdn170.picsart.com%2Fupscale-241091004033212.png%3Fr1024x1024" alt="drawing" width="200"/>
