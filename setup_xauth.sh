#! /bin/sh

xauth add $(xauth -f ~vagrant/.Xauthority list|tail -1)
