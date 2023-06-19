#!/bin/bash

#set dvorak and ru layouts
setxkbmap -layout dvorak,ru

#clear current option
setxkbmap -option

#set option to toggle layouts on both shifts
setxkbmap -option 'grp:shifts_toggle'