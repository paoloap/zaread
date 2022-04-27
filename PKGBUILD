# Maintainer: Jacob Gogichaishvili <jggsecondary@gmail.com>

_pkgname="zaread"
pkgname="$_pkgname-git"
pkgdesc="A document and ebook reader"
arch=("any")
url="https://github.com/paoloap/zaread"
license=("GPL")
depends=("zathura","md2pdf")
optdepends=('libreoffice: to view office files',
            'calibre: to view MOBI files')
makedepends=("git")
provides=("${_pkgname}")
conflicts=("${_pkgname}")
source=("${_pkgname}::git+${url}.git")
pkgver=r47.9239db1
pkgrel=1
sha256sums=('SKIP')
pkgver() {
	cd "$srcdir/${pkgname%-git}"
	printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
}
package() {
  cd "$srcdir/$_pkgname"
  mkdir -p "$pkgdir/${PREFIX:-usr}/bin"
  install -Dm755 "$srcdir/$_pkgname/$_pkgname" "$pkgdir/${PREFIX:-usr}/bin/"
  install -Dm644 LICENSE -t "$pkgdir/usr/share/licenses/$_pkgname/"
  install -Dm644 README.md -t "$pkgdir/usr/share/doc/$_pkgname/"
}
