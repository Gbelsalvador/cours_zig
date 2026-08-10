const std = @import("std");

// declaration d'une tagged union

const Event = union(enum) {
    quit,
    key_press: u8,
    mouse_move: struct { x: i32, y: i32 },
    text_input: []const u8,
};

pub fn main() void {
    const even1 = Event{ .key_press = 'A' };
    const even2 = Event{ .mouse_move = .{ .x = 100, .y = 200 } };

    //le switch permet d'extraire la charge utilse de façon securisée(pattern matching)
    switch (even1) {
        .quit => std.debug.print("Quitter\n", .{}),
        .key_press => |k| std.debug.print("touche pressée :{c}\n", .{k}),
        .mouse_move => |pos| std.debug.print("souris en x:{d}, y:{d}\n", .{ pos.x, pos.y }),
        .text_input => |text| std.debug.print("Text: {s}\n", .{text}),
    }

    switch (even2) {
        .quit => std.debug.print("Quitter\n", .{}),
        .key_press => |k| std.debug.print("touche pressée :{c}\n", .{k}),
        .mouse_move => |pos| std.debug.print("souris en x:{d}, y:{d}\n", .{ pos.x, pos.y }),
        .text_input => |text| std.debug.print("Text: {s}\n", .{text}),
    }
}
