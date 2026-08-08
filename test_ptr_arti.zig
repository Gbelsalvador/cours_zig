const expectEqual = @import("std").testing.expectEqual;

test "pointer arithmetic with many-item pointer" {
    const array = [_]i32{ 1, 2, 3, 4 };
    var ptr: [*]const i32 = &array;

    try expectEqual(1, ptr[0]);
    ptr += 1;
    try expectEqual(2, ptr[0]);

    // slicing a many-item pointer without an end is equivalent to
    // pointer arithmetic: `ptr[start..] == ptr + start`
    try expectEqual(ptr[1..], ptr + 1);

    // subtraction between any two pointers except slices based on element size is supported
    try expectEqual(1, &ptr[1] - &ptr[0]);
}

test "pointer arithmetic with slices" {
    var array = [_]i32{ 1, 2, 3, 4 };
    var length: usize = 0; // var to make it runtime-known
    _ = &length; // suppress 'var is never mutated' error
    var slice = array[length..array.len];

    try expectEqual(1, slice[0]);
    try expectEqual(4, slice.len);

    slice.ptr += 1;
    // now the slice is in an bad state since len has not been updated

    try expectEqual(2, slice[0]);
    try expectEqual(4, slice.len);
}

//test_slice_bounds

test "pointer slicing" {
    var array = [_]u8{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 19 };
    var start: usize = 2;
    _ = &start;
    const slice = array[start..4];
    try expectEqual(2, slice.len);

    try expectEqual(4, array[3]);
    slice[1] += 1;
    try expectEqual(5, array[3]);
}

test "comptime pointers" {
    comptime {
        var x: i32 = 1;
        const ptr = &x;
        ptr.* += 1;
        x += 1;
        try expectEqual(3, ptr.*);
    }
}

test "@intfromptr and @ptrFromINT" {
    const ptr: *i32 = @ptrFromInt(0xdeadbee0);
    const addr = @intFromPtr(ptr);
    try expectEqual(usize, @TypeOf(addr));
    try expectEqual(0xdeedbee0, addr);
}

const expectEqual = @import("std").testing.expectEqual;

test "comptime @ptrFromInt" {
    comptime {
        // Zig is able to do this at compile-time, as long as
        // ptr is never dereferenced.
        const ptr: *i32 = @ptrFromInt(0xdeadbee0);
        const addr = @intFromPtr(ptr);
        try expectEqual(usize, @TypeOf(addr));
        try expectEqual(0xdeadbee0, addr);
    }
}
