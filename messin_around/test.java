class test{
    public static void main(String[] args){
	System.out.println("hello world!");
	System.out.println(fib(10));
    }

    private static int fib(int x){
	if (x==0) {
	    return 0;
	}
	else if (x==1) {
	    return 1;
	}
	else {
	    return (fib(x-1) + x);
	}
    }
}
