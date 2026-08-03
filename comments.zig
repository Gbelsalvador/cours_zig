const print = @import("std").debug.print;

pub fn main() void {
    // commentaire dans zig commence par // et finissent par un retour à la ligne
    // la ligne suivante est un commentaire et ne sera pas exécutée
    //print("hello ?\n", .{});
    print("helllo, word!\n", .{});
}
