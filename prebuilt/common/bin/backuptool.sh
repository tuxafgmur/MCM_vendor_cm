#!/sbin/sh
# Backup and restore addon /system files
# Based upon CM backuptool.sh
# Tuxafgmur - Dhollmen

export C=/tmp/backupdir
export S=/system
cp -f /tmp/install/bin/backuptool.functions /tmp

preserve_addon_d() {
    mkdir -p /tmp/addon.d/
    cp -a /system/addon.d/* /tmp/addon.d/
    chown 0.0 /tmp/addon.d/*.sh
    chmod 755 /tmp/addon.d/*.sh
}

restore_addon_d() {
    for script in /tmp/addon.d/*; do
	case $script in
	    *"50-rom.sh") 	;;
	    *"54-initd.sh") 	;;
	    *"58-lcdcpi.sh") 	;;
	    *)	cp -a $script /system/addon.d/ 	;;
	esac
    done
    rm -rf /tmp/addon.d/
}

run_stage() {
    for script in $(find /tmp/addon.d/ -name '*.sh' | sort -n); do
	$script $1
    done
}

case "$1" in
    backup)
	if [ ! -d /tmp/tester ]; then
	    mkdir -p /tmp/tester
	    mount /dev/block/platform/omap/omap_hsmmc.1/by-name/DATAFS /tmp/tester
	    [ -d /tmp/tester/app ] || rm -f /system/addon.d/*
	    umount /tmp/tester
	fi
	mkdir -p $C
	preserve_addon_d
	run_stage pre-backup
	run_stage backup
	run_stage post-backup
	;;
    restore)
	run_stage pre-restore
	run_stage restore
	run_stage post-restore
	restore_addon_d
	rm -rf $C
	sync
	;;
    *)
	echo "Usage: $0 {backup|restore}"
	exit 1
esac
