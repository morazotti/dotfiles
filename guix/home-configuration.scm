(use-modules (gnu home)
             (gnu home services)
             (gnu services)
             (guix gexp)
             (gnu packages base)
             (gnu packages cmake)
             (gnu packages compression)
             (gnu packages cups)
             (gnu packages emacs)
             (gnu packages flatpak)
             (gnu packages fonts)
             (gnu packages ghostscript)
             (gnu packages gnupg)
             (gnu packages golang)
             (gnu packages image)
             (gnu packages inkscape)
             (gnu packages ledger)
             (gnu packages libreoffice)
             (gnu packages mpd)
             (gnu packages music)
             (gnu packages password-utils)
             (gnu packages pdf)
             (gnu packages photo)
             (gnu packages pkg-config)
             (gnu packages rsync)
             (gnu packages search)
             (gnu packages shells)
             (gnu packages shellutils)
             (gnu packages syncthing)
             (gnu packages tex)
             (gnu packages tmux)
             (gnu packages torrent)
             (gnu packages version-control)
             (gnu packages video)
             (gnu packages wget)
             (gnu packages wine)
             (gnu packages xdisorg)
             (gnu packages xorg))

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
  (list calibre
	cmake
	deluge
	dosfstools
	emacs
	exfat-utils
	fd
	feh
	ffmpeg
	font-awesome
	;; Flatpak CLI so you can manage user remotes/apps
	flatpak
	fzf
	ghostscript
	gimp
	git
	gnupg
	go
	imagemagick
	inkscape
	ledger
	libreoffice
	lxappearance
	man-db
	man-pages
	mpc
	mpd
	ncmpcpp
	ntfs-3g
	pass
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
	zsh

	;; TODO: Arch package mappings not added because Guix name uncertain:
	;; - mise (may correspond to 'mise' or 'rtx')
	;; - powerline (could be 'powerline' or split into fonts/tools)
	))
 (services
  (list
   (service home-files-service-type
            `(;; Shell
              (".zshrc" ,(local-file "/home/nicolas/repos/dotfiles/zsh/.zshrc"))))

   (service home-xdg-configuration-files-service-type
            emacs-xdg-entries)

   ;; Flatpak: you still need to add Flathub once (see notes below), then install Bottles.
   ;; We don't manage the Flatpak installs declaratively here because Flatpak keeps its own
   ;; state in ~/.local/share/flatpak.
   )))

;; How to install Ankama Launcher (Flatpak, unofficial packaging):
;; Repo: https://github.com/azert9/ankama-launcher-flatpak
;;
;; 1) Ensure Flathub exists (needed for the runtime/SDK used by flatpak-builder):
;;    flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
;;
;; 2) Install flatpak-builder (Guix package name is typically "flatpak-builder").
;;    If you want it managed by Guix Home, add it to (packages ...) above.
;;
;; 3) Build + install locally (per-user):
;;    git clone https://github.com/azert9/ankama-launcher-flatpak
;;    cd ankama-launcher-flatpak
;;    ./build.sh
;;    flatpak-builder --force-clean --user --install ./build fr.jloc.AnkamaLauncher.yml
;;
;; Notes: when the launcher asks for install location, keep the default, otherwise the
;; game might be installed somewhere not persisted by Flatpak.
