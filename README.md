# zaread
A (very) lightweight MS Office files reader

This simple bash script needs libreoffice installed and has zathura pdf reader as optional dependence

At work I often need to open doc, docx, ppt, pptx files in read only mode. I hate libreoffice interface with all those buttons (useless if I just need to view file content), and I hate presentation mode, because it forces fullscreen mode and I want the freedom to open Office files in a "normal" window, considering that I have a tiling wm.

So... I created this trivial script that can be used as default PDF/DOC/DOCX/ODF/PPT/PPTX/MD/etc reader. It just:
- converts the argument file to pdf using libreoffice embedded converter (soffice --converto-to);
- open it with zathura (a very very VERY lightweight PDF reader) or if it's not installed with user's favourite app.

Note: If you don't have zathura installed and you want to adopt another PDF reader (which I don't recommend, nothing IMO fits this script better than zathura), please the first time you use the script execute it from terminal, so that you can select your favourite one; otherwise you can just open the script with a text editor and set it as $reader.

## Usage
1. Clone the repository and `cd` into it
2. Run `chmod +x zaread` to make it executable as a script
3. Run `ln -sv $(pwd)/zaread /usr/bin` to make script executable from anywhere (optional)
4. Run <code>zaread **file**</code> replace **file** with any PDF/DOC/DOCX/ODF/PPT/PPTX/MD file to open it using zathura or any reader that was set as `$reader` in the script file

Feel free to use and edit :)
