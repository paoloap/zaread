# zaread

#### A (very) lightweight ebook and Office document reader

## What is zaread?
zaread is a simple bash scripts that uses [zathura pdf/epub viewer](https://pwmt.org/projects/zathura/) to act as a lightweight document/ebook readonly reader

### How does it work?
If you are opening a pdf or an epub it doesn't do anything more than launch zathura. If the file is a Microsoft Office document, or a "mobi" ebook, or another supported file, zaread converts it into pdf and put it into a cache. The next time you'll open the file it will take it from the cache. If you edit a document after having opened it with zaread, the next time you will open it zaread will recognize that the file differs from cache and a new converted file will be created.

### What file formats does zaread support?
- PDF
- EPUB
- OOXML documents (docx, xlsx, pptx)
- Old MS Office documents (doc, xls, ppt)
- MOBI
- CSV
- Markdown (md)
- RTF
- Typst (typ)

### Some optional dependencies are quite big...
- Unfortunately, we can't have libreoffice command line tools without getting the whole suite, and I don't know any other options to convert Office files on Linux...
- Same about MOBI files (you need calibre to have a converter)
- md2pdf has some python dependencies but it's (imho) a better option than first implementation with pandoc, which requested the whole texlive suite to work

### Will it work without any of the optional dependencies?
Yes, but it will not work with its target file formats

### Can I bind it with another PDF viewer?
Yes, you just have to change $reader variable with your chosen viewer

### Why you did you develop zaread?
At work I often need to open doc, docx, ppt, pptx files in read only mode. I hate libreoffice interface with all those buttons (useless if I just need to view file content), and I hate presentation mode, because it forces fullscreen mode and I want the freedom to open Office files in a "normal" window, considering that I have a tiling wm.

## Getting started
- Install zathura (and libreoffice, calibre and md2pdf as optional dependencies)
- git clone https://github.com/paoloap/zaread
- cd zathura
- sudo make install

Aaaand that's it.

## Changelog
#### 2022-04-22
- Rewriting code I forgot to put some double quote, so if paths had spaces in them it didn't work. Thanks to hassty!

#### 2022-04-21
- If you alternately opened two files with the same name (and potentially different extension) zaread didn't recognize they were separate files and kept re-converting them. Now the cache file names directly contain their checksum and their size in their name, so that every unique file has its converted version.
- General code refactoring

#### 2022-04-20

_I'm so sorry guys, I just found out today that this script in the past few years has been adopted by many people and even ended up into AUR repos.  If someone wants to contribute, i.e. the ones that opened the issues and the pull requests, he's obviously welcome! Btw just merged all the pull requests_

- Now you can just clone the repo and do "sudo make install"
- Added .md files support (depends on pandoc)
- Now the cache directory is ~/.cache/zaread
- Fixed ebook conversion

Thanks to iulandita, TheOPtimal, millenito and mvrozanti for their help!



## Next goals
- [ ] Cache auto-cleaning policies
- [ ] Add more extensions support (xlsb, xlsm...)

Feel free to use and edit :)
