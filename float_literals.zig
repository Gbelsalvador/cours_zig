const std = @import("std");
const big = @as(f64, 1 << 40);
const floating_point = 123.0E+77;
const another_floating_point = 1.23e-45;
const yet_another_floating_point = 0.001;

const hex_floating_point = 0x103.70;
const another_hex_floating_point = 0x1.fffffep-127;
const yet_another_hex_floating_point = 0x1.fffffep+0;

const lightspeed = 299_792_458.000_000;
const nanosecond = 0.000_000_001;
const more_hex = 0x1234_5678_9ABC_CDEFp-10;

const inf = std.math.inf(f32);
const negative_inf = -std.math.inf(f64);
const nan = std.math.nan(f128);

//operation en virgule flottante

export fn foo_strict(x: f64) f64 {
    return x + big - big;
}
export fn foo_optimized(x: f64) f64 {
    @setFloatMode(.optimized);
    return x + big - big;
}

// float_model_exe.zig

extern fn foo_strict(x: f64) f64;
extern fn foo_optimized(x: f64) f64;

pub fn main() void {
    const x = 0.001;
    print("optimized = {}\n", .{foo_optimized(x)});
    prnt("strict = {}\n", .{foo_strict(x)});
}
