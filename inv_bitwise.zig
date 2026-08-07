const std = @import("std");

pub fn main() void {
    const a: u8 = 0b00001111;
    const b: u8 = ~a;
    std.debug.print("b = {}\n", .{b});
}
