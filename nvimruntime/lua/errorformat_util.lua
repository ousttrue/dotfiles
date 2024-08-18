local M = {
  meson = function()
    print "errorformat_util.meson()"
    -- ninja: Entering directory `/grapho/build'
    -- ../subprojects/glew-2.2.0/include/GL/glew.h:224:14: fatal error: 'cstddef' file not found
    vim.opt.errorformat = "%Dninja: Entering directory `%f',%f:%l:%c: %t%*[^:]: %m,%f:%l:%c: fatal %t%*[^:]: %m"
  end,
}
return M

-- [1/12] Compiling C++ object src/libgrapho.a.p/grapho_gl3_texture.cpp.o
-- FAILED: src/libgrapho.a.p/grapho_gl3_texture.cpp.o
-- /usr/bin/clang++ -Isrc/libgrapho.a.p -Isrc -I../src -I../subprojects/glew-2.2.0/include -I../subprojects/DirectXMath/Inc -fdiagnostics-c
-- olor=always -D_GLIBCXX_ASSERTIONS=1 -D_FILE_OFFSET_BITS=64 -Wall -Winvalid-pch -O0 -g -std=c++2b -stdlib=libc++ -fPIC -Wno-defaulted-fun
-- ction-deleted -DGLEW_STATIC -MD -MQ src/libgrapho.a.p/grapho_gl3_texture.cpp.o -MF src/libgrapho.a.p/grapho_gl3_texture.cpp.o.d -o src/l
-- ibgrapho.a.p/grapho_gl3_texture.cpp.o -c ../src/grapho/gl3/texture.cpp
-- In file included from ../src/grapho/gl3/texture.cpp:2:
