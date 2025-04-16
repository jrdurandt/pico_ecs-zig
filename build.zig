const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib_mod = b.addModule("pico_ecs", .{
        .target = target,
        .optimize = optimize,
        .link_libc = true,
        .pic = true,
        .sanitize_c = false,
    });

    const lib = b.addLibrary(.{
        .name = "pico_ecs",
        .root_module = lib_mod,
        .linkage = .static,
    });

    lib.addIncludePath(b.path("src"));
    lib.installHeadersDirectory(b.path("src"), "", .{});
    lib.addCSourceFile(.{ .file = b.path("src/pico_ecs.c") });

    b.installArtifact(lib);
}
