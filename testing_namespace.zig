const std = @import("std");

test "expectEqual demo" {
    const expected: i32 = 42;
    const actual = 42;

    // the first argument to expectequal is the know, expected result
    // the second argument us the result of some expression
    // the actual's type is casted to the type of expected

    try std.testing.expectEqual(expected, actual);
}

test "expectError demo" {
    const expected_error = error.DemonError;
    const actual_error_union: anyerror!void = error.DemonError;

    try std.testing.expectError(expected_error, actual_error_union);
}
