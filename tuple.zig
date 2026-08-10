const std = @import("std");

pub fn main() void {
    // instanciation d'un tuple avec 3 element de type differents
    const tuple = .{ 42, "hello", true };

    //accces au elements via la syntaxe d'indexation anonyme [N]

    std.debug.print("nombre : {d}\n", .{tuple[0]});
    std.debug.print("texte : {s}\n", .{tuple[1]});
    std.debug.print("actif : {}\n", .{tuple[2]});
}
