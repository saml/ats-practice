staload Unsafe = "prelude/SATS/unsafe.sats";

//fn str_format(format, args) = string_of_strptr(sprintf(format, args))

implement main() = {
    val a = "a";
    val b = "b";
    val c = string1_append(a,b);
    val _ = printf("%s\n" , @($Unsafe.castvwtp1{string} c));
    val _ = strbufptr_free(c);


    val c = sprintf("%s %s", @(a,"bleh"));
    val x = string_of_strptr(c);
    val _ = printf("%s\n", @(x));
    //val _ = strbufptr_free(c);
}
