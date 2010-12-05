#!/usr/bin/env bash

# Installer script for bspasvus
# Auteur : Romain RICHARD <romain.richard.it.engineer@gmail.com>

PREFIX="/usr/local/bin"
EXEC="bspasvus"

CP="/bin/cp"
RM="/bin/rm -f"
CHMOD="/bin/chmod"

check_root()
{
	if [ `whoami` != 'root' ]; then
		echo "*** You must be root."
		exit 1
	fi
}

update()
{
	cd /tmp
	echo "bspasvus: downloading latest version from github..."
	wget https://www.github.com/romainrichard/playlist-betaseries/tarball/master --no-check-certificate -O playlist-betaseries.tgz 2> /dev/null
	tar xzf playlist-betaseries.tgz
	cd romainrichard-playlist-betaseries-*
}

clean()
{
	echo "bspasvus: cleaning up."
	rm -r /tmp/romainrichard-playlist-betaseries-* /tmp/playlist-betaseries.tgz
	echo "bspasvus: done."
}

install()
{
	check_root
	update
	echo "Copying $EXEC to $PREFIX/$EXEC"
	$CP $EXEC $PREFIX/
	$CHMOD 755 $PREFIX/$EXEC
	clean
}

uninstall()
{
	check_root
	echo "Removing $PREFIX/$EXEC"
	$RM $PREFIX/$EXEC
}

case "$1" in
	install)
		install
		;;
	uninstall)
		uninstall
		;;
	*)
		echo "Usage: $0 {install|uninstall|help}"
esac

exit 0
