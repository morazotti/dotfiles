#!/bin/bash

dev=`xinput list | grep "Elan Touchpad" | sed "s/.*id=\([0-9]\+\).*/\1/g"`
prop1=`xinput list-props $dev | grep "Natural Scrolling Enabled ("| sed 's/[a-zA-Z():]//g' | awk {'print $1'}`
xinput set-prop $dev $prop1 1
prop2=`xinput list-props $dev | grep "Tapping Enabled ("| sed 's/[a-zA-Z():]//g' | awk {'print $1'}`
xinput set-prop $dev $prop2 1
