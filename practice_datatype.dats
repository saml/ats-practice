typedef Name = @{first_name = string, last_name = string}

datatype Person = 
    | WithName of (Name, bool) //name and gender: is female?
    | NoName of (bool)

fn from_gender(is_female:bool):string = if is_female then "female." else "male."

fn to_string(person:Person):string = case person of
    | WithName(name,is_female) => let
        val gender_str = from_gender(is_female)
        val x = sprintf("%s %s is %s", @(name.first_name, name.last_name, gender_str))
    in
        string_of_strptr(x)
    end
    | NoName(is_female) => string0_append("anonymous is ", from_gender(is_female))
    
implement main() = {
    val person1 = WithName(@{first_name = "Sam", last_name = "Lee"}, false)
    val person2 = WithName(@{first_name = "Jessica", last_name = "Doe"}, true)
    val person3 = NoName(true)
    val _ = printf("%s\n", @(to_string(person1)))
    val _ = printf("%s\n", @(to_string(person2)))
    val _ = printf("%s\n", @(to_string(person3)))
}
