const std = @import("std");

pub fn main() void {
    var x: i32 = 10;
    const ptr = &x; // Pointeur vers x (*i32)

    ptr.* = 20; // Modification de la valeur à l'adresse pointée
    std.debug.print("x = {}\n", .{x}); // Affiche 20
}
