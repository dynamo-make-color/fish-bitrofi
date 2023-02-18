function bitrofi
  set -l KB_SYNC "Alt+s"
  set -l KB_TOTP "Alt+t"
  set -l KB_USER "Alt+n"

  rbw unlock
  rbw unlocked
  if test $status -eq 0
    set -l result
    set -l timeout
    set -l item (rbw list | rofi -modi "password" -show password -dmenu -p "Password" -i \
      -mesg "<b>$KB_SYNC</b>: sync | <b>$KB_TOTP</b>: totp | <b>$KB_USER</b>: username" \
      -kb-custom-1 $KB_SYNC \
      -kb-custom-2 $KB_TOTP \
      -kb-custom-3 $KB_USER)
    switch $status
      case 0
        set result (rbw get $item)
        set timeout 0.1
      case 10
        rbw sync
        and __bitrofi_notify "Sync vault successfully"
        or __bitrofi_notify "Sync vault failed"
        return
      case 11
        set result (rbw get --field totp $item)
        set timeout 1.2
      case 12
        set result (rbw get --field user $item)
        set timeout 1.2
      case '*'
        return
    end
    __bitrofi_notify "Please remove your finger to keyboard"
    sleep $timeout
    echo "type $result" | xdotool -
  else
    __bitrofi_notify "Can't unlock Bitwarden vault"
  end
end
