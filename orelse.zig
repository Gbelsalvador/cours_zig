const std = @import("std");

pub fn main() void {
    const nombre_optionnel: ?i32 = null;

    //si le nombre_optionnel est null valeur vaut 10
    const valeur = nombre_optionnel orelse 10;
    _ = valeur;
    //on peut aussi interreompre l'execution
    const valeur_strict = nombre_optionnel orelse return;
    _ = valeur_strict;
}
