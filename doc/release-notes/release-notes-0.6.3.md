PALLY1 version 0.6.3 is now available for download at:
  http://sourceforge.net/projects/PALLY1/files/PALLY1/PALLY1-0.6.3/

This is a bug-fix release, with no new features.

Please report bugs using the issue tracker at github:
  https://github.com/PALLY1/PALLY1/issues

CHANGE SUMMARY

Fixed a serious denial-of-service attack that could cause the
PALLY1 process to become unresponsive. Thanks to Sergio Lerner
for finding and responsibly reporting the problem. (CVE-2012-3789)

Optimized the process of checking transaction signatures, to
speed up processing of new block messages and make propagating
blocks across the network faster.

Fixed an obscure bug that could cause the PALLY1 process to get
stuck on an invalid block-chain, if the invalid chain was
hundreds of blocks long.

PALLY1-Qt no longer automatically selects the first address
in the address book (Issue #1384).

Fixed minimize-to-dock behavior of PALLY1-Qt on the Mac.

Added a block checkpoint at block 185,333 to speed up initial
blockchain download.
