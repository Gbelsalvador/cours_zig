const std = @import("std");
const expectEqual = std.testing.expectEqual;

test "0-terminade sentinel array " {
    const array = [_:0]u8{ 1, 2, 3, 4 };

    try expectEqual([4:0]u8, @TypeOf(array));
    try expectEqual(4, array.len);
    try expectEqual(0, array[4]);
}

test "extra in 0-terminated sentinel array " {
    const array = [_:0]u8{ 1, 0, 0, 4 };

    try expectEqual([4:0]u8, @TypeOf(array));
    try expectEqual(4, array.len);
    try expectEqual(0, array[4]);
}
