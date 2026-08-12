const std = @import("std");

const Number = union{
    integer: i32,
    float: f32,
};

pub fn main() void {
    var num = Number{.integer = 42};

    // modification de la valeur
    num.float = 3.14;

    std.debug.print("float: {d}\n", .{num.float});
}