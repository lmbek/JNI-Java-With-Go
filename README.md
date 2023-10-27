# JNI-Java-With-Go
Example on how to use java with go, having a wrapper.c to connect the two. This will be run from Java. This repository is the result of my research.

## How to run
We got Java to compile our Java! We can now run our Java code from Java. Let's try it out.

First make a main.go with this:

    package main
    
    import "C"
    import "fmt"
    
    //export RunG2
    func RunG2() {
        fmt.Println("It works!")
    }
    
    //export RunG
    func RunG(name *C.char) {
        fmt.Println("It works! From go we are using", C.GoString(name))
    }
    func main() {
        // We need the main function to make possible
        // CGO compiler to compile the package as C shared library
    }

Then compile it with:

    go build -o libGo.dll -buildmode=c-shared main.go

Then we write this java file called MyJava.java:

    public class MyJava {
        static {
            String libPath = System.getProperty("user.dir");
            System.load(libPath + "/libDone.dll");
        }
        public native void runJ(String name);
        public native void runJ2();
        public static void main(String[] args) {
            new MyJava().runJ("Java!");
            new MyJava().runJ2();
        }
    }

Then we compile the java into a class file with:

    javac -h . MyJava.java

Then we need to make the Wrapper, we create a wrapper.c file with this:

    #include <jni.h>
    #include "MyJava.h"
    #include "libGo.h"
    
    // Java mapping
    JNIEXPORT void JNICALL Java_MyJava_runJ(JNIEnv *env, jobject obj, jstring name) {
    const char *nativeName = (*env)->GetStringUTFChars(env, name, 0);
    
        RunG((char *)nativeName); // Cast nativeName to non-const char* and call Go function
        RunG2(); // Call Go function
    
        (*env)->ReleaseStringUTFChars(env, name, nativeName);
    }
    
    JNIEXPORT void JNICALL Java_MyJava_runJ2(JNIEnv *env, jobject obj) {
    RunG2(); // Call Go function
    RunG2(); // Call Go function
    }

We then compile the wrapper with this:

    gcc -shared -o libDone.dll -IC:\Users\larsz\.jdks\openjdk-21\include -IC:\Users\larsz\.jdks\openjdk-21\include\win32 wrapper.c -L. -lGo

And finally we run the java file with:

    java MyJava

