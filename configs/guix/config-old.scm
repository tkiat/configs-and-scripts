;; This is an operating system configuration template
;; for a "desktop" setup with GNOME and Xfce where the
;; root partition is encrypted with LUKS.

(use-modules (gnu) (gnu system nss) (srfi srfi-1)
             (tkiat packages tkiat-dmenu)
             (tkiat packages tkiat-dwm)
             (tkiat packages tkiat-slock)
             (tkiat packages tkiat-st))
(use-service-modules base desktop networking sound ssh xorg)
(use-package-modules certs gnome linux shells suckless)

(operating-system
  (host-name "tkiat")
  (timezone "Asia/Bangkok")
  (locale "en_US.utf8")
  (kernel linux-libre)
  (keyboard-layout (keyboard-layout "us" "altgr-intl"))

  (bootloader (bootloader-configuration
                (bootloader grub-bootloader)
                (target "/dev/sda")
                (keyboard-layout keyboard-layout)))

  (file-systems (append
                 (list (file-system
                         (device (file-system-label "root"))
                         (mount-point "/")
                         (type "ext4")))
                 %base-file-systems))

  (firmware %base-firmware)

  (swap-devices '("/dev/sda2"))

  (users (cons (user-account
                (name "tkiat")
                (comment "tkiat")
                (group "users")
                ;;; (shell #~(string-append #$zsh "/bin/zsh"))
                (supplementary-groups '("wheel" "netdev"
                                        "audio" "video"))
                (shell #~(string-append #$zsh "/bin/zsh")))
               %base-user-accounts))

  (packages (append (list
         tkiat-dwm tkiat-dmenu tkiat-st tkiat-slock
                     nss-certs ;; for HTTPS access
                     gvfs) ;; for user mounts
                    %base-packages))

  (services (append (list (service wpa-supplicant-service-type
           (wpa-supplicant-configuration
             (interface "wlp0s29f7u2")
             (config-file "/etc/wpa_supplicant.conf")))
                          (service openssh-service-type
                                   (openssh-configuration
                                     (x11-forwarding? #t)
                                     (permit-root-login 'without-password)))
                          ;;; (service static-networking-service-type)
                          (service dhcp-client-service-type))
        (remove (lambda (service)
            (member (service-kind service) (list network-manager-service-type
                  pulseaudio-service-type
                  wpa-supplicant-service-type)))
                %desktop-services)))
;;;             (modify-services %desktop-services
;;;               (network-manager-service-type config =>
;;;                 (network-manager-configuration
;;;                   (dns "dnsmasq")))))))
;;;         (modify-services %desktop-services
;;;           (alsa-service-type config =>
;;;             (alsa-configuration
;;;               (pulseaudio? #f)))))))
  ;;(remove (lambda (x) (member x '(a b c))) '(a b d))
  (name-service-switch %mdns-host-lookup-nss)) ;; Allow resolution of '.local' host names with mDNS.
