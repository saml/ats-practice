staload "prelude/SATS/unsafe.sats"

(* 
non recursive function is defined with fn.
It is same as using lam and assigning it to a val.
*)
val f = lam(x:double):double => x*x
fn g(x:double):double = x/x

(*
recursive function is defined with fun.
*)
fun fib(n:int):int = 
    if (n <= 0) then 
        0 
    else if (1 = n) then
        1
    else
        fib(n - 1) + fib(n - 2)

(*
not equals operator is <>.
equals operator is =.
*)
fn operator_test(x:int):bool = x <> 4 andalso x - 2 = 4
fn to_int(x:bool):int = if x then 1 else 0

(*
mutually recursive functions can be defined with fn* and and.
*)
fn* even(n:int):bool = if n <= 0 then true else odd(n-1)
and odd(n:int):bool = if n <= 0 then false else even(n-1)

(*
A -<cloref1> B is closure version of A -> B.
*)
fn addx(x:int):int -<cloref1> int = let
    fn f(y:int):<cloref1> int = x + y
in
    f
end

(*
functions are values.
*)
fun ifold(n:int, f:(int,int) -> int, accumulator:int):int =
    if n <= 0 then
        accumulator
    else
        f(ifold(n-1, f, accumulator), n)

implement main() = {
    val _ = printf("%f\n", @(f(g(0.1))));
    val _ = printf("%d\n", @(fib(10)));
    val _ = printf("%d\n", @(to_int(operator_test(6))));
    val _ = printf("%d\n", @(to_int(odd(6))));
    val _ = printf("%d\n", @(addx(6)(1)));
    val sum = lam(n:int):int => ifold(n, lam(a:int, b:int):int => a + b, 0);
    val _ = printf("%d\n", @(sum(10)));

    val s = stringlst_concat( '[ "yo", " hello"]);
    val _ = printf("%s\n", @(s));
}
