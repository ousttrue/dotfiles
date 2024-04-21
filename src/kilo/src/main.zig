const std = @import("std");
const kilo = @cImport({
    @cInclude("kilo.h");
    @cInclude("kilo_highlight.h");
    @cInclude("ipty.h");
});

var E = kilo.editorConfig{};

fn handleSigWinCh(_: c_int) callconv(.C) void {
    kilo.updateWindowSize(&E);
    if (E.cy > E.screenrows)
        E.cy = E.screenrows - 1;
    if (E.cx > E.screencols)
        E.cx = E.screencols - 1;
    kilo.editorRefreshScreen(&E);
}

fn editorAtExit() callconv(.C) void {
    kilo.disableRawMode();
}

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    const args = try std.process.argsAlloc(allocator);

    if (args.len != 2) {
        @panic("Usage: kilo <filename>\n");
    }

    const stdout = std.io.getStdOut().writer();
    try stdout.print("{s}\n", .{args[1]});

    kilo.initEditor(&E, handleSigWinCh);

    E.syntax = kilo.editorSelectSyntaxHighlight(args[1]);
    _ = kilo.editorOpen(&E, args[1]);
    _ = kilo.enableRawMode(editorAtExit);
    _ = kilo.editorSetStatusMessage(&E, "HELP: Ctrl-S = save | Ctrl-Q = quit | Ctrl-F = find");
    while (true) {
        _ = kilo.editorRefreshScreen(&E);
        const input = kilo.getInput();
        _ = kilo.editorProcessKeypress(&E, input);
    }
}
