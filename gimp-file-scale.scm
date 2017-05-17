; gimp-file-scale
; Copyright (C) 2017 Nathan Jones
;
; This program is free software: you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation, either version 3 of the License, or
; (at your option) any later version.
;
; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.
;
; You should have received a copy of the GNU General Public License
; along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (gimp-file-scale file ratio)
  (let* (
    (not-last (lambda (l) (reverse (cdr (reverse l)))))
    ; gimp-file-load chokes on file paths starting with "./"
    ; so in that case we strip the leading 2 characters
    (normalized-file (if (string=? "./"  (substring file 0 2))
      (substring file 2)
      file))
    (file-parts (strbreakup normalized-file "."))
    (file-extn (car (last file-parts)))
    (file-base (apply string-append (not-last file-parts)))
    (new-file (string-append file-base "-resized." file-extn))
    (image (car (gimp-file-load RUN-NONINTERACTIVE normalized-file normalized-file)))
    (width (inexact->exact (ceiling (* ratio (car (gimp-image-width image))))))
    (height (inexact->exact (ceiling (* ratio (car (gimp-image-height image))))))
    (drawable (car (gimp-image-get-active-layer image))))
    (gimp-image-scale-full image width height INTERPOLATION-CUBIC)
    (gimp-file-save RUN-NONINTERACTIVE image drawable new-file new-file)
    (gimp-image-delete image)))
