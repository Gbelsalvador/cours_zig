const std = @import("std");

pub fn main() void {
    const values = .{ @as(i32, 100), "zig", 3.14 };
    // inline for deroule la boucle à la compilation
    inline for (values, 0..) |elem, index| {
        std.debug.print("index {d} (type {s}) = {any}\n", .{
            index,
            @typeName(@TypeOf(elem)),
            elem,
        });
    }
}
