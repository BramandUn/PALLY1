Sample init scripts and service configuration for PALLY1d
==========================================================

Sample scripts and configuration files for systemd, Upstart and OpenRC
can be found in the contrib/init folder.

    contrib/init/PALLY1d.service:    systemd service unit configuration
    contrib/init/PALLY1d.openrc:     OpenRC compatible SysV style init script
    contrib/init/PALLY1d.openrcconf: OpenRC conf.d file
    contrib/init/PALLY1d.conf:       Upstart service configuration file
    contrib/init/PALLY1d.init:       CentOS compatible SysV style init script

Service User
---------------------------------

All three Linux startup configurations assume the existence of a "PALLY1" user
and group.  They must be created before attempting to use these scripts.
The OS X configuration assumes PALLY1d will be set up for the current user.

Configuration
---------------------------------

At a bare minimum, PALLY1d requires that the rpcpassword setting be set
when running as a daemon.  If the configuration file does not exist or this
setting is not set, PALLY1d will shutdown promptly after startup.

This password does not have to be remembered or typed as it is mostly used
as a fixed token that PALLY1d and client programs read from the configuration
file, however it is recommended that a strong and secure password be used
as this password is security critical to securing the wallet should the
wallet be enabled.

If PALLY1d is run with the "-server" flag (set by default), and no rpcpassword is set,
it will use a special cookie file for authentication. The cookie is generated with random
content when the daemon starts, and deleted when it exits. Read access to this file
controls who can access it through RPC.

By default the cookie is stored in the data directory, but it's location can be overridden
with the option '-rpccookiefile'.

This allows for running PALLY1d without having to do any manual configuration.

`conf`, `pid`, and `wallet` accept relative paths which are interpreted as
relative to the data directory. `wallet` *only* supports relative paths.

For an example configuration file that describes the configuration settings,
see `contrib/debian/examples/PALLY1.conf`.

Paths
---------------------------------

### Linux

All three configurations assume several paths that might need to be adjusted.

Binary:              `/usr/bin/PALLY1d`  
Configuration file:  `/etc/PALLY1/PALLY1.conf`  
Data directory:      `/var/lib/PALLY1d`  
PID file:            `/var/run/PALLY1d/PALLY1d.pid` (OpenRC and Upstart) or `/var/lib/PALLY1d/PALLY1d.pid` (systemd)  
Lock file:           `/var/lock/subsys/PALLY1d` (CentOS)  

The configuration file, PID directory (if applicable) and data directory
should all be owned by the PALLY1 user and group.  It is advised for security
reasons to make the configuration file and data directory only readable by the
PALLY1 user and group.  Access to PALLY1-cli and other PALLY1d rpc clients
can then be controlled by group membership.

### Mac OS X

Binary:              `/usr/local/bin/PALLY1d`  
Configuration file:  `~/Library/Application Support/PALLY1/PALLY1.conf`  
Data directory:      `~/Library/Application Support/PALLY1`  
Lock file:           `~/Library/Application Support/PALLY1/.lock`  

Installing Service Configuration
-----------------------------------

### systemd

Installing this .service file consists of just copying it to
/usr/lib/systemd/system directory, followed by the command
`systemctl daemon-reload` in order to update running systemd configuration.

To test, run `systemctl start PALLY1d` and to enable for system startup run
`systemctl enable PALLY1d`

NOTE: When installing for systemd in Debian/Ubuntu the .service file needs to be copied to the /lib/systemd/system directory instead.

### OpenRC

Rename PALLY1d.openrc to PALLY1d and drop it in /etc/init.d.  Double
check ownership and permissions and make it executable.  Test it with
`/etc/init.d/PALLY1d start` and configure it to run on startup with
`rc-update add PALLY1d`

### Upstart (for Debian/Ubuntu based distributions)

Upstart is the default init system for Debian/Ubuntu versions older than 15.04. If you are using version 15.04 or newer and haven't manually configured upstart you should follow the systemd instructions instead.

Drop PALLY1d.conf in /etc/init.  Test by running `service PALLY1d start`
it will automatically start on reboot.

NOTE: This script is incompatible with CentOS 5 and Amazon Linux 2014 as they
use old versions of Upstart and do not supply the start-stop-daemon utility.

### CentOS

Copy PALLY1d.init to /etc/init.d/PALLY1d. Test by running `service PALLY1d start`.

Using this script, you can adjust the path and flags to the PALLY1d program by
setting the BITCOIND and FLAGS environment variables in the file
/etc/sysconfig/PALLY1d. You can also use the DAEMONOPTS environment variable here.

### Mac OS X

Copy org.PALLY1.PALLY1d.plist into ~/Library/LaunchAgents. Load the launch agent by
running `launchctl load ~/Library/LaunchAgents/org.PALLY1.PALLY1d.plist`.

This Launch Agent will cause PALLY1d to start whenever the user logs in.

NOTE: This approach is intended for those wanting to run PALLY1d as the current user.
You will need to modify org.PALLY1.PALLY1d.plist if you intend to use it as a
Launch Daemon with a dedicated PALLY1 user.

Auto-respawn
-----------------------------------

Auto respawning is currently only configured for Upstart and systemd.
Reasonable defaults have been chosen but YMMV.
