# cours de zig 
**url de la documentation :** [Documentation](https://ziglang.org/documentation/0.16.0/)

## langage zig 
**Zig** est un langage de programmation de bas niveau rapide et robuste conçu pour remplacer le C

## execution de code .zig
pour executer le code zig (exemple celui de hello.zig) premièrement on fait
```bash
zig build-exe hello.zig
```
Cette commande compile le fichier source Zig en un exécutable binaire indépendant
**build-exe** : L'instruction  içi indique au compilateur de créer un exécutable par opposition à **build-lib** pour une bibliothèque ou **build-obj** pour un fichier objet

ce commande genere un fichier hello pour MacOS,
hello.exe et un fichier de symbole hello.pdb(utiliser pour le debogage) pour windows

une fois la commande terminée vous pouvez lancer directement le programme en fançon 
pour le macOS
```bash
./hello
```

pour windows
```bash
./hello.exe
``` 
nb : vous pouvez aussi lancer sur window en faisant ./hello 

## commentaires
il y a trois maniere de declarer un commentaire en zig

le commentaire normaux ( // ) sont ignorés mais les commentaires du doc (docs comments) et les commentaires du docs de premier niveau (top-level doc comments) sont utilisés par le compilateur pour generer la documentation du paquet

le commentaire doc commence par ///

voici la commande pour generer la documentation grace au commentaire 

```bash
zig test -femit-docs main.zig
```

NB : les commentaires doc ne sont aurtoisés qu'à certains endroit comme :
- au milleiu d'une expression
- avant un commenataire non medical
```zig
/// doc-comment
//! top-level doc-comment
const std = @import("std");

```

```zig
pub fn main() void {}

/// End of file
```
le commentaire doc de premier niveau commence par //! (il doit toujour etre placé au debut d'un container )
```zig
//! This module provides functions for retrieving the current date and
//! time with varying degrees of precision and accuracy. It does not
//! depend on libc, but will use functions from it if available.

const S = struct {
    //! Top level comments are allowed inside a container other than a module,
    //! but it is not very useful.  Currently, when producing the package
    //! documentation, these comments are ignored.
};
```

## identifiant 
Les **identifiants** :est simplement le nom que vous donnez à une entité dans votre code
Règles de nommage :
Il peut contenir des lettres, des chiffres et des tirets bas (_).

Il ne peut pas commencer par un chiffre.

Zig est sensible à la casse (myVar et myvar sont distincts).

Vous ne pouvez pas utiliser un mot-clé réservé (fn, const, var, pub, struct, etc.) comme nom classique.
const max_speed = 100; // 'max_speed' est l'identifiant
var user_count: u32 = 0; // 'user_count' est l'identifiant
NB : Si vous devez absolument utiliser un nom qui entre en conflit avec un mot-clé (par exemple lors de l'interaction avec du code C), Zig permet d'échapper l'identifiant avec @"..."
```zig
const @"fn" = 42; // Permet d'utiliser 'fn' comme nom de variable
const @"type-with-dashes" = f32;
```
## VALEUR
Une valeur est la donnée concrète stockée en mémoire ou calculée au moment de la compilation. En Zig, toute valeur possède un type strict.
integer : 42, 10, 0xFF(hexadecimal), 0b1010(binaire)
float : 3.14, 6.022e23
booléens : true, false
caracteres/chaine: 'a' (un entier u8/ASCII/UTF-8), "hello"(un pointer vers un tableau d'octets constant *const [5:0]u8)
null : represente l'absence de valeur pour un type optionnelle (?T)
error: repreentent un etat d'erreur dans un error set
undefined : indique que la memoire est inetentionnellemznt non initialisée
```zig
var buffer: [100]u8 = undefined; // La valeur est indéterminée pour l'instant
```

NB : le schema de declaration de valeur avec un identifiant en zig

$$\text{qualificateur} \quad \text{identifiant}: \text{Type} = \text{valeur};$$

## TYPES PRIMITIFS

|Type|Équivalent C|Description|
|---|---|---|
|i8|int8_t|Entier signé 8 bits|
|u8|uint8_t|Entier non signé de 8 bits|
|i16|int16_t|Entier signé 16 bits|
|u16|uint16_t|Entier non signé 16 bits|
|i32|int32_t|Entier signé 32 bits|
|u32|uint32_t|Entier non signé de 32 bits|
|i64|int64_t|Entier signé 64 bits|
|u64|uint64_t|Entier non signé de 64 bits|
|i128|__int128|Entier signé 128 bits|
|u128|unsigned __int128|Entier non signé de 128 bits|
|isize|intptr_t|Entier de taille pointeur signé|
|usize|uintptr_t, size_t|entier de taille pointeur non signé|
|c_char|char|pour la compatibilité ABI avec C|
|c_short|short|pour la compatibilité ABI avec C|
|c_ushort|unsigned short|pour la compatibilité ABI avec C|
|c_int|int|pour la compatibilité ABI avec C|
|c_uint|unsigned int|pour la compatibilité ABI avec C|
|c_long|long|pour la compatibilité ABI avec C|
|c_ulong|unsigned long|pour la compatibilité ABI avec C|
|c_longlong|long long|pour la compatibilité ABI avec C|
|c_ulonglong|unsigned long long|pour la compatibilité ABI avec C|
|c_longdouble|long double|pour la compatibilité ABI avec C|
|f16|_Float16|Virgule flottante 16 bits (mantisse 10 bits) IEEE-754-2008 binaire16|
|f32|float|Virgule flottante 32 bits (mantisse 23 bits) IEEE-754-2008 binaire32|
|f64|double|Virgule flottante 64 bits (mantisse 52 bits) IEEE-754-2008 binary64|
|f80|long double|Virgule flottante 80 bits (Mante mantise 64 bits) IEEE-754-2008 Précision étendue 80 bits|
|f128|_Float128|Virgule flottante 128 bits (mantisse 112 bits) IEEE-754-2008 binaire128
bool|bool|true ou false|
|anyopaque|void|Utilisé pour les pointeurs effacés par type.|
|void|(aucun)|Toujours la valeur void{}|
|noreturn|(aucun)|le type de , , , , et breakcontinuereturnunreachablewhile (true) {}|
|type|(aucun)|Le type de types|
|anyerror|(aucun)|un code d’erreur|
|comptime_int|(aucun)|Seulement des valeurs connues en temps comptime. Le type de littéraux entiers.|
|comptime_float|(aucun)|Seulement des valeurs connues en temps comptime. Le type de float littéral|

## escape sequence

|Escape|Sequences|
|---|---|
|Escape Sequence|Name|
|\n	|Newline|
|\r	|Carriage Return|
\t	|Tab|
|\\ |Backslash|
|\'	|Single Quote|
|\"	Double Quote|
|\xNN	|hexadecimal 8-bit byte value (2 digits)|
|\u{NNNNNN}|	hexadecimal Unicode scalar value UTF-8 encoded (1 or more digits)|
NB : la valeur scalaire unicode valide maximale est  0x10ffff

## destructuring
il sert à separer des elements de types d'agregats indexables(tuples , arrays, vector)

## STRING LLITERAL
est un texte ecrit directement entre guillements dans le code zig
en zig lorsque on ecrit "zig" son type exacte est **(*const[3:0]u8)**
*const : est un pointeur constant
[3:0] : un tableau de 3octets terminé par le caractere nul 0 pour des raison d'interoperabilité avec le C
u8: c'est le type que reçoit le string , (unsigned-8bit integer) le UTF-8

NB : zig convertit automatiquement le string lutteral en slice d'octet constant ([]const u8)
```zig
const std = @import("std");

pub fn main() void {
    // Coercion automatique vers une slice []const u8
    const message: []const u8 = "Bonjour le monde !";

    // On peut obtenir la longueur directement avec .len
    std.debug.print("Texte: {s} | Longueur: {d} octets\n", .{ message, message.len });
}
```

**les chaines multilignes**zig n'utilise pas """ ou `` pour les chaines sur plusieurs lignes, il utilise la syntaxe \\ au debut de chaque ligne

```zig
const json_exemple =
    \\{
    \\  "nom": "Zig",
    \\  "type": "Langage de programmation",
    \\  "citation": "Pas de comportement indéfini caché."
    \\}
;
```

## formatage {}

les symboles **{}** en zig sert à specifier le format d'affichage d'un variable

par defaut {} signifie afficher cette valeur avec son format par defaut exemple 
```zig
const std = @import("std");

pub fn main() void {
    const age: u32 = 25;
    const pi: f32 = 3.14;
    const nom: []const u8 = "Alice";

    // Les acolytes vides fonctionnent pour presque tout
    std.debug.print("nom: {}, age: {}, pi: {}\n", .{ nom, age, pi });
}
```
pour changer la façon dont les variables doivent s'afficher voici un tableau explicatif de comment spectifier le format d'affichage d'une variable

|Spécificateur|Description|Exemple|Résultat|
|---|---|---|---|
|{s}|String (chaîne/slice d'octets)|print("{s}", .{"Hello"})|Hello|
|{d}|Décimal (entiers ou flottants)|print("{d}", .{42})|42|
|{x}|Hexadécimal (minuscules)|print("{x}", .{255})|ff|
|{X}|Hexadécimal (majuscules)|print("{X}", .{255})|FF|
|{b}|Binaire|print("{b}", .{5})|101|
|{c}|Caractère (affiche un octet en ASCII)|print("{c}", .{65})|A|
|{*}|Pointeur (affiche l'adresse mémoire)|print("{*}", .{ptr})|u8@7ffc...|
|{?}|Optional (si vous avez un ?T)|print("{?}", .{opt}|)42 ou null|
|{!}|Error Union (si vous avez un E!T)|print("{!}", .{res})|42 ou error.BadValue|

on peut aussi controler la largeur d'affichage et la precison des decimals avec
```zig
const pi: f64 = 3.14159265;

// Afficher seulement 2 décimales
std.debug.print("{d:.2}\n", .{pi}); // Resultat : 3.14
```
faire du **padding**
```zig
const x: u32 = 7;

// Remplir avec des zéros sur 4 chiffres de large
std.debug.print("{d:0>4}\n", .{x}); // Résultat : 0007

// Aligner à droite sur 5 caractères de large
std.debug.print("{d:>5}\n", .{x});  // Résultat : "    7"
```

NB : si vous avez un pointeur vers un tableau d'octes (*const [5]u8) ce qui est le cas pour le string litteral, {} affichera l'adresse memoire du tabelau , alors que {s} interpretera ce pointeur comme du texte à afficher 
```zig
const texte = "Zig"; // Type: *const [3:0]u8

std.debug.print("{}\n", .{texte});  // Affiche l'adresse (ex: u8@7ffc...)
std.debug.print("{s}\n", .{texte}); // Affiche le texte: "Zig"
```

## ZIG TEST
contraiment à beaucoup de langages qui necessitent des frameworks externes les test sont intégrés nativement au langage et au compilateur zig

en zig un test est simplement un blox de code précédé du mot-clé test
```zig
const std = @import("std");
const testing = std.testing;

fn additionner(a: i32, b: i32) i32 {
    return a + b;
}
// Déclaration d'un bloc de test
test "addition basique" {
    const resultat = additionner(2, 3);
    
    // On vérifie le résultat avec std.testing
    try testing.expectEqual(@as(i32, 5), resultat);
}
```

pour lancer le test il suffit de lancer dans le terminale
```bash
zig test votre_fichier.zig
```
pour valider vos test la bibliotheque standart fournit le module **std.testing**

voici certaines fonction :

|Fonction|Description|Exemple|
|---|---|---|
|expect(condition)|Vérifie qu'une condition est vraie (true).|try testing.expect(x > 0);|
|expectEqual(expected, actual)|Vérifie l'égalité entre deux valeurs de même type|.try testing.expectEqual(10, x);|
|expectEqualSlices(T, expected, actual)|Compare deux slices (ex: deux chaînes de caractères).|try testing.expectEqualSlices(u8, "abc", res);|
|expectError(expected_err, action)|Vérifie qu'une fonction renvoie bien une erreur précise.|try testing.expectError(error.DivisionByZero, div(1,0));|

nb : toutes ces fonctions peuvent echouer en renvoyant une erreur **error.TestUnexpectedResult** c'est pour cela qu'on met try devant chaque assertion

**detection automatique des fuites de memoire(memoiry leaks)** c'est une fonctionnalités les plus puissantes de zig
```zig
const std = @import("std");

test "detection de fuite" {
    // std.testing.allocator est un allocateur spécial pour les tests
    const allocator = std.testing.allocator;

    // On alloue de la mémoire
    const memory = try allocator.alloc(u32, 100);
    
    // OUPS ! On a oublié de faire : defer allocator.free(memory);
}
```

NB : si vous compilez votre projet en binaire final le compilateur ignore totalement les blocs test
-vous pouvez créez un dossier test/ qui importe vos modules pour les tester de l'exterieur
si vous avez 200 test dans un fichier vous pouvez executer un seul pendant le debogage en utiliser l'option **--test-filter**

```bash
zig test main.zig --test-filter "addition"
```

## VARIABLE
est une unité de stockage memoire
ils sont declarés par **const** et **var**

le variable au niveau du contenur ont une durée de vie statique sont independante de l"order et analysées paresseusement , il peuvent etre declarée à l'nterieur d"un struc , union, enum, opaque

il est egalement possible d'avoir des variables locales à durée de vie statique en utilisant des conteneurs à l'interieur d"une fonction

les variables locales apparaissent à l'interieur des fonction des bloc comptime, des blocs @cImport
