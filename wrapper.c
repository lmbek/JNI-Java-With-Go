#include <jni.h>
#include "beksoft_webview_2023_MyJava.h"
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