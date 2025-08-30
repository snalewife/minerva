# Honor per-interactive-shell startup file
if [ -f ~/.bashrc ]; then . ~/.bashrc; fi

# https://www.reddit.com/r/GUIX/comments/rcgiur/puzzled_over_unknown_package_message/
# even though https://guix.gnu.org/manual/en/html_node/Getting-Started.html
# says we shouldn't need to do this on guix system, on my fresh install bash
# was set up to use the system guix by default (with both system and profile
# guix on the $PATH, latter first) ¯\_(ツ)_/¯
GUIX_PROFILE="$HOME/.config/guix/current"
. "$GUIX_PROFILE/etc/profile"
