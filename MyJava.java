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