package main

import (
	"flag"
	"fmt"
	"io"
	"log"
	"net/http"
	"os"
	"os/exec"
	"path"
	"strings"

	"github.com/fatih/color"
)

func DownloadFile(url string) error {
	filepath := path.Base(url)
	fmt.Printf("%s ", filepath)
	if _, err := os.Stat(filepath); err == nil {
		fmt.Println("=> already eixst")
		return nil
	}

	fmt.Println("=> download...")
	resp, err := http.Get(url)
	if err != nil {
		return err
	}
	defer resp.Body.Close()

	out, err := os.Create(filepath)
	if err != nil {
		return err
	}
	defer out.Close()

	_, err = io.Copy(out, resp.Body)
	return err
}

func cdOrPanic(dir string) {
	if err := os.Chdir(dir); err != nil {
		panic(err)
	}
}

func getUname() string {

	out, err := exec.Command("uname", "-m").Output()
	if err != nil {
		fmt.Println(err)
		return ""
	}
	return strings.TrimSpace(string(out))
}

// pathobj
type pathobj struct {
	path string
}

func (o *pathobj) String() string {
	return o.path
}

func newpath(path string) *pathobj {
	return &pathobj{path: path}
}

func (o *pathobj) IsExist() bool {
	_, err := os.Stat(o.path)
	return err == nil
}

func (o *pathobj) Chdir() error {
	return os.Chdir(o.path)
}

// lfs
type lfs struct {
	mount  *pathobj
	target string
}

func (l *lfs) String() string {
	return fmt.Sprintf("{mount: %v, target: %v}", l.mount, l.target)
}

func newlfs(path *pathobj) *lfs {
	return &lfs{mount: path, target: fmt.Sprintf("%s-lfs-linux-gnu", getUname())}
}

func (l *lfs) Build(url string, task string) {
	color.Green("Downlaod %s ...", url)
}

func main() {
	log.SetFlags(0)

	var mnt = flag.String("mnt", "", "LFS mount point")
	flag.Parse()

	// env_lfs := os.Getenv("LFS")
	if *mnt == "" {
		color.Red("usage: lfs {mnt_point}")
		os.Exit(1)
	}

	path := newpath(*mnt)
	if !path.IsExist() {
		color.Red("%v is not exist", *path)
		os.Exit(2)
	}

	lfs := newlfs(path)
	color.Green("%v", lfs)

	if err := path.Chdir(); err != nil {
		log.Fatal(err)
		os.Exit(3)
	}
	color.Green("chdir => %s", path)

	lfs.Build("https://sourceware.org/pub/binutils/releases/binutils-2.40.tar.xz", `
mkdir -p build
cd build
../configure --prefix=$LFS/tools --with-sysroot=$LFS --target=$LFS_TGT --disable-nls --enable-gprofng=no --disable-werror
make -j4
make install
`)

	// LFS=$HOME/lfs/mnt
	// LC_ALL=POSIX
	// LFS_TGT=$(uname -m)-lfs-linux-gnu
	// PATH=/usr/bin
	// if [ ! -L /bin ]; then PATH=/bin:$PATH; fi
	// PATH=$LFS/tools/bin:$PATH
	// CONFIG_SITE=$LFS/usr/share/config.site
	// export LFS LC_ALL LFS_TGT PATH CONFIG_SITE
	//
	// echo LFS: $LFS
	// echo LC_ALL: $LC_ALL
	// echo LFS_TGT: $LFS_TGT
	// echo PATH: $PATH
	// echo CONFIG_SITE: $CONFIG_SITE
	//
	// unalias -a
	//
	// PS1="LFS:\w\$ "

	//		// sources
	//		sources := path.Join(LFS_DIR, "sources")
	//		if _, err := os.Stat(sources); os.IsNotExist(err) {
	//			err = os.Mkdir(sources, 0777)
	//			if err != nil {
	//				os.Exit(3)
	//			}
	//			fmt.Printf("mkdir: %s\n", sources)
	//		}
	//		cdOrPanic(sources)
	//
	//		list := []string{
	//			,
	//
	//			"https://ftp.gnu.org/gnu/gcc/gcc-12.2.0/gcc-12.2.0.tar.xz",
	//			"https://ftp.gnu.org/gnu/gmp/gmp-6.2.1.tar.xz",
	//			"https://ftp.gnu.org/gnu/mpc/mpc-1.3.1.tar.gz",
	//			"https://ftp.gnu.org/gnu/mpfr/mpfr-4.2.0.tar.xz",
	//
	//			"https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.11.tar.xz",
	//
	//	        "https://ftp.gnu.org/gnu/glibc/glibc-2.37.tar.xz",
	//	        "https://www.linuxfromscratch.org/patches/lfs/11.3/glibc-2.37-fhs-1.patch",
	//		}
	//		for _, url := range list {
	//			if err := DownloadFile(url); err != nil {
	//				panic(err)
	//			}
	//		}
	//	}
	//
	// # 1m58
	// def binutils():
	//
	//	}
	//
	//	def gcc() {
	//	    tar xf gcc-12.2.0.tar.xz
	//	    cd gcc-12.2.0
	//
	//	    rm -rf mpfr-4.2.0 gmp-6.2.1 mpc-1.3.1
	//	    tar -xf ../mpfr-4.2.0.tar.xz
	//	    mv mpfr-4.2.0 mpfr
	//	    tar -xf ../gmp-6.2.1.tar.xz
	//	    mv gmp-6.2.1 gmp
	//	    tar -xf ../mpc-1.3.1.tar.gz
	//	    mv  mpc-1.3.1 mpc
	//
	//	    case $(uname -m) in
	//	        x86_64)
	//	            sed -e '/m64=/s/lib64/lib/'  -i.orig gcc/config/i386/t-linux64
	//	            ;;
	//	    esac
	//
	//	    mkdir -p build
	//	    cd build
	//	    ../configure --target=$LFS_TGT --prefix=$LFS/tools --with-glibc-version=2.37 --with-sysroot=$LFS --with-newlib --without-headers --enable-default-pie --enable-default-ssp --disable-nls --disable-shared --disable-multilib --disable-threads --disable-libatomic --disable-libgomp --disable-libquadmath --disable-libssp --disable-libvtv --disable-libstdcxx --enable-languages=c,c++
	//	    make -j4
	//	    make install
	//	    cd ..
	//	    cat gcc/limitx.h gcc/glimits.h gcc/limity.h > `dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/install-tools/include/limits.h
}
