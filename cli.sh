#!/bin/bash

promptyn ()
{
	if [ "$force" = "1" ]; then
		return 0
	fi
	while true; do
		read -p "▶️  $1 [y/n]: " yn
		case $yn in
			[Yy]* ) return 0;;
			[Nn]* ) return 1;;
			* ) echo "Please answer yes or no.";;
		esac
	done
}

processing ()
{
	echo "\n📃 LIST: $1\n"
	printf '%*s\n\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' ═
}

usage ()
{
	echo "\n📣 HELP\n"
	printf '%*s\n\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' ═
	echo "Commands:\n
-h --help\t\t\tOpen this help
-f --force\t\t\tDon't ask anything
-la --launchpad\t\t\tRearrange Launchpad in default order
-te --terminal\t\t\tClear Terminal history
-ca --cache\t\t\tClear computer cache
-cld --calendars\t\tClear calendars
-co --cookies\t\t\tClear cookies
-cr --crashes\t\t\tClear crashes
-do --downloads\t\tDelete all downloads in ~/Downloads
\n"
}

launchpad ()
{
	processing "Rearrang Launchpad"
	if defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock
	then
		echo "✅ Launchpad arranging done"
	else
		echo "❌ Launchpad arranging cannot ran"
	fi
}

terminal ()
{
	processing "Clear Terminal"
	if promptyn "Clear terminal?"; then
		if rm -rf ~/.bash_sessions/* && > .bash_history
		then
			echo "✅ Terminal cleared"
		else
			echo "❌ Terminal cannot be cleared"
		fi
	fi
}

removecache ()
{
	processing "Clear Computer cache"
	if promptyn "Clear cache?"; then
		if rm -rf ~/Library/Caches/*
		then
			echo "✅ Cache cleared"
		else
			echo "❌ Cache cannot be cleared"
		fi
	fi
}

clearcalendars ()
{
	processing "Clear calendars"
	echo "‼️  This process will delete your calendars. Make sure you know what are you doing!\n"
	if promptyn "Clear all calendars?"; then
		if rm -rf ~/Library/Calendars/*
		then
			echo "✅ Calendars cleared"
		else
			echo "❌ Calendars couldn't be cleared"
		fi
	fi
}

clearcookies ()
{
	processing "Clear cookies"
	if promptyn "Clear cookies?"; then
		if find ~/Library/Cookies/ -name "*.cookies" -type f -delete && find ~/Library/Cookies/ -name "*.binarycookies" -type f -delete
		then
			echo "✅ Cookies deleted"
		else
			echo "❌ Cookies couldn't be deleted"
		fi
	fi
}

clearcrashes ()
{
	processing "Clear Computer crashes"
	if promptyn "Clear computer crashes?"; then
		if rm -rf ~/Library/Application\ Support/CrashReporter/*
		then
			echo "✅ Crashes deleted"
		else
			echo "❌ Crashes couldn't be deleted"
		fi
	fi
}

deletedownloads ()
{
	processing "Delete downloads"
	if promptyn "Delete all downloads data?"; then
		if rm -rf ~/Downloads/*
		then
			echo "✅ Downloads deleted"
		else
			echo "❌ Downloads couldn't be deleted"
		fi
	fi
}

clearlogs ()
{
	processing "Clear Computer logs"
	if promptyn "Clear computer logs?"; then
		if rm -rf /private/var/log/*
		then
			echo "✅ Logs cleared"
		else
			echo "❌ Logs couldn't be cleared"
		fi
	fi
}

clearmailattach ()
{
	processing "Clear Mail attachments"
	if promptyn "Clear Mac Mail's all attachments?"; then
		if rm -rf ~/Library/Containers/com.apple.mail/Data/Library/Mail\ Downloads/*
		then
			echo "✅ Attachments cleared"
		else
			echo "❌ Attachments couldn't be cleared"
		fi
	fi
}

clearmaildata ()
{
	processing "Clear Mail data"
	if promptyn "Clear Mac Mail's data?"; then
		if find ~/Library/Mail/ -name "*-*-*-*-*" -type d -exec rm -r "{}" \;
		then
			echo "✅ Mail data cleared"
		else
			echo "❌ Mail data couldn't be cleared"
		fi
	fi
}

clearthumbs ()
{
	processing "Clear thumbnails"
	if promptyn "Clear thumbnails?"; then
		if rm -rf /private/var/folders/*
		then
			echo "✅ Thumbnails cleared"
		else
			echo "❌ Thumbnails couldn't be cleared"
		fi
	fi
}

emptytrash ()
{
	processing "Empty trash"
	if promptyn "Empty trash?"; then
		if rm -rf ~/.Trash/* ; then
			echo "✅ Trash cleaned"
		else
			echo "❌ Trash cannot be cleaned"
		fi
	fi
}

secureemptytrash ()
{
	processing "3x overwrite trash"
	if promptyn "Empty trash?"; then
		if rm -rfP ~/.Trash/* ; then
			echo "✅ Trash cleaned"
		else
			echo "❌ Trash cannot be cleaned"
		fi
	fi
}

clearulogs ()
{
	processing "Clear user logs"
	if promptyn "Clear user logs?"; then
		if rm -rf ~/Library/Logs/*
		then
			echo "✅ User logs cleared"
		else
			echo "❌ User logs couldn't be cleared"
		fi
	fi
}

backupsipx ()
{
	processing "Delete iPx backups"
	if promptyn "Delete backups from: iPhone, iPod, iPad, etc.?"; then
		if rm -rf ~/Library/Application\ Support/MobileSync/Backup/*
		then
			echo "✅ Backups from iPx devices deleted"
		else
			echo "❌ Backups from iPx devices couldn't be deleted"
		fi
	fi
}

clearsafari ()
{
	processing "Clear Safari"
	if promptyn "Clear Safari temporary files?"; then
		if rm -rf ~/Library/Safari/Databases/* && rm -rf ~/Library/Safari/LocalStorage/* && rm -rf ~/Library/Safari/Touch Icons/* && rm -f ~/Library/Safari/Downloads.plist && rm -f ~/Library/Safari/Form\ Values && rm -f ~/Library/Safari/History.db && rm -f ~/Library/Safari/History.db-lock && rm -f ~/Library/Safari/History.db-shm && rm -f ~/Library/Safari/History.db-wal && rm -f ~/Library/Safari/LastSession.plist && rm -f ~/Library/Safari/SearchDescriptions.plist && rm -f ~/Library/Safari/TopSites.plist
		then
			echo "✅ Safari temporary files cleared"
		else
			echo "❌ Safari temporary files couldn't be cleared"
		fi
	fi
}

cleardsstore ()
{
	processing "Delete .DS_Store files"
	echo "‼️  This process is heavy and can freeze your software and computer!\n"
	if promptyn "Clear .DS_Store files from whole Computer?"; then
		if find / -name ".DS_Store" -delete
		then
			echo "✅ .DS_Store files cleared"
		else
			echo "❌ .DS_Store files couldn't be cleared"
		fi
	fi
}

clearthumbsdb ()
{
	processing "Delete Thumbs.db files"
	echo "‼️  This process is heavy and can freeze your software and computer!\n"
	if promptyn "Clear Thumbs.db files from whole Computer?"; then
		if find / -name "Thumbs.db" -delete
		then
			echo "✅ Thumbs.db files cleared"
		else
			echo "❌ Thumbs.db files couldn't be cleared"
		fi
	fi
}

force=

while [ "$1" != "" ]; do
	case $1 in
		-h | --help )				usage
									exit
									;;
		-f | --force )				force=1
									;;
		-la | --launchpad )			launchpad
									;;
		-te | --terminal )			terminal
									;;
		-ca | --cache )				removecache
									;;
		-cld | --calendars )		clearcalendars
									;;
		-co | --cookies )			clearcookies
									;;
		-cr | --crashes )			clearcrashes
									;;
		-do | --downloads )			deletedownloads
									;;
		-lo | --logs )				clearlogs
									;;
		-ulo | --userlogs )			clearulogs
									;;
		-mla | --mailattach )		clearmailattach
									;;
		-mld | --maildata )			clearmaildata
									;;
		-th | --thumbs )			clearthumbs
									;;
		-sts | --strash )			secureemptytrash
									;;
		-ts | --trash )				emptytrash
									;;
		-bckipx | --backupsipx )	backupsipx
									;;
		-saf | --safari )			clearsafari
									;;
		-ds | --dsstore )			cleardsstore
									;;
		-thdb | --thumbsdb )		clearthumbsdb
									;;
		* )							usage
									exit 1
	esac
	shift
done
