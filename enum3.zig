const std = @import("std");

const Role = enum { admin, user, guest };

pub fn main() void {
    const r = Role.admin;

    // obtenir le nom en string : "admin"
    std.debug.print("role actuel: {s}\n", .{@tagName(r)});

    // iterer sur tous les varaint à la compilation

    const fields = @typeInfo(Role).@"enum".fields;
    inline for (fields) |f| {
        std.debug.print("variant disponible :  {s} (valeur: {d})\n", .{ f.name, f.value });
    }
}
