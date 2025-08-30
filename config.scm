;; TODO
;; * why does incus installation fail?
;; * use a manifest file (don't put packages in here bc system-wide)
;; * set up zfs with RAID
;; * system service for incus for autostart?
;; * system setup script that can be run with essentially one command from installer, pull this repo and copy over the files, run guix system reconfigure with this
;; * 

;; This is an operating system configuration generated
;; by the graphical installer.
;;
;; Once installation is complete, you can learn and modify
;; this file to tweak the system configuration, and pass it
;; to the 'guix system reconfigure' command to effect your
;; changes.


;; Indicate which modules to import to access the variables
;; used in this configuration.
(use-modules
  (gnu)
  (gnu packages package-management)
  (guix channels))
(use-service-modules cups desktop networking ssh xorg)

;; FIXME
;; https://guix.gnu.org/manual/devel/en/html_node/Channels.html
;; may need to switch to devel to make this work :(
(define my-channels
  (list
    (channel (name 'guix)
             (url "https://git.guix.gnu.org/guix.git")
             (branch "master")
             (introduction
               (make-channel-introduction
                 "9edb3f66fd807b096b48283debdcddccfea34bad"
                 (openpgp-fingerprint
                   "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA"))))))

(operating-system
  (locale "en_US.utf8")
  (timezone "America/Los_Angeles")
  (keyboard-layout (keyboard-layout "us"))
  (host-name "minerva")

  ;; The list of user accounts ('root' is implicit).
  (users (cons* (user-account
                  (name "snale")
                  (comment "snale")
                  (group "users")
                  (home-directory "/home/snale")
                  (supplementary-groups '("wheel" "netdev" "audio" "video")))
                %base-user-accounts))

  ;; Packages installed system-wide.  Users can also install packages
  ;; under their own account: use 'guix search KEYWORD' to search
  ;; for packages and 'guix install PACKAGE' to install a package.
  (packages %base-packages)

  ;; Below is the list of system services.  To search for available
  ;; services, run 'guix system search KEYWORD' in a terminal.
  (services
   (append (list

                 ;; To configure OpenSSH, pass an 'openssh-configuration'
                 ;; record as a second argument to 'service' below.
                 (service openssh-service-type)
                 (service network-manager-service-type)
                 (service wpa-supplicant-service-type)
                 (service ntp-service-type))

           ;; This is the default list of services we
           ;; are appending to.
           (modify-services %base-services
             (guix-service-type
                config => (guix-configuration
                            (inherit config)
                            (channels my-channels)
                            (guix (guix-for-channels my-channels)))))))
  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets (list "/boot/efi"))
                (keyboard-layout keyboard-layout)))

  (mapped-devices (list (mapped-device
                          (source (uuid
                                   "e8b74ef9-d65f-4752-aa69-09839d3f0665"))
                          (target "cryptroot")
                          (type luks-device-mapping))))

  ;; The list of file systems that get "mounted".  The unique
  ;; file system identifiers there ("UUIDs") can be obtained
  ;; by running 'blkid' in a terminal.
  (file-systems (cons* (file-system
                         (mount-point "/boot/efi")
                         (device (uuid "F85C-2945"
                                       'fat32))
                         (type "vfat"))
                       (file-system
                         (mount-point "/")
                         (device "/dev/mapper/cryptroot")
                         (type "ext4")
                         (dependencies mapped-devices)) %base-file-systems)))
