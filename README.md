gimp-file-scale
===============

Gimp *Script Fu* script to resize an image.


# Installing

Copy to `~/.gimp-2.8/scripts`.


# Usage

Run Gimp with a batch command of "gimp-file-scale" with your file and target
resize scaling ratio:

    gimp -i -b '(gimp-file-scale "Pictures/image.jpg" 0.5)'


The resized file will be saved next to the original with a "-resized" suffix.
For example, in the above example the output file will be
"Pictures/image-resized.jpg".


This script operates on a single file. Use a Unix `find` to operate on many
files, for example:

    find Pictures -name '*.jpg' |
      xargs printf '(gimp-file-scale "%s" 0.2)\n' |
      gimp -i  -b -


# Licence

GNU General Public License, version 3
