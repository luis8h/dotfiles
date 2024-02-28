#!/bin/bash

for id in $(xinput list | grep "pointer" | cut -d '=' -f 2 | cut -f 1); do
    xinput --set-prop $id 'libinput Accel Profile Enabled' 0, 1;
    xinput --set-prop $id "Coordinate Transformation Matrix" 1, 0, 0, 0, 1, 0, 0, 0, 1.5
done
