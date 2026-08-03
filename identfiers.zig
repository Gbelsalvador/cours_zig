const @"identifier with spaces in i" = 0xff;
const @"1SmallStep4man" = 112358;

const c = @import("std").c;
pub extern "c" fn @"error"() void;
pub extern "c" fn @"fstat$INODE64"(fd: c.fd_t, buf: *c.Stat) c_int;

const Color = enum {
    red,
    @"relly red",
};
const color: Color = .@"relly red";
