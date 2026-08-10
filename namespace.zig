//En Zig, les fonctions définies à l'intérieur d'une struct sont simplement des fonctions associées à cet espace de nom.
//Pour transformer une fonction en méthode "instance", on passe une instance (self: Point) ou un pointeur (self: *Point ou self: *const Point) comme premier paramètre.

const std = @import("std");

const Vector2 = struct {
    x: f32,
    y: f32,

    // "constructeur" conventionnelle (fonction statique de namespace)
    pub fn init(x: f32, y: f32) Vector2 {
        return Vector2{ .x = x, .y = y };
    }

    // methode de lecture (passe "self" par valeur ou pointeur constant)
    pub fn length(self: Vector2) f32 {
        return @sqrt(self.x * self.x + self.y * self.y);
    }

    // methode de modification (necessite un pointeur mutale *Vector2)
    pub fn scale(self: *Vector2, factor: f32) void {
        self.x *= factor;
        self.y *= factor;
    }
};

pub fn main() void {
    // appel du constructeur via le namespace
    var v = Vector2.init(3.0, 4.0);
    // syntaxe sucre: V.lengt() equivaut à vector2.length(v)

    std.debug.print("longueur: {d:.1}\n", .{v.length()});

    // syntaxe sucre : v.scale(..) prend automatiquement l'adresse (&v)
    v.scale(2.0);
    std.debug.print("nouvelle longueur : {d:.1}\n", .{v.length()});
}
