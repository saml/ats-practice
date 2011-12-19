typedef Name = @{first_name = string, last_name = string}

datatype Person = 
    | WithName of (Name, bool) //name and gender: is female?
    | NoName of (bool)

fn from_gender(is_female:bool):string = if is_female then "female." else "male."

fn to_string(person:Person):string = case+ person of
    | WithName(name,is_female) => let
        val gender_str = from_gender(is_female)
        val x = sprintf("%s %s is %s", @(name.first_name, name.last_name, gender_str))
    in
        string_of_strptr(x)
    end
    | NoName(is_female) => string0_append("anonymous is ", from_gender(is_female))
 
datatype IntExpr =
    | IConstant of int
    | Add of (IntExpr, IntExpr)
    | Sub of (IntExpr, IntExpr)
datatype BoolExpr =         //even if I use and BoolExpr here, I cannot use the same constructor name, Constant.
    | BConstant of bool     //So, there are two constant constructors, IConstant and BConstant.
    | And of (BoolExpr, BoolExpr)
    | Or of (BoolExpr, BoolExpr)
datatype Expr =
    | IntExpr of IntExpr
    | BoolExpr of BoolExpr
datatype Value = 
    | Int of int
    | Bool of bool

fun eval_bool(expr:BoolExpr):bool = case+ expr of
    | BConstant(b) => b
    | And(a,b) => eval_bool(a) && eval_bool(b)
    | Or(a,b) => eval_bool(a) || eval_bool(b)

fun eval_int(expr:IntExpr):int = case+ expr of
    | IConstant(i) => i
    | Add(a,b) => eval_int(a) + eval_int(b)
    | Sub(a,b) => eval_int(a) - eval_int(b)

fn int_eq(x:IntExpr, y:IntExpr):Expr = BoolExpr(BConstant(eval_int(x) = eval_int(y)))

fn eval(expr:Expr):Value = case+ expr of
    | IntExpr(i) => Int(eval_int(i))
    | BoolExpr(b) => Bool(eval_bool(b))

fn print_val(v:Value) = case+ v of
    | Int(i) => printf("%d\n", @(i))
    | Bool(b) => if b then print("true\n") else print("false\n")

implement main() = {
    val person1 = WithName(@{first_name = "Sam", last_name = "Lee"}, false)
    val person2 = WithName(@{first_name = "Jessica", last_name = "Doe"}, true)
    val person3 = NoName(true)
    val _ = printf("%s\n", @(to_string(person1)))
    val _ = printf("%s\n", @(to_string(person2)))
    val _ = printf("%s\n", @(to_string(person3)))

    val _ = print("1 + 2 - 3 = 0 ? ")
    val _ = print_val(eval(int_eq(Add(IConstant(1), Sub(IConstant(2), IConstant(3))), IConstant(0))))
    
}
