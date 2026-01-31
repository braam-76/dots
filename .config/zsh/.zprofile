#!/usr/bin/env bash

export PATH="$HOME/.cargo/bin:$PATH"

if uwsm check may-start && uwsm select; then
    exec uwsm start sway-uwsm.desktop
fi

# Created by `pipx` on 2026-01-06 11:53:29
export PATH="$PATH:/home/braam/.local/bin"
