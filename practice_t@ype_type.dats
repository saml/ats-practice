fun{A,B:t@ype} swap(ab:(A,B)):(B,A) = (ab.1,ab.0)
fun swap_boxed{A,B:type}(ab:(A,B)):(B,A) = (ab.1,ab.0)


datatype List(a:t@ype) = 
    | Nil(a) of ()
    | Cons(a) of (a, List(a))

fun{a:t@ype} 
len(l:List(a)):int = let
    fun{a:t@ype} loop(l:List(a), n:int):int = case+ l of
        | Nil() => n
        | Cons(_,xs) => loop(xs, n+1)
in
    loop<a>(l,0)
end

fun{a:t@ype}{b:t@ype}
fold_list(f:(b,a) -> b, acc:b, l:List(a)):b = case+ l of
    | Nil() => acc
    | Cons(x,xs) => fold_list(f, f(acc, x), xs)

fun{a:t@ype}
len_using_fold(l:List(a)):int = let
    fun{a:t@ype} add1(i:int, x:a):int = i + 1
in
    fold_list(add1<a>, 0, l)
end

fun{a:t@ype}
print_list(l:List(a)) = let
    fun{a:t@ype} prn(i:void, x:a):void = begin
        print(x);
        print(", ");
    end
in
    fold_list(prn<a>, (), l)
end

implement main() = {
    val ab = swap<char,int>(@('a', 1));
    val _ = printf("%d %c\n", @(ab.0, ab.1));
    val ab = swap<string,int>(@("haha", 1));
    val _ = printf("%d %s\n", @(ab.0, ab.1));
    
    val ab = swap_boxed{string,string}(@("world", "hello"));
    val _ = printf("%s %s\n", @(ab.0, ab.1));
    val ab = swap_boxed{...}(@("world", "hello"));
    val _ = printf("%s %s\n", @(ab.0, ab.1));

    val l = Cons('a', Cons('b', Cons('c', Nil())))
    val _ = printf("length: %d\n", @(len<char>(l)))
    val l = Cons("abc", Cons("hello", Cons("world", Nil())))
    val _ = printf("length: %d\n", @(len<string>(l)))

    val l = Cons('a', Cons('b', Cons('c', Nil())))
    val _ = printf("length: %d\n", @(len_using_fold<char>(l)))

    val _ = print(true)
    val _ = print('a')
    val _ = print(234)
    val _ = print(234.34)
    val _ = print("hello")
}
