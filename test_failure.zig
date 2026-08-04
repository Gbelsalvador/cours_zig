const std = @import("std");

test "expect this to fail " {
    try std.testing.expect(false);
}

test "expect this to succeed" {
    try std.testing.expect(true);
}

test "this will be skipped" {
    return error.SkipZigTest;
}

// test de signalement de la fuite de memoire

test "detect leak" {
    const gpa = std.testing.allocator;
    var list: std.ArrayList(u21) = .empty;

    //missing defer list.deinit(gpa)

    try list.append(gpa, '☔');
    try std.testing.expectEqual(1, list.items.len);
}
