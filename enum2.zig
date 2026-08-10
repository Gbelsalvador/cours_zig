const std = @import("std");

const Color = enum {
    red,
    green,
    blue,

    //methode associé à l'enum

    pub fn isPrimary(self: Color) bool {
        return switch (self) {
            .red, .blue => true,
            .green => false,
        };
    }

    pub fn toHex(self: Color) []const u8 {
        return switch (self) {
            .red => "#FF0000",
            .green => "#00FF00",
            .blue => "#0000FF",
        };
    }
};

pub fn main() void {
    const c = Color.red;
    std.debug.print("hEX : {s}, primaire: {}\n", .{ c.toHex(), c.isPrimary() });
}
