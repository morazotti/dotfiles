(use-modules (gnu home)
             (gnu home services)
             (gnu services)
             (guix gexp)
             (gnu packages shells)
             (gnu packages emacs)
             (gnu packages version-control)
             (gnu packages password-utils))

(define emacs-repo "/home/nicolas/repos/dotfiles/emacs")

(define emacs-items
  ;; (tipo . nome-relativo)
  ;; tipo: 'file ou 'dir
  '((file . "init.el")
    (file . "early-init.el")
    (file . "async-init.el")
    (file . "abbrev_defs")
    (file . "bookmarks")
    (file . "emacs-custom.el")
    (dir  . "macros")
    (dir  . "snippets")
    (dir  . "modules")))

(define emacs-xdg-entries
  (map (lambda (it)
         (let ((kind (car it))
               (path (cdr it)))
           (list (string-append "emacs/" path)
                 (if (eq? kind 'dir)
                     (local-file (string-append emacs-repo "/" path) #:recursive? #t)
                     (local-file (string-append emacs-repo "/" path))))))
       emacs-items))


(home-environment
 (packages
  (list zsh
        emacs
        git
        pass))
 (services
  (list
   (service home-files-service-type
            `((".zshrc" ,(local-file "/home/nicolas/repos/dotfiles/zsh/.zshrc"))))
   (service home-xdg-configuration-files-service-type
         emacs-xdg-entries))))
