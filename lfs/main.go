package main

import (
	"flag"
	"fmt"
	"io"
	"io/ioutil"
	"log"
	"net/http"
	"os"
	"os/exec"
	"path"
	"strings"
	"text/template"

	"github.com/fatih/color"
	"github.com/pelletier/go-toml/v2"
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

// build
type Build struct {
	Name    string
	Sources []string
	Task    string
}

type Root struct {
	Builds []Build
}

// lfs
type lfs struct {
	Mount  *pathobj
	Target string
}

func (l *lfs) String() string {
	return fmt.Sprintf("{mount: %v, target: %v}", l.Mount, l.Target)
}

func newlfs(path *pathobj) *lfs {
	return &lfs{Mount: path, Target: fmt.Sprintf("%s-lfs-linux-gnu", getUname())}
}

func (l *lfs) Execute(build *Build) {
    color.Yellow(build.Name)
	for i := range build.Sources {
		color.Green("Downlaod %s ...", build.Sources[i])
        // extract
	}

	t, err := template.New("build").Parse(build.Task)
	if err != nil {
		log.Fatal(err)
	}

	if err := t.Execute(os.Stdout, *l); err != nil {
		log.Fatal(err)
	}

    // chdir

    // write tmp.sh

    // execute tmp.sh

    // https://devlights.hatenablog.com/entry/2022/04/21/073000
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

	// time
}

func main() {
	log.SetFlags(0)

	var mnt = flag.String("mnt", "", "LFS mount point")
	var build_file = flag.String("toml", "", "build list")
	flag.Parse()

	// env_lfs := os.Getenv("LFS")
	if *mnt == "" {
		color.Red("usage: lfs -mnt {mnt_point} -toml {builds.toml}")
		os.Exit(1)
	}
	if *build_file == "" {
		color.Red("usage: lfs -mnt {mnt_point} -toml {builds.toml}")
		os.Exit(1)
	}
	bytes, err := ioutil.ReadFile(*build_file)
	if err != nil {
		panic(err)
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

	var v Root
	if err := toml.Unmarshal(bytes, &v); err != nil {
		log.Fatal(err)
	}
	for i := range v.Builds {
		lfs.Execute(&v.Builds[i])
	}
}
