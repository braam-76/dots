#!/usr/bin/env bash

if uwsm check may-start && uwsm select; then
    exec uwsm start sway-uwsm.desktop
fi
