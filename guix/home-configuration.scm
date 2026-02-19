(use-modules (gnu home)
             (gnu home services)
             (gnu services)
             (guix gexp)
             (gnu packages shells)
             (gnu packages emacs)
             (gnu packages version-control)
             (gnu packages password-utils)
             ;; Extra user packages from user_configuration.json
             (gnu packages cmake)
             (gnu packages cups)
             (gnu packages gnupg)
             (gnu packages golang)
             (gnu packages image)
             (gnu packages inkscape)
             (gnu packages libreoffice)
             (gnu packages mpd)
             (gnu packages music)
             (gnu packages pdf)
             (gnu packages photo)
             (gnu packages pkg-config)
             (gnu packages rsync)
             (gnu packages shellutils)
             (gnu packages syncthing)
             (gnu packages tex)
             (gnu packages torrent)
             (gnu packages tmux)
             (gnu packages version-control)
             (gnu packages video)
             (gnu packages wget)
             (gnu packages wine)
             (gnu packages xdisorg)
             (gnu packages xorg)
             (gnu packages compression)
             (gnu packages search)
             (gnu packages base)
             (gnu packages ledger)
             (gnu packages fonts)
             (gnu packages ghostscript))

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
        pass
        ;; user_configuration.json (subset; avoid duplicating system-side KDE stack)
        calibre
        cmake
        deluge
        dosfstools
        exfat-utils
        fd
        feh
        ffmpeg
        gimp
        gnupg
        go
        inkscape
        imagemagick
        libreoffice
        lxappearance
        man-db
        man-pages
        mpd
        mpc
        ncmpcpp
        ntfs-3g
        ripgrep
        rsync
        starship
        stow
        syncthing
        texlive
        tmux
        uv
        wget
        which
        wine64
        yt-dlp
        ;; From Arch JSON (known Guix names)
        fzf
        ghostscript
        ledger
        font-awesome

        ;; TODO: Arch package mappings not added because Guix name uncertain:
        ;; - mise (may correspond to 'mise' or 'rtx')
        ;; - powerline (could be 'powerline' or split into fonts/tools)
        ))
 (services
  (list
   (service home-files-service-type
            `((".zshrc" ,(local-file "/home/nicolas/repos/dotfiles/zsh/.zshrc"))))
   (service home-xdg-configuration-files-service-type
            emacs-xdg-entries))))
