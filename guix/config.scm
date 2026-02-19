(use-modules (gnu)
             (gnu system nss)
             (gnu system keyboard)
             (gnu packages shells)
             (nongnu packages linux)
             (nongnu system linux-initrd)
             (gnu services networking)
             (gnu services ssh)
             (gnu services docker)
             (gnu services syncthing))

(operating-system
  (host-name "Golgotha")
  (timezone "America/Sao_Paulo")
  (locale "en_US.utf8")

  (kernel linux)
  (initrd microcode-initrd)
  (firmware (list linux-firmware))

  (keyboard-layout (keyboard-layout "us" "colemak"))
  (bootloader (bootloader-configuration
               (bootloader grub-bootloader)
               (targets '("/dev/sda"))
               (keyboard-layout (keyboard-layout "us" "colemak"))))

  (file-systems (cons* (file-system
                         (mount-point "/")
                         (device (file-system-label "root"))
                         (type "btrfs"))
                       (file-system
                         (mount-point "/boot")
                         (device (file-system-label "boot"))
                         (type "vfat"))
                       (file-system
                         (mount-point "/home")
                         (device (file-system-label "home"))
                         (type "btrfs"))
                       %base-file-systems))

  (users (cons (user-account
                (name "nicolas")
                (comment "Nícolas André da Costa Morazotti")
                (group "users")
                (supplementary-groups '("wheel" "netdev" "audio" "video"))
                (home-directory "/home/nicolas")
                (shell (file-append zsh "/bin/zsh")))
               %base-user-accounts))

  (services
   (append
    (list (service docker-service-type)

          (service syncthing-service-type
                   (syncthing-configuration
                    (user "nicolas")
                    (group "users")
                    (home-service? #f)
                    (arguments '("--no-browser"
                                 "--gui-address=0.0.0.0:8384"))))

          (service dhcp-client-service-type)

          (service openssh-service-type
                   (openssh-configuration
                    (permit-root-login #t))))
    %base-services)))

;; Opcional (e redundante aqui): estes macros são para conveniência quando
;; você usa (service ...) sem importar explicitamente os módulos acima.
;; Como você já importou (gnu services ssh/docker/syncthing), pode remover.
;; (use-service-modules (ssh))
;; (use-package-modules (admin) (emacs) (version-control) (certs) (shells))
