(use-modules
  (gnu)
  (gnu system nss)
  (gnu services mcron)
  (rnrs lists)
  (tkiat packages tkiat-dmenu)
  (tkiat packages tkiat-dwm)
  (tkiat packages tkiat-slock)
  (tkiat packages tkiat-st))

(use-service-modules
  authentication
  desktop
  pm
  xorg)

(use-package-modules
  bash
  certs
  lxqt
  shells
  suckless)

(define newsboat-update-job
  #~(job "0 * * * *"
         "su - tkiat -c 'newsboat -x reload'"))

(operating-system
  (host-name "tkiat")
  (timezone "Asia/Bangkok")
  (locale "en_US.utf8")
  (keyboard-layout
    (keyboard-layout "us"
                     "altgr-intl")) ;; The "altgr-intl" variant provides dead keys for accented characters.
  (bootloader
    (bootloader-configuration
      (bootloader
        (bootloader
          (inherit grub-bootloader)
          (installer #~(const #t))))
      (keyboard-layout keyboard-layout)))
  (mapped-devices
    (list
      (mapped-device
        (source
          (uuid "a4b43746-3129-4a01-bafe-bec87961f1aa"))
          (target "root-encrypted")
          (type luks-device-mapping))))
  (file-systems
    (append
      (list
        (file-system
          (device
            (file-system-label "guix"))
          (mount-point "/")
          (type "btrfs")
          (dependencies mapped-devices)))
        %base-file-systems))
  (swap-devices '("/swapfile"))
  (users
    (append
      (list
        (user-account
          (name "tkiat")
          (comment "Theerawat Kiatdarakun")
          (group "users")
          (shell (file-append bash "/bin/bash"))
          (supplementary-groups '("wheel" "netdev" "audio" "video" "lp" "cdrom" "tape" "kvm"))))
      %base-user-accounts))
  (packages
    (append
      (list nss-certs
            tkiat-dwm tkiat-dmenu tkiat-st tkiat-slock)
      %base-packages))
  (services
    (append
      (list
        ;;; add /usr/bin/env to system
        (extra-special-file "/usr/bin/env"
          (file-append coreutils "/bin/env"))
        (set-xorg-configuration
          (xorg-configuration
            (keyboard-layout keyboard-layout)))
        (simple-service 'my-cron-jobs
                        mcron-service-type
                        (list newsboat-update-job))
        (service tlp-service-type
          (tlp-configuration
            (cpu-scaling-governor-on-ac (list "ondemand"))
            (cpu-scaling-governor-on-bat (list "powersave"))))
        (service lxqt-desktop-service-type))
              %desktop-services))
  (name-service-switch %mdns-host-lookup-nss)) ;; Allow resolution of '.local' host names with mDNS.
