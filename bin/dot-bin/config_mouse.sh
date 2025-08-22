#!/usr/bin/sh
# Disable Touchpad in labtops
#xinput set-prop 'ETPS/2 Elantech Touchpad' 'Device Enabled' 0

# Reduce mouse speed
xinput list | sed -ne 's/^[^ ][^V].*id=\([0-9]*\).*/\1/p' | while read id; do
  case $(xinput list-props $id) in
  *"libinput Middle Emulation Enabled Default"*)
    xinput set-prop $id "libinput Accel Speed" -1
    xinput --set-prop $id 'Coordinate Transformation Matrix' 1 0 0, 0 1 0, 0 0 1
    echo "id=$id"
    # etc.
    ;;
  esac
done
xinput disable "Synaptics TM3053-004"
