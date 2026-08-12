const std = @import("std");

fn parseNumber(str: []const u8) !i32 {
    return std.fmt.parseInt(i32, str, 10);
}
pub fn main() void {
    const input = "123a";

    const value: i32 = parse_block: {
        const parsed = parseNumber(input) catch |err| {
            std.debug.print("erreur detectée ({s}), valeur par defaut utilisée\n", .{@errorName(err)});
            break :parse_block 0;
        };
        break :parse_block parsed;
    };

    std.debug.print("valeur finale : {d}\n", .{value});
}
