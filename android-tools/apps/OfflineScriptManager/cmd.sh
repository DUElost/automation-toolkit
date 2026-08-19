# /system/bin/sh
trap "" HUP
dalvikvm -classpath /data/local/tmp/sevice.jar com.tinno.soft.test.sevice.Sevice &

