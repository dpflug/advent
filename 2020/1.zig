const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Hello, {s}!\n", .{"world"});
    var cwd = std.fs.cwd();
    //defer cwd.close(); // race condition?

    var f = try cwd.openFile("1_sample.txt", .{});
    defer f.close();

    var buf: [1024]u8 = undefined;
    const bytes = try f.read(&buf);
    try stdout.print("Hello, {s}!\n", .{buf[0..bytes]});
}
