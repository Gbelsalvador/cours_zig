const std = @import("std");
const expectEqual = std.testing.expectEqual;

const mat4x5 = [4][5]f32{
    [_]f32{ 1.0, 0.0, 0.0, 0.0, 0.0 },
    [_]f32{ 0.0, 1.0, 0.0, 1.0, 0.0 },
    [_]f32{ 0.0, 0.0, 1.0, 0.0, 0.0 },
    [_]f32{ 0.0, 0.0, 0.0, 1.0, 9.9 },
};

test "multidimension arrays" {
    //mat4X5 itself is a one-dimension array of arrays
    try expectEqual(mat4x5[1], [_]f32{ 0.0, 1.0, 0.0, 1.0, 0.0 });
    try expectEqual(9.9, mat4x5[3][4]);

    for (mat4x5, 0..) |row, row_index| {
        for (row, 0..) |cell, column_index| {
            if (row_index == column_index) {
                try expectEqual(1.0, cell);
            }
        }
    }

    const all_zero: [4][5]f32 = .{.{0} ** 5} ** 4;
    try expectEqual(0, all_zero[0][0]);
}
