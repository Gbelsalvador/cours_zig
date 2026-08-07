const std = @import("std");

pub fn main() void {
    const nom: ?[]const u8 = "zig";

    //raccourci pour : nom orelse unreachable
    const nom_certain = nom.?;
    std.debug.print("langage: {s}\n", .{nom_certain});
}
