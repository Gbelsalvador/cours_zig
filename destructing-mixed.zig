const print = @import("std").debug.print;

pub fn main() void {
    var x: u32 = undefined;
    const tuple = .{ 1, 2, 3 };

    x, var y: u32, const z = tuple;
    print("x={}, y={}, z={}\n", .{ x, y, z });

    y = 100;

    _, x, _ = tuple;
    print("x = {}", .{x});
}
