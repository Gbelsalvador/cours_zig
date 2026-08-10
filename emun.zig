const std = @import("std");

const Direction = enum {
    north,
    south,
    east,
    west,
};

pub fn main() void {
    // utilisation avec qualification complete
    var dir: Direction = Direction.north;
    // syntaxe raccorucie (inferece de type via le '.')
    dir = .east;
    // utilisation idéela dans switch

    switch (dir) {
        .north => std.debug.print("vers le nord\n", .{}),
        .south => std.debug.print("vers le sud\n", .{}),
        .east, .west => std.debug.print("east ou ouest\n", .{}),
    }
}
