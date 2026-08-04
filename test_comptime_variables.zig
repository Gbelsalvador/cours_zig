const std = @import("std");
const expectEqual = std.testing.expectEqual;

test "comptime variabele" {
    var x: i32 = 1;
    comptime var y: i32 = 1;
    y += 1;
    x += 1;

    try expectEqual(2, x);
    try expectEqual(2, y);

    if (y != 2) {
        // this compile error never triggers because y is a comptime variable and the compiler knows its value at compile time
        // and so y != 2 is false and the code inside the if statement is never executed
        @compileError("y is not equal to 2");
    }
}
