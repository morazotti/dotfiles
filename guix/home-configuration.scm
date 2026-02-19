(use-modules (gnu home)
             (gnu home services)
             (gnu services)
             (guix gexp)
             (gnu packages shells)
             (gnu packages emacs)
             (gnu packages version-control)
             (gnu packages password-utils))

(home-environment
 (packages
  (list zsh
        emacs
        git
        pass))
 (services
  (list
   ;; Gerencie seu ~/.zshrc a partir da sua dotfile (em vez de gerar um zshrc).
   (service home-files-service-type
            `((".zshrc" ,(local-file "/home/nicolas/repos/dotfiles/zsh/.zshrc"))
              (".config/emacs/init.el" ,(local-file "/home/nicolas/repos/emacs/init.el"))
              (".config/emacs/async-init.el" ,(local-file "/home/nicolas/repos/emacs/async-init.el"))
              (".config/emacs/straight/versions"
               ,(local-file "/home/nicolas/repos/emacs/straight/versions" #:recursive? #t))
              (".config/emacs/early-init.el"
               ,(local-file "/home/nicolas/repos/emacs/early-init.el")))))))
