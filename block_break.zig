const std = @import("std");

pub fn main() void {
    const count = 5;

    const result = compute: {
        var sum: i32 = 0;
        var i: i32 = 0;
        while (i < count) : (i += 1) {
            sum += i;
        }
        break :compute sum;
    };

    std.debug.print("resultat: {d}\n", .{result});
}
