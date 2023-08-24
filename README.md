# To-CHD
Convert game disk images to CHD (Compressed Hunks of Data) using CHDMAN.exe forked from MAME. This lossless compression format will effectively reduce file sizes anywhere from 15% to 95% and will still work in most gaming emulators.


### Some of the benefits of the CHD format:
- Lossless compression (disk images can be easily reverted to their original format)
- Better compression than .bin/.cue, .gdi, .iso, etc.
- Streamable format, doesn't need to decompressed, just play
- Only a single file for every disc image
- Supports Redbook audio in FLAC compression
- It’s becoming the de-facto standard for most disc based emulators and Libertro cores


## How to Use:
Simply drop any .cue, .gdi, or .iso file onto the .bat file.
<br>-OR-<br>
Run/Open the .bat file to auto-search (the current directory) for .cue, .gdi, or .iso files. Make sure to update the variable `CHDMAN_PATH` first.

<br>

chdman.exe source found at: [MAME GitHub](https://github.com/mamedev/mame)
