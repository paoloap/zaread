# zaread

#### A lightweight document reader

## What is zaread?

zaread is a simple POSIX shell script that uses [zathura](https://pwmt.org/projects/zathura/) as a lightweight, read-only document viewer. PDFs, EPUBs, and DJVUs open directly in zathura. Everything else gets converted to PDF, cached in `~/.cache/zaread/`, and opened from there. If the source file changes, zaread detects the difference and re-converts automatically.

### What file formats does zaread support?
- PDF, DJVU, EPUB (opened directly via zathura)
- OOXML documents (docx, xlsx, pptx, and macro-enabled variants like xlsm, docm, pptm)
- Old MS Office documents (doc, xls, ppt)
- OpenDocument formats (odt, ods, odp)
- Other Office formats (xlsb, ppsx, dotx)
- MOBI
- CSV, RTF
- Markdown (md)
- Typst (typ)

### What about the optional dependencies?

Only zathura is required. Everything else is optional -- zaread checks at runtime and will tell you if a converter is missing.

- **LibreOffice** (`soffice`) -- for Office documents, CSV, and RTF. Unfortunately there's no lighter alternative for converting Office files on Linux.
- **calibre** (`ebook-convert`) -- for MOBI. Same story.
- **md2pdf** -- for Markdown. Has some Python dependencies but it's a better option than the old pandoc approach, which needed the whole texlive suite.
- **typst** -- for Typst documents.

zaread also uses `file` (for MIME detection) and `cksum` (for cache keys), both pre-installed on virtually all Unix systems.

### Can I use a different PDF viewer?

Yes. Create a config file at `~/.config/zaread/zareadrc` (or `$XDG_CONFIG_HOME/zaread/zareadrc`) and override any of the default variables:

```sh
READER="your-viewer"
READER_ARG="--mode=fullscreen"
OFFICE_CMD="your-converter"
# etc.
```

The config is sourced as shell, so anything you set there takes effect at runtime.

### Why zaread?

At work I often need to open doc, docx, ppt, pptx files in read only mode. I hate the LibreOffice interface with all those buttons (useless if I just need to view file content), and I hate presentation mode, because it forces fullscreen. I want the freedom to open Office files in a normal window with a tiling WM.

## Usage

```
zaread [-v] [-f] [-c] [-V] [-h] <file>
```

- `-v` -- verbose output (shows MIME detection, cache paths, converter used)
- `-f` -- force re-conversion, ignoring cached results
- `-c` -- clear the conversion cache (`~/.cache/zaread/`)
- `-V` -- print version and exit
- `-h` -- show usage

## Getting started

Install zathura, then:

```
git clone https://github.com/paoloap/zaread
cd zaread
DEST=$HOME/.local make install
# or
sudo make install
```

That's it. Install optional converters for whatever formats you need.

A `.desktop` file is included for file manager integration. It registers MIME type associations so file managers can open supported formats with zaread, but uses `NoDisplay=true` so it won't appear in application launchers.

### macOS

zaread works on macOS, but zathura isn't in Homebrew's main repo. You'll need the [homebrew-zathura](https://github.com/homebrew-zathura/homebrew-zathura) tap:

```
brew tap homebrew-zathura/zathura
brew install zathura zathura-pdf-poppler
```

After installing plugins, link them so zathura can find them:

```
d=$(brew --prefix zathura)/lib/zathura; mkdir -p $d
for n in cb djvu pdf-mupdf pdf-poppler ps; do
  p=$(brew --prefix zathura-$n)/lib$n.dylib
  [ -f "$p" ] && ln -s "$p" "$d"
done
```

Then install zaread the usual way (`git clone` + `make install` as above). The `.desktop` file won't do anything on macOS, but the script itself works fine.

## Tips

### Following links between documents

If you have markdown files that link to each other, you can set up zathura to follow those links through zaread. The trick is a wrapper script that catches zathura's link errors and redirects them back through zaread.

Save this as e.g. `~/.local/bin/linkzathura.sh`:

```sh
#!/bin/sh
zathura "$1" 2>&1 | awk -vd="$(pwd)" -vc="$HOME/.cache/zaread" -F'<<|>>' \
  'NF > 0 && !/^error/ { gsub(c, d, $2); print $2; system("") }' | \
  xargs -r -n 1 zaread
```

Then in your `zareadrc`:

```sh
READER="linkzathura.sh"
```

Now opening `A.md` with zaread and clicking a link to `B.md` will open it in a new zaread instance. Requires `zathura-pdf-poppler`.

_Contributed by [Eloitor](https://github.com/Eloitor) in [#30](https://github.com/paoloap/zaread/issues/30)._

### Spreadsheet pagination

When converting spreadsheets (xlsx, ods, csv) to PDF, LibreOffice uses the file's own page layout -- usually A4, portrait. Large spreadsheets will get split across multiple pages and may crop columns. This is a LibreOffice limitation, not something zaread can control.

If you own the file, the best workaround is to set the page layout in the spreadsheet itself (landscape, larger paper size, or "fit all columns to one page" under print settings) before opening it with zaread.

## Changelog

#### 2026-03-19
- Version flag (`-V`)
- `READER_ARG` config variable for passing flags to the reader
- Atomic writes: converters now write to temp files and rename on success, preventing corrupt cache entries on interrupt
- LibreOffice instance isolation: concurrent conversions no longer conflict with running LibreOffice
- Fixed `text/markdown` MIME detection on systems with newer shared-mime-info
- Replaced fragile `sed` cache key generation with pure POSIX shell expansion
- Fixed MOBI files with `application/x-mobipocket-ebook` MIME type not needing `.mobi` extension
- Typst conversion uses the standard converter flow instead of a special case

-- iuliandita

#### 2026-03-18
- Security and POSIX fixes, verbose output behind `-v` flag
- Conversion error handling, cache cleanup (`-c` flag)
- Added macro-enabled Office formats (xlsm, xlsb, docm, pptm, ppsx, dotx)
- Makefile and CI improvements

-- iuliandita

#### 2022-04-22
- Fixed quoting for paths with spaces (thanks hassty)

#### 2022-04-21
- Cache filenames now include checksum and byte count, so files with the same name but different content get separate cached versions
- General code refactoring

#### 2022-04-20

_I just found out today that this script has been adopted by many people and even ended up in AUR repos. If someone wants to contribute, you're obviously welcome! Just merged all the pull requests._

- Install via `make install`
- Added Markdown support
- Cache directory moved to `~/.cache/zaread`
- Fixed ebook conversion

Thanks to iuliandita, TheOPtimal, millenito and mvrozanti!

---

Feel free to use and edit :)
