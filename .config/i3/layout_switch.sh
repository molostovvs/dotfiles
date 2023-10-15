#!/bin/bash

#set dvorak and ru layouts
setxkbmap -layout ru,us -variant ,dvorak 

#clear current option
setxkbmap -option

#set option to toggle layouts on both shifts
setxkbmap -option 'grp:shifts_toggle'
