#! /bin/sh
#
# Script to update configuration files from the VRT site:
#     http://www.snort.org/vrt/snort-conf-configurations

for directory in $(find * -maxdepth 1 -type d -name etc); do
    version=$(dirname ${directory} | tr -d .)

    if [ "$1" ]; then
	if [ "$1" != "$(dirname ${directory})" ]; then
	    continue
	fi
    fi

    for filename in snort.conf \
	classification.config \
	reference.config \
	gen-msg.map
    do
	echo "Updating ${directory}/${filename}."
	url="http://labs.snort.org/snort/${version}/${filename}"
	if ! curl --progress-bar --fail -o ${directory}/${filename} ${url}
	then
	    echo "ERROR: Failed to get ${url}."
	    exit 1
	fi
    done
done
