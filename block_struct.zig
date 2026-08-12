const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    // porter isolée pour une allocation temporaire
    {
        var list = std.ArrayList(u8).init(allocator);
        defer list.deinit(); // libere des la fin de ce blocc

        try list.appendSlice("donnée temporaires");
        std.debug.print("{s}\n", .{list.items});
    }

    // içi , `list`est complement netooyée
}
