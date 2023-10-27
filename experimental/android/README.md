i was researching how to combine it with android development, but i ended up with another solution (c++ native)
I have another repository where i completed this

I will leave some old files in this repository in case i will work on doing the android shared libraries from here in future, if i can get it to work...



Below is some old draft, its for my own use:







## How to android
Find your NDK or download it at: https://developer.android.com/ndk/downloads <br>
My path was:

    C:\Users\larsz\.android\sdk\ndk\android-ndk-r23c

Make your Android.mk file with this content:

    LOCAL_PATH := $(call my-dir)
    
    include $(CLEAR_VARS)
    
    LOCAL_MODULE := Done
    LOCAL_SRC_FILES := wrapper.c
    
    include $(BUILD_SHARED_LIBRARY)



Now you can compile it for android with (remember to change this path to your own):

    C:\Users\larsz\.android\sdk\ndk\android-ndk-r23c\ndk-build.cmd NDK_PROJECT_PATH=C:\Users\larsz\Desktop\Beksoft\Projects\PrivateProjects\2023Projects\LMBEK\JNI-Java-With-Go NDK_APPLICATION_MK=C:\Users\larsz\Desktop\Beksoft\Projects\PrivateProjects\2023Projects\LMBEK\JNI-Java-With-Go\Application.mk APP_BUILD_SCRIPT=Android.mk

Now we set the GOOS to be android and GOARCH to be arm64 and then we compile our Go code with:

    set ANDROID_NDK=C:\Users\larsz\.android\sdk\ndk\android-ndk-r23c
/*
set CC=C:\Users\larsz\.android\sdk\ndk\android-ndk-r23c\toolchains\llvm\prebuilt\windows-x86_64\bin\aarch64-linux-android31-clang.cmd --sysroot=C:\Users\larsz\.android\sdk\ndk\android-ndk-r23c\toolchains\llvm\prebuilt\windows-x86_64\sysroot
set CXX=C:\Users\larsz\.android\sdk\ndk\android-ndk-r23c\toolchains\llvm\prebuilt\windows-x86_64\bin\aarch64-linux-android31-clang++.cmd --sysroot=C:\Users\larsz\.android\sdk\ndk\android-ndk-r23c\toolchains\llvm\prebuilt\windows-x86_64\sysroot
*/

    set CC=C:\Users\larsz\.android\sdk\ndk\android-ndk-r23c\toolchains\llvm\prebuilt\windows-x86_64\bin\aarch64-linux-android31-clang.cmd
    set CXX=C:\Users\larsz\.android\sdk\ndk\android-ndk-r23c\toolchains\llvm\prebuilt\windows-x86_64\bin\aarch64-linux-android31-clang++.cmd
    set CGO_CFLAGS=-target aarch64-linux-android
    set CGO_CPPFLAGS=-target aarch64-linux-android
    set CGO_CXXFLAGS=-target aarch64-linux-android
    set GOOS=android
    set GOARCH=arm64
    
    go build -o libGo.so -buildmode=c-shared main.go


Write this inside your build.grandle inside react project (inside defaultConfig):

    sourceSets {
        getByName("main") {
            jniLibs.srcDirs("src/main/jniLibs")
        }
    }
    ndk {
        abiFilters.add("arm64-v8a")
    }

Add a java file called MyJava.java with this:

    package beksoft.webview_2023;

    public class MyJava {
        static {
            System.loadLibrary("Go");
        }
        public native void runJ(String name);
        public native void runJ2();
        public static void main(String[] args) {
            new MyJava().runJ("Java!");
            new MyJava().runJ2();
        }
    }












right now i am trying a new approach:
cd C:\Users\larsz\.android\sdk\ndk\android-ndk-r23c\build\tools

python make_standalone_toolchain.py --arch arm64 --api 31 --install-dir C:\android-toolchain-arm64


set ANDROID_NDK=C:\android-toolchain-arm64
set CC=C:\android-toolchain-arm64\bin\aarch64-linux-android-clang.cmd
set CXX=C:\android-toolchain-arm64\bin\aarch64-linux-android-clang++.cmd
set CGO_CFLAGS=-target aarch64-linux-android
set CGO_CPPFLAGS=-target aarch64-linux-android
set CGO_CXXFLAGS=-target aarch64-linux-android
set CGO_LDFLAGS=-LC:\android-toolchain-arm64\sysroot\usr\lib\aarch64-linux-android\31 C:\android-toolchain-arm64\sysroot\usr\lib\aarch64-linux-android\31\crtbegin_so.o C:\android-toolchain-arm64\sysroot\usr\lib\aarch64-linux-android\31\crtend_so.o -llog -target aarch64-linux-android
set GOOS=android
set GOARCH=arm64

go build -o libGo.so -buildmode=c-shared -ldflags="-extldflags=-LC:\android-toolchain-arm64\sysroot\usr\lib\aarch64-linux-android\31 -lcrtbegin_so -lcrtend_so" main.go










C:\Users\larsz\.android\sdk\ndk\android-ndk-r23c\build\ndk-build.cmd NDK_PROJECT_PATH=. NDK_APPLICATION_MK=Application.mk APP_BUILD_SCRIPT=Android.mk