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
- au millieu d'une expression
- avant un commentaire non medical
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

Vous ne pouvez pas utiliser un mot-clé réservé (fn, const, var, pub, struct, etc.) comme nom classique
```zig
const max_speed = 100; // 'max_speed' est l'identifiant
var user_count: u32 = 0; // 'user_count' est l'identifiant
```
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

**le variable au niveau du contene(GLOBAL& CONTAINER VARIABLES)**

 ont une durée de vie statique sont independante de l"order et analysées paresseusement , il peuvent etre declarée à l'nterieur d"un struc , union, enum, opaque ou en dehors de toute fonction
 ils sont stocké eb memoire globale (.data ou .bss du binaire) et accessible à tous le thread 

il est egalement possible d'avoir des variables locales à durée de vie statique en utilisant des conteneurs à l'interieur d"une fonction

**VARIABLE LOCALE(LOCAL VARIABLE)** est une variable declarée à l'interieur d'un bloc de code (une fonction, une boucle while , un bloc if)
c'est sont de variables à une durée de vie qui dure seulement pendant le temps d'execution du bloc dans lequelle elle se trouve à la fin de la fonction ou du bloc sa memire est libéreéé automatiquement

Si vous voulez l'équivalent d'une variable statique locale à une fonction, vous pouvez utiliser une struct anonyme à l'intérieur de la fonction :
```zig
fn comptage() u32 {
    const S = struct {
        var val: u32 = 0; // Se comporte exactement comme une variable 'static'
    };
    S.val += 1;
    return S.val;
}
```

**VARIABLE DE THREAD(threadlocal)**

le mot-clé threadlocal permet d'indiquer qu'une variable globale doit avoir une copie distincte pour chaque thread il est stocké dans la memoire reservee au thread (TLS (thread local storage)) ça durée depends su thread il permet d'eviter d'avoir à utliser des verroux(mutex) car chaque thread modifie sa propre version isolée de la variable

```zig
// Chaque thread aura son propre 'id_appel' indépendant
threadlocal var id_appel: u32 = 0;

pub fn traiterRequete() void {
    id_appel += 1; // Ne modifiera pas la valeur des autres threads
}
```

nb:Par défaut, les variables globales sont partagées entre tous les threads.

**COMPTIME** est une fonctionalité de zig qui indique qu"une valeur, variable ou un calcul doit etre executé pendant la compilation et non pendant l"execution du programme

```zig
pub fn main() void {
    // Ce calcul (2 + 3) se fait lors de la compilation
    comptime var x: i32 = 2;
    comptime {
        x += 3;
    }

    // Dans le binaire final, c'est comme si vous aviez écrit : const y = 5;
    const y = x;
}
```

En Zig, les types sont des valeurs manipulatibles uniquement au moment de la compilation

```zig
// 'T' est un type passé à la compilation
fn creerTableau(comptime T: type, comptime taille: usize) [taille]T {
    return [_]T{0} ** taille;
}

// Utilisation :
var mon_tableau = creerTableau(u32, 10); // Génère un [10]u32
```
Tableaurécapitulatif

|Concept|Déclaration|Quand est-elle créée ?|Où vit-elle ?|partagée entre threads ?|
|---|---|---|---|---|
|Locale|var / const dans une fn|À l'exécution|Pile (Stack)|Non (propre au thread)
|Statique Globalevar |/ const hors fn|Au lancement du programme|Mémoire globale (.data)|Oui (accès partagé)|
|Thread Local|threadlocal var|À la création du thread|TLS (Thread Local Storage)|Non (isolée par thread)|
|Comptime|comptime var / const|À la compilation|Dans le binaire (en dur)|N/A (n'existe plus à l'exécution)|

## FLOAT

zig possete les types de virgule flottante suivants

f16 - IEEE-754-2008 binaire16
f32 - IEEE-754-2008 binaire32
f64 - IEEE-754-2008 binaire64
f80 - IEEE-754-2008 Précision étendue 80 bits
f128 - IEEE-754-2008 binaire128
c_longdouble - correspondances pour la cible C ABIlong double

## TABLEAU DES OPERATUERS

![Capture d'écran](img/operateur%20(1).png)
![Capture d'écran](img/operateur%20(2).png)
![Capture d'écran](img/operateur%20(3).png)
![Capture d'écran](img/operateur%20(4).png)
![Capture d'écran](img/operateur%20(5).png)
![Capture d'écran](img/operateur%20(6).png)
![Capture d'écran](img/operateur%20(7).png)
![Capture d'écran](img/operateur%20(8).png)

bon içi je me concentre plus sur les operateur nouveau pour moi :

### ~ (NOT binaire / Inversion Bitwise)
c'est l'operateur d'inversion bit à bit il inverse chaque bit de son operateur

### orelse (Valeur par défaut pour Optionnel)
zig utilise le type optionnel ?T pour les valeurs qui peuvent etre null l'operateur orelse permet de deballer un optionnel s'il vaut null il bascule sur une valeur par defaut ou execute un blOC/retour de fonction(retrn, unreachable)

### .? (Déballage d'Optionnel)
l'operateur postfixe .? est un raccourci pour deballer une valeur optionnelle en affirmant qu'elle n'est pas null

NB : Attention : Si la valeur est réellement null, le programme déclenche un panic (en mode Debug/ReleaseSafe) ou un comportement indéfini (Safety-checked undefined behavior en ReleaseFast).

### catch (Gestion des Erreurs)
en zig les erreurs sont vehiculée par le type error union (Eroor!T) l'operateur catch permet de intercepter l'erreur et de fournir une valeur de repli ou de la gerer

### ++ (Concaténation à la compilation)
L'opérateur ++ sert à concaténer deux tableaux ou slices de même type.

NB : Cet opérateur fonctionne uniquement sur des valeurs dont la taille est connue à la compilation (comptime).

### .* (Déréférencement de pointeur)
Zig utilise l'opérateur postfixe .* pour accéder à la valeur pointée par un pointeur (équivalent du *p en C).

### || (Union de jeux d'erreurs)
L'opérateur || a deux usages selon le contexte :

En logique booléenne : L'opérateur classique "OU" logique (if (a || b)).

Pour les types d'erreurs : Il combine deux ensembles d'erreurs (Error Sets) pour en créer un nouveau.

## ARRAY
est une sequence d'elements de taille fixe contigue en memoire
sa dimension et le type de ses elements sont obligatoirement connus des la compilation(comptime)

**declaration et initialisation** 
le type d'un tableau s'ecrit [N]T ou N est le nombre d'elements (comptime_init) et le T le type d'elements

```zig
const std = @import("std");

pub fn main() void {
    // Déclaration explicite
    const numbers: [5]i32 = [5]i32{ 1, 2, 3, 4, 5 };

    // Inférence de la taille avec '_'
    const colors = [_]u8{ 255, 128, 0 };

    // Initialisation répétitive (opérateur **)
    var buffer: [100]u8 = [_]u8{0} ** 100; // 100 octets initialisés à 0
}
```
**operation de compilation (++ et **)**

Zig propose deux opérateurs d'enchaînement exécutables uniquement sur des valeurs connues à la compilation :
++ (Concaténation) : Assemble deux tableaux de même type d'élément.
** (Répétition) : Duplique un tableau $N$ fois.

```zig
const a = [_]i32{ 1, 2 };
const b = [_]i32{ 3, 4 };

const concatenated = a ++ b; // Resultat : [1, 2, 3, 4] (type [4]i32)
const repeated = a ** 3;     // Resultat : [1, 2, 1, 2, 1, 2] (type [6]i32)
```

**acces et parcours**
Accès : Indexation classique à base 0 via arr[index]. Les débordements d'indice sont vérifiés à la compilation (si l'index est constant) ou déclenchent un panic en mode Debug/ReleaseSafe à l'exécution.

Taille : Propriété .len

```zig
const items = [_]i32{ 10, 20, 30 };

// Parcours simple
for (items) |item| {
    _ = item;
}

// Parcours avec index
for (items, 0..) |item, index| {
    _ = index;
    _ = item;
}

// Parcours par pointeur pour modification
var mutable_items = [_]i32{ 1, 2, 3 };
for (&mutable_items) |*item| {
    item.* *= 2;
}
```

**Tableaux Multidimensionnels**
Les tableaux à plusieurs dimensions sont simplement des tableaux de tableaux ([Lignes][Colonnes]T) :

```zig
const matrix: [2][3]i32 = [2][3]i32{
    [_]i32{ 1, 2, 3 },
    [_]i32{ 4, 5, 6 },
};

const val = matrix[1][0]; // 4
```
**Tableaux avec Sentinelle**
Un tableau peut inclure une valeur de fin explicite appelée sentinelle, notée [N:valeur]T. C'est le mécanisme utilisé pour garantir la compatibilité avec C (chaînes de caractères terminées par \0).

```zig
// Tableau de 5 octets se terminant obligatoirement par 0
const hello: [5:0]u8 = [_:0]u8{ 'h', 'e', 'l', 'l', 'o' };

// Le compilateur garantit que hello[5] existe et vaut 0
```
En Zig, les fonctions prennent rarement des tableaux fixes [N]T en paramètre pour éviter d'être restreintes à une seule taille. On utilise des slices ([]T ou []const T). Un pointeur vers un tableau *[N]T se convertit automatiquement en slice.
```zig
fn printSum(numbers: []const i32) i32 {
    var sum: i32 = 0;
    for (numbers) |n| sum += n;
    return sum;
}

pub fn main() void {
    const arr = [_]i32{ 10, 20, 30, 40, 50 };

    // Coercion d'un pointeur de tableau (*[5]i32) vers une slice ([]const i32)
    _ = printSum(&arr);

    // Slicing d'une sous-partie
    _ = printSum(arr[1..4]); // Passe les éléments 20, 30, 40
}
```

## VECTEURS
est un groupe de booléens , integers, float ou pointeur qui sont utilisés en parallèle en utilisant des instructions SIMD 
ils occupent un registre vectoriel du processeur (SSE, AVX, NEON)
nb : Les vecteurs supportent généralement les mêmes opérateurs intégrés que leurs types de base sous-jacents. La seule exception concerne les mots-clés « and » et « or » sur les vecteurs de bools, puisque Ces opérateurs affectent le flux de contrôle, ce qui n’est pas autorisé pour les vecteurs. Toutes les autres opérations sont effectuées élément par élément, et retournent un vecteur de même longueur comme vecteurs d’entrée. Cela inclut :
-arithmetique (+, -, ., *, @divfloor, @sqrt, @ceil, @log)
-operateurs bit à bit : >><<&|~
operateur de comparaison : <>==
booléen non (!)

il est interdit d'utiliser un operateur math sur un melange de scalaire et vecteurs

NB : les tableaux dynamiques (std.ArrayList) l'equivalent de std::vector en C++ ou Vec<T> en Rust pour gérer des collections de données à taille variable

```zig
const std = @import("std");

pub fn main() void {
    const Vec4f = @Vector(4, f32);

    const a: Vec4f = .{ 1.0, 2.0, 3.0, 4.0 };
    const b: Vec4f = .{ 5.0, 6.0, 7.0, 8.0 };

    // Addition vectorielle SIMD (effectuée en une/deux instructions processeur)
    const c = a + b; // Resultat: .{ 6.0, 8.0, 10.0, 12.0 }

    // Multiplier par un scalaire avec @splat
    const scalar: f32 = 2.0;
    const scaled = a * @as(Vec4f, @splat(scalar)); // .{ 2.0, 4.0, 6.0, 8.0 }
    
    _ = c;
    _ = scaled;
}
```

**built-ins utiles pour @vector**

**@splat(valeur)** : duplique une valeur scalaire dans toutes les cases du vecteur

**@reudce(op, vec)** : reduit le vecteur à une valeur scalaire en appliquant l'operation op(.add, .Mul, Min, .Max, .Or, .And etc..)

**@shuffle(T,a, b, mask)**: reorganise combine ou extrait les elements de deux vecteurs a et b semon des indices definis dans mask

```zig
const v = @Vector(4, f32){ 1.0, 2.0, 3.0, 4.0 };

// Somme de tous les éléments du vecteur
const sum = @reduce(.Add, v); // 10.0

// Réorganisation des éléments via masque d'indices (-1 = undefined)
const mask = @Vector(4, i32){ 3, 2, 1, 0 };
const reversed = @shuffle(f32, v, undefined, mask); // .{ 4.0, 3.0, 2.0, 1.0 }
```

## 2. Les Tableaux Dynamiques (std.ArrayList)
Si vous cherchez l'équivalent d'un std::vector de C++ (une liste contiguë en mémoire dont la capacité grandit dynamiquement), Zig utilise la structure de la bibliothèque standard std.ArrayList(T).

Puisqu'il n'y a pas d'allocateur caché en Zig, toute création d'un tableau dynamique requiert d'expliciter un std.mem.Allocator.

```zig
const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    // Instanciation de l'ArrayList pour des entiers i32
    var list = std.ArrayList(i32).init(allocator);
    defer list.deinit(); // Libération de la mémoire attribuée

    // Ajout d'éléments
    try list.append(10);
    try list.append(20);
    try list.appendSlice(&[_]i32{ 30, 40, 50 });

    // Accès aux éléments et taille
    const item = list.items[0]; // 10
    const count = list.items.len; // 5

    // Obtenir une slice sous-jacente ([]i32)
    const slice = list.items;
    
    _ = item;
    _ = count;
    _ = slice;
}
```

Comparatif Récapitulatif
|Caractéristique|@Vector(N, T)|std.ArrayList(T)|
|---|---|---|
|Objectif|Calcul parallèle SIMD / Matériel|Stockage dynamique en mémoire|
|Taille|Fixe à la compilation (N)|Variable à l'exécution|
|Gestion mémoire|Pile / Registres CPU|Tas (Allocateur explicite)|
|Types supportés|Primitifs uniquement (f32, i32, ...)|Tous types (structs, pointeurs, etc.)|
|Accès mémoire|Contigu, aligné sur registres SIMD|Contigu sur le tas|

## les pointeurs
Zig possède deux types d’indicateurs : un seul objet et un élément multiple.

*T - pointeur à un seul élément vers exactement un élément.
Prend en compte la syntaxe défif : ptr.*
Prend en compte la syntaxe tranche : ptr[0..1]
Prend en charge la soustraction par pointeur : ptr - ptr
[*]T - pointeur à plusieurs éléments vers un nombre inconnu d’éléments.
Prend en charge la syntaxe des indices : ptr[i]
Prend en charge la syntaxe des tranches : et ptr[start..end]ptr[start..]
Prend en charge l’arithmétique pointeur-entier : , ptr + int|ptr - int
Prend en charge la soustraction par pointeur : ptr - ptr
T doit avoir une taille connue, ce qui signifie qu’il ne peut pas être ou tout autre type opaque. anyopaque

Ces types sont étroitement liés aux Arrays et aux Slices :

*[N]T - pointeur vers N éléments, identique au pointeur d’un seul élément vers un tableau.
Prend en charge la syntaxe des indices : array_ptr[i]
Prend en compte la syntaxe tranche : array_ptr[start..end]
Supports de la propriété de la lienne : array_ptr.len
Prend en charge la soustraction par pointeur : array_ptr - array_ptr
[]T - est une tranche (un pointeur de gros moteur, qui contient un pointeur de type et une longueur). [*]T
Prend en charge la syntaxe des indices : slice[i]
Prend en compte la syntaxe tranche : slice[start..end]
Supports de la propriété de la lienne : slice.len
À utiliser pour obtenir un pointeur à un seul élément :&x

```zig
const std = @import("std");

pub fn main() void {
    var x: i32 = 42;
    
    // Obtenir l'adresse avec '&'
    const ptr: *i32 = &x;
    
    // Modifier la valeur pointée via '.*'
    ptr.* = 100;
    
    // Pointeur constant
    const const_ptr: *const i32 = &x;
    // const_ptr.* = 200; // Erreur de compilation !
}
```

```zig
var array = [_]i32{ 10, 20, 30, 40 };

// Coercion vers un pointeur multi-éléments
const ptr: [*]i32 = &array;

// Arithmétique de pointeur et indexation
const second = ptr[1];       // 20
const third = (ptr + 2).*;   // 30
```

### 3. Pointeur Aligné et Sentinelle ([*:valeur]T)
Ces pointeurs étendent les pointeurs multi-éléments pour imposer des contraintes spécifiques au niveau du système :Pointeur à sentinelle ([*:0]u8) : Indique qu'un élément de fin spécifique (comme 0 ou \0) marque la fin du bloc mémoire. C'est le type exact utilisé pour les chaînes de caractères C (C-strings).Pointeur aligné (*align(N) T) : Garantit que l'adresse mémoire est un multiple de $N$ octets (très utile pour les opérations SIMD ou les accès matériel).

### 4. Pointeur Optionnel (?*T) et Absence de Pointeur-Nul
En Zig, un pointeur normal (*T) ne peut JAMAIS être nul. Le concept de NULL ou nullptr n'existe pas de façon implicite.

Pour représenter la possibilité d'une absence de valeur, vous devez combiner le type optionnel ? avec un pointeur : ?*T.

Le compilateur optimise cette combinaison : un ?*T occupe exactement la même taille en mémoire qu'un pointeur C (8 octets sur système 64-bit), car la valeur zéro (0x0) est réutilisée en interne pour représenter null.

```zig
var x: i32 = 10;
var nullable_ptr: ?*i32 = &x;

// Remise à zéro
nullable_ptr = null;

// Vérification et déballage (Unwrapping)
if (nullable_ptr) |ptr| {
    ptr.* = 20;
} else {
    // Traitement du cas null
}
```

### 5. Pointeur Opaque (*anyopaque)
Le type *anyopaque est l'équivalent du void* en C. Il représente un pointeur vers un emplacement mémoire dont le type n'est pas connu à la compilation.

On l'utilise pour faire de l'abstraction de types (par exemple dans l'implémentation de std.mem.Allocator ou de vtables) et on le convertit avec @ptrCast ou @alignCast.

```zig
var data: i32 = 1234;
const opaque_ptr: *anyopaque = &data;

// Conversion explicite vers un pointeur i32
const typed_ptr: *i32 = @ptrCast(@alignCast(opaque_ptr));
```

|Type|Description|Taille mémoire|Arithmétique autorisé ?|Sûr contre le débordement ?|
|--|--|--|--|--|
|*T|Pointeur vers un élément|1 adresse|Non|Oui|
|?*T|Pointeur pouvant être null|1 adresse|Non|Oui (forcé par le type)|
|[*]T|Pointeur vers $N$ éléments (taille inconnue)|1 adresse|Oui|Non|
|[*:0]T|Pointeur se terminant par une sentinelle|1 adresse|Oui|Dépend de la sentinelle|
|[]T (Slice)|Pointeur + Longueur|2 mots (ptr + len)|Via sub-slicing|Oui|

en zig , volatile, l'alignement et allowzero sont des modificateurs de pointeurs et de mémoire essentiels pour la programmation système de bas niveau, l'interaction avec le matériel (MMIO) et la compatibilité FFI (C)

**volatile(Empêcher l'optimisation du compilateur)** 
Lorsque vous marquez un pointeur ou une opération de déférencement avec volatile, vous indiquez au compilateur (LLVM) que la valeur mémoire pointée peut changer à tout moment en dehors du flux normal du programme (par un périphérique matériel, un registre système, ou une interruption).

Comportement :
Le compilateur n'a pas le droit d'optimiser, de supprimer ou de réordonner les lectures et écritures.

Chaque lecture/écriture explicite dans le code génère exactement une instruction d'accès mémoire dans l'exécutable final.

```zig
// Adresse d'un registre matériel de statut (Memory-Mapped I/O)
const STATUS_REG: *volatile u32 = @ptrFromInt(0x4000_0000);

pub fn waitForReady() void {
    // Sans volatile, le compilateur lirait le registre une seule fois 
    // et créerait une boucle infinie s'il vaut 0 au départ.
    while (STATUS_REG.* == 0) {
        // Attente active
    }
}
```

**L'Alignement (align(N))**
L'alignement stipule que l'adresse mémoire d'une donnée doit être un multiple exact d'un nombre $N$ (où $N$ est une puissance de 2).Par défaut, Zig attribue à chaque type un alignement naturel selon l'architecture (par exemple, 4 octets pour un u32, 8 octets pour un u64). Vous pouvez forcer un alignement sur les variables, les structures et les pointeurs.

```zig
// Un tampon de 64 octets aligné sur 16 octets (indispensable pour les instructions SIMD AVX)
var buffer: [64]u8 align(16) = undefined;

// Un pointeur garantissant un alignement de 16 octets
const ptr: *align(16) [64]u8 = &buffer;
```
Dégradations et Casts d'Alignement :Dégradation automatique : Un pointeur plus aligné peut être converti implicitement en un pointeur moins aligné (*align(16) i32 $\rightarrow$ *align(4) i32).Promotions explicites : Passer d'un alignement faible à un alignement plus strict requiert @alignCast() pour avertir le compilateur que vous garantissez l'adresse mémoire à l'exécution.

```zig
var raw_bytes align(4) = [_]u8{ 1, 2, 3, 4 };

// Cast explicite en spécifiant l'alignement requis
const ptr_u32: *align(4) u32 = @ptrCast(@alignCast(&raw_bytes));
```

**allowzero (Autoriser l'adresse 0x0)**
Par défaut, Zig considère que l'adresse mémoire zéro (0x0) est invalide pour un pointeur non-optionnel (*T). Déférencer un pointeur *T pointant sur 0x0 déclenche un Safety Panic (ou un comportement indéfini en mode ReleaseFast).

Cependant, dans le développement de noyaux (kernel), de bootloaders ou sur certains microcontrôleurs (ex: ARM Cortex-M), la table des vecteurs d'interruption est directement mappée à l'adresse mémoire 0x00000000.

Le mot-clé allowzero permet d'expliciter qu'un pointeur à l'adresse zéro est valide et n'est pas une valeur nulle.

```zig
// Pointeur non-optionnel autorisant spécifiquement l'adresse 0x0
const vector_table: *allowzero u32 = @ptrFromInt(0x0000_0000);

pub fn readVectorTable() u32 {
    // Valide et ne déclenche aucun Safety Panic même à l'adresse 0x0
    return vector_table.*;
}
```

Différence cruciale avec ?*T :
?*T : Pointeur optionnel où null est représenté en interne par l'adresse 0x0. Il sert à vérifier l'absence de valeur.

*allowzero T : Pointeur ordinaire qui ne peut pas être null, mais dont la cible mémoire valide est physiquement localisée à l'adresse 0x0.

Tableau Récapitulatif
Propriété|Rôle principal|Impact à la compilation / exécution|
|--|--|--|
|volatil|empêche l'invalidation / suppression des accès mémoire par le compilateur.|Force la génération matérielle exacte des instructions load / store.|
|align(N)|Impose une contrainte de placement mémoire (adresse divisible par N).|Génère un code d'accès plus efficace ou requis par le processeur/SIMD.|
|allowzero|Déclare que l'adresse 0x0 est un emplacement mémoire légitime.|Désactive le check de sûreté "adresse zéro" sans introduire le type optionnel null.|

# SLICE (ou TRANCHE)
est un pointeur associé à une longueur c'est une vue dynamique sur une senquence contigue d'elements stockés en memoire (comme un tabeleau ou un buffer)
Contrairement à un pointeur simple (*T), un slice sait combien d'éléments il référence, ce qui permet à Zig d'effectuer des vérifications de bornes (bounds checking) à l'exécution et d'éviter les débordements de mémoire.

La syntaxe d'un type slice s'écrit []T (où T est le type des éléments) :

Slice mutable ([]T) : permet de lire et modifier les éléments.

Slice constant ([]const T) : permet uniquement la lecture.
En mémoire, un slice occupe la taille de 2 pointeurs (soit 16 octets sur une architecture 64-bit) :

Un pointeur vers le premier élément (ptr).

La longueur sous forme d'entier non signé (len).
```zig
const std = @import("std");

pub fn main() void {
    // Un tableau statique sur la pile
    var array = [_]i32{ 10, 20, 30, 40, 50 };

    // On crée un slice à partir du tableau (de l'index 1 à 4 exclu)
    const slice: []i32 = array[1..4];

    // slice.len == 3
    // slice[0] vaut 20, slice[1] vaut 30, slice[2] vaut 40
}
```

**2. Distinction importante : Array, Pointer et Slice**
|Type|Syntaxe|Taille connue à la compilation ?|Stocke la longueur en mémoire |
|?Array (Tableau)|[5]i32|Oui (fait partie du type)|Non (intégré dans le type)|
|Pointer (Pointeur unique)|*i32|Non (pointe sur 1 élément)|Non|
|Slice|[]i32|Non (déterminée à l'exécution)|Oui (ptr + len)|

**3. Fonctionnalités clés des Slices en Zig**
A. Tranchage dynamique (Slicing)
La syntaxe container[start..end] permet d'extraire une vue :

start est l'index de début (inclus).

end est l'index de fin (exclus).

Si les bornes sont connues à la compilation, Zig peut caster automatiquement le slice vers un pointeur de tableau à taille fixe (*[N]T).

### Slices avec terminaison nulle (Sentinel-Terminated Slices)
Pour interagir avec le C (strings terminées par \0), Zig propose des slices sentinelles sous la forme [:0]const u8. La longueur ne compte pas le caractère nul final, mais le compilateur garantit que slice[slice.len] == 0.

### Slices de constantes et chaînes de caractères
En Zig, les littéraux de chaîne (ex: "Hello") sont de type *const [5:0]u8. Lorsqu'ils sont passés à des fonctions acceptant des slices, ils se coerced (se convertissent) de façon transparente en []const u8.

```zig
fn printString(s: []const u8) void {
    std.debug.print("Texte: {s}, Taille: {d}\n", .{ s, s.len });
}
```

## STRUC
En Zig, la struct (structure) est le bloc de construction fondamental. Contrairement à des langages comme le C++ ou Java, Zig n'a pas de classes ou d'héritage : tout est basé sur les struct, qui regroupent à la fois des données (champs) et des comportements (fonctions).

Zig propose trois variantes spéciales de struct selon l'usage mémoire et l'interopérabilité.

**Struct classique (par défaut)**
Réordonne automatiquement les champs pour optimiser l'alignement en mémoire et réduire le padding.

L'ordre des champs en mémoire n'est pas garanti.

**extern struct (Compatible C)**
Conserve exactement l'ordre des champs défini dans le code.

Suit la convention d'alignement/padding du C de la plateforme cible.

Essentiel pour le FFI (interopérabilité C) et les appels système.
```zig
const C_Header = extern struct {
    magic: u32,
    payload_size: u16,
    flags: u8,
};

```

**packed struct (Contrôle au bit près)**
Aucun padding mémoire.

Permet de mapper directement des registres matériels ou des formats binaires compacts jusqu'au niveau du bit.

```zig
const StatusRegister = packed struct {
    enabled: bool,      // 1 bit
    ready: bool,        // 1 bit
    mode: u3,           // 3 bits
    _reserved: u3 = 0,  // 3 bits de bourrage
}; // Taille totale = 8 bits (1 octet)
```

**Structs Anonymes et Tuples**
Zig prend en charge la création de structs sans type prédéfini à la volée via la syntaxe
```zig
// Struct anonyme nommée
const config = .{
    .port = 8080,
    .host = "127.0.0.1",
};

// Tuple (struct anonyme avec champs numérotés)
const tuple = .{ 42, "hello", true };
// Accès : tuple[0] (42), tuple[1] ("hello")
```

**Metaprogramming : Generic Structs avec Comptime**
Il n'y a pas de mot-clé template ou generic en Zig. La généricité est réalisée en écrivant une fonction exécutée à la compilation (comptime) qui retourne un type struct.

```zig
fn Node(comptime T: type) type {
    return struct {
        data: T,
        next: ?*Node(T) = null, // Liste chaînée générique

        const Self = @this(); // Référence au type courant

        pub fn init(data: T) Self {
            return Self{ .data = data };
        }
    };
}

pub fn main() void {
    // Génère le type Node pour les i32
    const IntNode = Node(i32);
    var node = IntNode.init(100);

    _ = node;
}
```

## TUPLE
En Zig, un tuple est une structure anonyme dont les champs sont automatiquement nommés par leur index numérique (0, 1, 2, etc.).

Les tuples sont très utilisés pour regrouper plusieurs valeurs de types différents sans avoir à déclarer une struct nommée au préalable, notamment pour la métaprogrammation avec comptime ou pour passer des arguments à des fonctions de formatage comme std.debug.print.

Un tuple s'instancie avec la syntaxe de littéral anonyme .{ ... }. Son type est automatiquement déduit par le compilateur sous la forme d'une struct anonyme avec des champs indexés.

**Accès aux champs à la compilation (comptime)**
Même si la syntaxe d'accès ressemble à celle d'un tableau (tuple[i]), les tuples ne sont pas des tableaux.

Puisque chaque élément d'un tuple peut avoir un type différent, l'index utilisé pour accéder à un champ doit être connu à la compilation (comptime).

```zig
const tuple = .{ 10, "test" };

// ❌ ERREUR DE COMPILATION : 'i' est une variable d'exécution (runtime)
var i: usize = 0;
_ = tuple[i]; 

// ✅ CORRECT : 'i' est comptime ou directement un littéral
const i_comptime: usize = 0;
_ = tuple[i_comptime];
```

Un tuple possède une propriété spécifique : ses champs sont nommés "0", "1", "2", etc. Vous pouvez vérifier la nature d'un tuple à la compilation en inspectant son type via @typeInfo :

```zig
const std = @import("std");

fn isTuple(comptime T: type) bool {
    const info = @typeInfo(T);
    return if (info == .struct) info.struct.is_tuple else false;
}
```

Comme pour les tableaux, vous pouvez concaténer deux tuples à la compilation grâce à l'opérateur ++ :

```zig
const t1 = .{ 1, 2 };
const t2 = .{ "trois", true };

const t3 = t1 ++ t2; // Equivalent à .{ 1, 2, "trois", true }
```

Vous pouvez dupliquer le contenu d'un tuple avec l'opérateur ** :

```zig
const t = .{ 42, "abc" } ** 2; // Equivalent à .{ 42, "abc", 42, "abc" }
```

# ENUM (enumeration)
est un type de première classe qui permet de définir une liste de valeurs distinctes et nommées (les tags).

Zig pousse les enums plus loin que le C en offrant la sécurité des types, l'intégration des méthodes, l'interopérabilité avec les types entiers et les tagged unions (unions étiquetées).

NB : Exhaustivité du switch : En Zig, un switch sur un enum doit couvrir toutes les valeurs possibles. Si une valeur manque, le code ne compile pas (sauf si vous ajoutez une branche else).

Par défaut, Zig choisit automatiquement le type entier le plus petit possible pour stocker l'enum. Vous pouvez cependant forcer un type entier (ex: u8, u16, i32) en le précisant dans la définition :

```zig
const std = @import("std");

// L'enum utilise explicitement un u8 en mémoire
const HttpStatus = enum(u16) {
    ok = 200,
    created = 201,
    not_found = 404,
    internal_server_error = 500,
};

pub fn main() void {
    const code = HttpStatus.not_found;

    // Convertir un enum vers son entier sous-jacent (@intFromEnum)
    const raw_code = @intFromEnum(code); // 404

    // Convertir un entier vers un enum (@enumFromInt)
    const status: HttpStatus = @enumFromInt(200); // .ok
    _ = status;
}
```

Le cas d'usage le plus puissant des enums en Zig est de servir d'étiquette (tag) pour une union. C'est ce qui équivaut à un enum en Rust ou un type algébrique de données (ADT).

Une tagged union associe à chaque valeur de l'enum une charge utile (payload) spécifique :

## 5. Fonctions built-inpratiques pour les Enums
|Fonction built-in|Rôle / Description|
|--|--|
|@intFromEnum(e)|Convertit un enum en son entier correspondant.|
|@enumFromInt(i)|Convertit un entier en valeur enum (déclenche un safety panic si la valeur n'existe pas)|
|@tagName(e)|Retourne le nom du variant sous forme de chaîne de caractères ([]const u8).|
|@typeInfo(E)|.enumInspecte les variants, les valeurs et les champs d'un enum à la compilation (comptime).|

