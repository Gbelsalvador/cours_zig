const print = @import("std").debug.print;

fn swizzlergbatobgra(rgba: [4]u8) [4]u8 {
    const r, const g, const b, const a = rgba;
    return .{ b, g, r, a };
}

pub fn main() void {
    const pos = [_]i32{ 1, 2 };
    const x, const y = pos;
    print("x = {}, y = {}\n", .{ x, y });

    const orange: [4]u8 = .{ 255, 165, 0, 255 };
    print("{any}\n", .{swizzlergbatobgra(orange)});
}
