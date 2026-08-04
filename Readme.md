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
|\\	|Backslash|
|\'	|Single Quote|
|\"	Double Quote|
|\xNN	|hexadecimal 8-bit byte value (2 digits)
|\u{NNNNNN}	hexadecimal Unicode scalar value UTF-8 encoded (1 or more digits)|
NB : la valeur scalaire unicode valide maximale est  0x10ffff

## destructuring
il sert à separer des elements de types d'agregats indexables(tuples , arrays, vector)
