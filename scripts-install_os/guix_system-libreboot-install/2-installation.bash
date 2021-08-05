#!/run/current-system/profile/bin/bash
echo "enter x where /dev/sdx is a target"
read x
herd start cow-store /mnt
mkdir /mnt/etc
luksUUID=$(cryptsetup luksUUID /dev/sd${x}1)
cat << EOF > /mnt/etc/config.scm
(use-modules
  (gnu)
  (gnu system nss)
  (rnrs lists))

(use-service-modules
  authentication
  desktop
  pm
  xorg)

(use-package-modules
  bash
  certs
  lxqt
  shells)

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
          (uuid "${luksUUID}"))
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
      (list nss-certs)
      %base-packages))
  (services
    (append
      (list
        (extra-special-file "/usr/bin/env"
          (file-append coreutils "/bin/env"))
        (set-xorg-configuration
          (xorg-configuration
            (keyboard-layout keyboard-layout)))
        (service tlp-service-type
          (tlp-configuration
            (cpu-scaling-governor-on-ac (list "ondemand"))
            (cpu-scaling-governor-on-bat (list "powersave"))))
        (service lxqt-desktop-service-type))
              %desktop-services))
  (name-service-switch %mdns-host-lookup-nss)) ;; Allow resolution of '.local' host names with mDNS.
EOF

guix system init /mnt/etc/config.scm /mnt
