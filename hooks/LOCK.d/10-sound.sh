case "${state}" in
	LOCK)
		/usr/bin/amixer -q set Master mute
		;;
	UNBLANK)
		/usr/bin/amixer -q set Master unmute
		;;
	*)
		echo "Don't know how to handle ${state}."
		;;
esac
