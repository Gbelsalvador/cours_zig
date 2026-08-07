const std = @import("std");

fn fairecalcul(reussir: bool) !i32 {
    if (!reussir) return error.calculImpossibel;
    return 42;
}
pub fn main() void {
    // si une erreur survient resultat vaut 0
    const resultat = fairecalcul(false) catch 0;
    std.debug.print("resultat : {}\n", .{resultat});
    //capture explicite de l'erreur
    const resultat_detaille = fairecalcul(false) catch |err| {
        std.debug.print("erreur capturée: {}\n", .{err});
        return;
    };
    std.debug.print("resultat detaillé : {}\n", .{resultat_detaille});
}
