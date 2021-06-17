#!/bin/bash
set -euo pipefail
exec grub-mkconfig -o /boot/grub/grub.cfg "$@" 
