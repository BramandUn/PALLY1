
Debian
====================
This directory contains files used to package PALLY1d/PALLY1-qt
for Debian-based Linux systems. If you compile PALLY1d/PALLY1-qt yourself, there are some useful files here.

## PALLY1: URI support ##


PALLY1-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install PALLY1-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your PALLY1-qt binary to `/usr/bin`
and the `../../share/pixmaps/PALLY1128.png` to `/usr/share/pixmaps`

PALLY1-qt.protocol (KDE)

