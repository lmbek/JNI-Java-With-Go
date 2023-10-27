package main

import "C"
import "fmt"

//export RunG2
func RunG2() {
	fmt.Println("It works!")
}

// //export RunG
//
//	func RunG(name *C.char) {
//		//fmt.Println("It works! From go we are using", C.GoString(name))
//	}
func main() {
	// We need the main function to make possible
	// CGO compiler to compile the package as C shared library
}
