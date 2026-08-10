const std = @import("std");

fn add(a: i32, b: i32) i32 {
    return a + b;
}

pub fn main() void {
    const args = .{ 15, 27 };

    //appelle add(15,27) en depaquetznt le tuple d'arguments
    const result = @call(.auto, add, args);

    std.debug.print("resultat : {d}\n", .{result});
}
