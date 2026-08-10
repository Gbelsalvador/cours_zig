const std = @import("std");

//declaration d'une struct

const Point = struct {
    x: f32,
    y: f32,
    z: f32 = 0.0,
};

pub fn main() void {
    // instanciation avec des litereaux nommé (.x, .y)
    var p1 = Point{ .x = 10.5, .y = 20.0 };

    p1.x += 5.0;
    std.debug.print("Point : ({d:.1}, {d:.1}, {d:.1})\n", .{ p1.x, p1.y, p1.z });
}
