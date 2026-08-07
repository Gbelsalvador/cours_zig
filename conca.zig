const std = @import("std");

pub fn main() void {
    const a = [_]i32{ 1, 2 };
    const b = [_]i32{ 3, 4 };
    const zeros = [_]u8{0} ** 5;
    _ = zeros;
    const motif = "zbc" ** 3;
    _ = motif;
    const c = a ++ b; // [_]i32{1,2,3,4}
    _ = c;

    const salutation = "hello" ++ "word!";
    _ = salutation;
}
