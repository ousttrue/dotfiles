[[zig]]

[`zig cc`: a Powerful Drop-In Replacement for GCC/Clang - Andrew Kelley](https://andrewkelley.me/post/zig-cc-powerful-drop-in-replacement-gcc-clang.html)


# from go
[[cgo]]
[Zig Makes Go Cross Compilation Just Work - DEV Community](https://dev.to/kristoff/zig-makes-go-cross-compilation-just-work-29ho)

# dwarf
- [0.11.0 Release Notes ⚡ The Zig Programming Language](https://ziglang.org/download/0.11.0/release-notes.html#Debugging)

# rc

- https://www.ryanliptak.com/blog/zig-is-a-windows-resource-compiler/

```py
        for (arg, match, rc_type) in [
                ('/?', '^.*Microsoft.*Resource Compiler.*$', ResourceCompilerType.rc),
                ('/?', 'LLVM Resource Converter.*$', ResourceCompilerType.rc),
                ('--version', '^.*GNU windres.*$', ResourceCompilerType.windres),
                ('--version', '^.*Wine Resource Compiler.*$', ResourceCompilerType.wrc),
                # zig rc
                ('/?', '^.*zig rc.*$', ResourceCompilerType.rc),
        ]:
            p, o, e = mesonlib.Popen_safe(rescomp.get_command() + [arg])
            m = re.search(match, o, re.MULTILINE)
            if m:
                mlog.log('Windows resource compiler: %s' % m.group())
                self._rescomp = (rescomp, rc_type)
                break
            # e
            m = re.search(match, e, re.MULTILINE)
            if m:
                mlog.log('Windows resource compiler: %s' % m.group())
                self._rescomp = (rescomp, rc_type)
                break
        else:
            raise MesonException('Could not determine type of Windows resource compiler')
```

- https://github.com/ziglang/zig/issues/15107#issuecomment-2048063178
