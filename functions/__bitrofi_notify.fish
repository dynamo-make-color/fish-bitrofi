function __bitrofi_notify -a message -d 'Show message on notification'
  gdbus call --session \
    --dest=org.freedesktop.Notifications \
    --object-path=/org/freedesktop/Notifications \
    --method=org.freedesktop.Notifications.Notify \
    "" 0 "" "Bitrofi" "$message" \
    '[]' '{"urgency": <1>}' 5000
end
