const std = @import("std");

// ----------- First Version -----------

// fn repl(input: []const u8, out: *std.Io.Writer) !void {
//     var reader: std.Io.Reader = .fixed(input);

//     try out.writeAll("Welcome to dummy REPL! \n");
//     while (true) {
//         try out.writeAll("> ");

//         const line = try reader.takeDelimiter('\n') orelse {
//             try out.writeAll("\n(end of input)\n");
//             return;
//         };

//         if (std.mem.eql(u8, line, "quit")) {
//             try out.writeAll("(bye)\n");
//             return;
//         }

//         try out.print("{s}\n", .{line});
//     }
// }

// pub fn main(init: std.process.Init) !void {
//     var buffer: [1024]u8 = undefined;
//     var stdout_writer = std.Io.File.stdout().writerStreaming(init.io, &buffer);
//     const out_write = &stdout_writer.interface;

//     try repl("echo still here \n", out_write);
//     try out_write.flush();
// }

// ---------- AI-assisted Version -----------
fn repl(reader: *std.Io.Reader, out: *std.Io.Writer) !void {
    while (true) {
        const line = try reader.takeDelimiter('\n') orelse return;
        try out.print("{s}\n", .{line});
        try out.flush();
    }
}

pub fn main(init: std.process.Init) !void {
    var buffer: [1024]u8 = undefined;
    var stdout_writer = std.Io.File.stdout().writerStreaming(init.io, &buffer);
    const out_write = &stdout_writer.interface;

    try repl("echo still here \n", out_write);
    try out_write.flush();
}
