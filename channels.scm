;; https://forum.systemcrafters.net/t/how-can-i-improve-performance/1725/7
;; currently, this uses codeberg instead of savannah, which is much faster
(list
  (channel (name 'guix)
           (url "https://git.guix.gnu.org/guix.git")
           (branch "master")
           (introduction
             (make-channel-introduction
               "9edb3f66fd807b096b48283debdcddccfea34bad"
               (openpgp-fingerprint
                 "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA")))))
