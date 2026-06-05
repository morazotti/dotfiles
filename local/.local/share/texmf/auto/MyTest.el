;; -*- lexical-binding: t; -*-

(TeX-add-style-hook
 "MyTest"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("article" "landscape" "a4paper" "11pt" "twoside" "twocolumn")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("fontenc" "T1") ("inputenc" "utf8") ("babel" "brazil") ("geometry" "") ("microtype" "") ("graphicx" "") ("hyperref" "")))
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art11"
    "geometry"
    "microtype"
    "graphicx"
    "hyperref"))
 :latex)

