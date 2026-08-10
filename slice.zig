const std = @import("std");
fn sumSlice(numbers: []const i32) i32 {
    var total: i32 = 0;
    for (numbers) |num| {
        total += num;
    }

    return total;
}

pub fn main() void {
    var buffer = [_]i32{ 1, 2, 3, 4, 5, 6, 7, 8 };

    const total_partiel = sumSlice(buffer[2..6]);

    std.debug.print("somme partielle: {d}\n", .{total_partiel});
}
