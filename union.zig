const std = @import("std");

const ErreurA = error{ FichierIntrouvable, AccesRefuse };
const ErreurB = error{ DisquePlein, DelaiExcede };

// Union des deux types d'erreurs
const ErreurCombinee = ErreurA || ErreurB;

fn chargerFichier() ErreurCombinee!void {
    return error.DisquePlein;
}
