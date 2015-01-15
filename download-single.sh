#!/bin/bash

APPID=$1

METAURL="http://store.ovi.com/content/"$APPID
DOWNURL="http://store.ovi.com/content/"$APPID"/Download"

wget -p -nd -P "$APPID" "$METAURL" "$DOWNURL" --warc-file="$APPID"

if ( grep --silent MIDlet $APPID"/Download" ) ; then
	TYPE="JAD"
	JAR_URL=$( cat $APPID"/Download" | grep -i MIDlet-Jar-URL | cut -d\  -f2 )
	wget -p -nd -P "$APPID" "$JAR_URL" --warc-file="$APPID"_jar
elif ( file $APPID"/Download" | fgrep -i "symbian" ) ; then
	TYPE="SIS"
else
	TYPE="BIN"
fi
