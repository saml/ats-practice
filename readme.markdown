# ATS Practice

Trying to learn [ATS](http://www.ats-lang.org/)


# unboxed tuple

    val x = @(a,b,c)
    x.0 ==> a
    x.1 ==> b
    x.2 ==> c

# boxed tuple

    '(a,b,c)
    '( 'a',b,c) //note the space not to confuse parser.

# non recursive functions

**fn** keyword is used to define non recursive functions.

    val f = lam(x:double):double => x*x
    fn f(x:double):double = x*x

# negative numbers (unary operator)

    ~3, ~x

# recursive functions

**fun** keyword is used to define recursive functions.

    fun fib(n:int):int = 
        if (n <= 0) then 
            0 
        else if (1 = n) then //equality operator is =, not ==.
            1
        else
            fib(n - 1) + fib(n - 2)

# tail recursive functions

**`fn*`**

    fn* f(n:int,acc:int):int = if n <= 0 then acc else f(n-1,acc+n)

# mutually recursive functions

**fun** and **and**

    fun even(n:int):bool = if n <= 0 then true else odd(n-1)
    and odd(n:int):bool = if n <= 0 then false else even(n-1)

# mutually recursive tail recursion functions

**`fn*`** and **and**

    fn* even(n:int):bool = if n <= 0 then true else odd(n-1)
    and odd(n:int):bool = if n <= 0 then false else even(n-1)

# closure

A `-<cloref1>` B instead of A `->` B. `<cloref1> A` instead of `A`.

    fn addx(x:int):int -<cloref1> int = let
        fn f(y:int):<cloref1> int = x + y
    in
        f
    end   

# operators

    = equals
    <> not equals

# algebraic data type

**datatype** is keyword.

    datatype = TypeName
        | ConstructorName of type
        | ConstructorName2 of (type1, type2)

**case+ of =>** 

    case+ x of
        | ConstructorName(x) => x + 1 //different x.
        | ConstructorName2(x,y) => x + y

# function templates

**fun{Foo,Bar:t@ype} name(args)**

works for boxed and unboxed args.

    fun{A,B:t@ype} swap_pair(ab:(A,B)):(B:A) = (ab.1, ab.0)
    swap_pair<string,int>(@("hello", 42))
    ==> @(42, "hello")

# polymorphic functions

**fun name{Foo,Bar:type}(args)**

only works with boxed args. Type args (Foo,Bar..) can be inferred. 

    fun swap_pair{A,B:type}(ab:(A,B)):(B:A) = (ab.1, ab.0)
    swap_pair{string,int}(@("hello", 42))
    ==> @(42, "hello")
    swap_pair{...}(@("hello", 42)) //type args inferred.
    ==> @(42, "hello")
