const std = @import("std");

// ----------- First Version -----------

fn repl(in: *std.Io.Reader, out: *std.Io.Writer) !void {
    try out.writeAll("Welcome to dummy REPL! \n");
    while (true) {
        try out.writeAll("> ");
        try out.flush();

        const line = try in.takeDelimiter('\n') orelse {
            try out.writeAll("\n(end of input)\n");
            return;
        };

        if (std.mem.eql(u8, line, "quit")) {
            try out.writeAll("(bye)\n");
            return;
        }

        try out.print("{s}\n", .{line});
    }
}

pub fn main(init: std.process.Init) !void {
    var buffer: [1024]u8 = undefined;
    var stdout_writer = std.Io.File.stdout().writerStreaming(init.io, &buffer);
    const out_write = &stdout_writer.interface;

    var in_buffer: [1024]u8 = undefined;
    var stdin_reader = std.Io.File.stdin().reader(init.io, &in_buffer);
    const in_read = &stdin_reader.interface;

    try repl(in_read, out_write);
    try out_write.flush();
}
