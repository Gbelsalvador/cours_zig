const std = @import("std");

test "expect addOne adds one to 41" {
    //the standard library contain useful functions to help create tests.
    //`expect` is a function taht verifies its arguments is true
    // it will return an error if its argument is false to indicate a failure
    // `try` is used to return an error to test runner to notify it taht the test failed

    try std.testing.expect(addOne(41) == 42);

    //however, in most cases it is more convenient to use a more specific function like 'expecteq' to compare two values for equality
    // this gives you much clearer and more helpful error messages when a test fails

    try std.testing.expectEqual(addOne(41), 42);
}
test addOne {
    //a test name can also be written using an identifier
    // this is a doctest, and servers as documentation for addOne
    try std.testing.expectEqual(addOne(41), 42);
}

fn addOne(x: i32) i32 {
    return x + 1;
}
