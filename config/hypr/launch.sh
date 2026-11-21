#!/bin/bash

# Démarrer le daemon gnome-keyring
eval "$(gnome-keyring-daemon --start)"
export SSH_AUTH_SOCK
