function __bitrofi_show_items
  set -l KB_SYNC "Alt+s"
  set -l KB_TOTP "Alt+t"
  set -l KB_USER "Alt+n"

  rbw unlock
  rbw unlocked
  if test $status -eq 0
    rbw list | rofi -modi "password" -show password -dmenu -p "Password" -i -no-custom \
      -mesg "<b>$KB_SYNC</b>: sync | <b>$KB_TOTP</b>: totp | <b>$KB_USER</b>: username" \
      -kb-custom-1 $KB_SYNC \
      -kb-custom-2 $KB_TOTP \
      -kb-custom-3 $KB_USER
  else
    __bitrofi_show_error "Can't unlock Bitwarden vault"
  end
end
