# TECHNIQUE 
içi je me base trop sur le details technique que je trouve sur zig sur internet , youtube et gemini


# 1 METAPROGRAMMMEING ET GENERECITE AVEC COMPTIME EN ZIG

En Zig, il n'y a pas de syntaxe spéciale pour les génériques comme les generics en Rust (<T>), le templates en C++ (template<typename T>) ou la réflexion complexe d'autres langages.

À la place, Zig utilise un principe d'une simplicité désarmante : les types sont des valeurs normales manipulables à la compilation grâce au mot-clé comptime.

## 1. La fondation : Le type type
En Zig, les types (i32, f64, []const u8, etc.) possèdent eux-mêmes un type : le type type.

Ce type type ne peut exister qu'au moment de la compilation (comptime). On peut passer un type en paramètre d'une fonction, le retourner, le stocker dans une variable ou le comparer.

```zig
// 'T' est une variable de compilation qui contient un type
const T: type = u32; 

// On peut utiliser T exactement comme n'importe quel type
var x: T = 42; 
```
## 2. La Généricité : Des fonctions qui retournent des types
Puisqu'une fonction peut recevoir un type et retourner un type, une classe ou structure générique n'est rien d'autre qu'une fonction exécutée à la compilation !

Exemple 1 : Une structure générique (Généricité)
Voici comment on crée une structure générique Pile(T) (Stack) en Zig :

```zig
const std = @import("std");

// Cette fonction prend un type T et RETOURNE un nouveau type struct
fn Pile(comptime T: type) type {
    return struct {
        elements: [100]T,
        taille: usize = 0,

        const Self = @This(); // '@This()' fait référence à la struct courante

        pub fn empiler(self: *Self, valeur: T) !void {
            if (self.taille >= 100) return error.PilePleine;
            self.elements[self.taille] = valeur;
            self.taille += 1;
        }

        pub fn depiler(self: *Self) ?T {
            if (self.taille == 0) return null;
            self.taille -= 1;
            return self.elements[self.taille];
        }
    };
}

pub fn main() !void {
    // Génère un type de struct spécialisé pour les u32
    var pile_int = Pile(u32){};
    try pile_int.empiler(10);
    try pile_int.empiler(20);

    // Génère un autre type spécialisé pour les flottants
    var pile_float = Pile(f32){};
    try pile_float.empiler(3.14);

    std.debug.print("Valeur dépilée: {?d}\n", .{pile_int.depiler()}); // 20
}
```
Que fait le compilateur ?

Quand vous écrivez Pile(u32), Zig exécute la fonction Pile pendant la compilation et génère le code binaire concret pour une pile d'entiers. Si vous réutilisez Pile(u32) ailleurs, Zig réutilise intelligemment le type déjà généré (monomorphisation).

## 3. Les Fonctions Génériques
De la même manière, si une fonction accepte un paramètre précédé de comptime, cette fonction devient générique :

```zig
// Fonction qui fonctionne avec N'IMPORTE QUEL type d'entier ou flottant
fn max(comptime T: type, a: T, b: T) T {
    return if (a > b) a else b;
}

pub fn main() void {
    const val1 = max(u32, 10, 20); // T = u32
    const val2 = max(f64, 5.5, 2.1); // T = f64
}
```
## 4. Métaprogrammation et Introspection (@typeInfo)
La métaprogrammation consiste à examiner ou modifier du code à la compilation. Zig fournit des built-ins extrêmement puissants pour inspecter les types, notamment @typeInfo.

@typeInfo prend un type et retourne une union tagged (std.builtin.Type) décrivant le type dans ses moindres détails (champs d'une struct, arguments d'une fonction, etc.).

Exemple 2 : Une fonction d'affichage générique qui inspecte les structs
```js
const std = @import("std");

fn afficherStruct(valeur: anytype) void {
    // 'anytype' indique que le type sera déduit à la compilation
    const T = @TypeOf(valeur);
    const info = @typeInfo(T);

    // On vérifie À LA COMPILATION que la valeur passée est bien une Struct
    if (info != .Struct) {
        @compileError("afficherStruct ne fonctionne qu'avec des structures !");
    }

    // Boucle 'inline' : elle s'exécute à la COMPILATION pour générer le code
    inline for (info.Struct.fields) |champ| {
        // @field(valeur, champ.name) permet d'accéder dynamiquement à un champ par son nom
        std.debug.print("{s}: {}\n", .{ champ.name, @field(valeur, champ.name) });
    }
}

const Utilisateur = struct {
    id: u32,
    nom: []const u8,
    est_actif: bool,
};

pub fn main() void {
    const u = Utilisateur{ .id = 1, .nom = "Alice", .est_actif = true };
    
    // Génère le code d'affichage à la compilation pour la struct Utilisateur
    afficherStruct(u);
}
```
Explication de l'inspection :
anytype : Permet à la fonction d'accepter n'importe quel type sans préciser comptime T: type.

inline for : Contrairement à un for classique exécuté au runtime, inline for déroule la boucle au moment de la compilation.

@compileError : Si vous passez un entier à afficherStruct, la compilation échoue avec un message personnalisé clair avant même de produire un fichier exécutable.

## 5. Exécution de code arbitraire à la compilation (comptime blocks)
Vous pouvez exécuter n'importe quel code Zig valide à la compilation pour calculer des constantes complexes ou générer des tables de recherche (lookup tables) :

```zig
// Génération d'une table de sinus pré-calculée à la compilation
const table_sinus = comptime {
    var table: [360]f32 = undefined;
    var degre: usize = 0;
    while (degre < 360) : (degre += 1) {
        const rad = @as(f32, @floatFromInt(degre)) * (std.math.pi / 180.0);
        table[degre] = @sin(rad);
    }
    break :table table; // Retourne la table calculée
};

pub fn main() void {
    // Zero coût au runtime ! La valeur est déjà calculée dans le binaire.
    std.debug.print("Sinus 90deg = {d}\n", .{table_sinus[90]}); // 1.0
}
```
En résumé : Pourquoi l'approche de Zig est révolutionnaire ?
Pas de DSL ou de macro-langage : Vous n'avez pas besoin d'apprendre un langage de macro séparé (comme en C/C++ ou Rust). La métaprogrammation s'écrit en vrai code Zig.

Un seul langage : Les fonctions exécutées à la compilation utilisent la même syntaxe et les mêmes règles que celles exécutées au runtime.

Type Safety Totale : Tout le code généré ou inspecté est vérifié par le compilateur avant la génération du binaire.

Coût Zéro en Performance : Tous les calculs et dérivations de types faits via comptime disparaissent à l'exécution.