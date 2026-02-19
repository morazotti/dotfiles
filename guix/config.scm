(use-modules (gnu)
             (gnu system nss)
             (gnu system keyboard)
             (gnu packages shells)
             (nongnu packages linux)
             (nongnu system linux-initrd)
             (gnu services networking)
             (gnu services ssh)
             (gnu services docker)
             (gnu services syncthing)
             ;; Desktop/audio/bluetooth/printing (Arch JSON: KDE + pulseaudio + bluedevil + cups)
             (gnu services desktop)
             (gnu services xorg)
             (gnu services sound)
             (gnu services cups)
             (gnu services bluetooth)
             (gnu packages kde)
             (gnu packages cups)
             ;; For system packages mirrored from Arch JSON
             (gnu packages syncthing))

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

  ;; Pacotes “de sistema” para refletir user_configuration.json (KDE/SDDM/CUPS/Bluetooth).
  ;; O grosso dos apps fica melhor no Guix Home.
  (packages
   (append
    (list sddm
          plasma
          bluedevil
          cups
          ;; Arch JSON includes syncthing and docker; services are enabled below,
          ;; but keeping the packages available system-wide is often convenient.
          syncthing)
    %base-packages))

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
                    (permit-root-login #t)))

          ;; Desktop stack (KDE + SDDM).
          (service sddm-service-type)
          (service plasma-desktop-service-type)

          ;; Audio (Arch JSON: pulseaudio)
          (service pulseaudio-service-type)

          ;; Printing
          (service cups-service-type)

          ;; Bluetooth (needed for bluedevil to be useful)
          (service bluetooth-service-type))
    %base-services)))

;; Opcional (e redundante aqui): estes macros são para conveniência quando
;; você usa (service ...) sem importar explicitamente os módulos acima.
;; Como você já importou (gnu services ssh/docker/syncthing), pode remover.
;; (use-service-modules (ssh))
;; (use-package-modules (admin) (emacs) (version-control) (certs) (shells))
