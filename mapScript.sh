#!/bin/bash

if [ "$#" -ne 5 ]; then
    echo "Illegal number of parameters. This script takes 5 arguments -- left bottom right top name"
    exit
fi

wget -O "$5".osm "http://overpass-api.de/api/map?bbox=${1},${2},${3},${4}"
# wget -O "$5".osm "http://api.openstreetmap.org/api/0.6/map?bbox=${1},${2},${3},${4}"
cp "$5".osm osmarender/stylesheets/data.osm
cd osmarender
xsltproc xslt/osmarender.xsl stylesheets/Ecomaps_features_version1.xml > "$5"_version1.svg
xsltproc xslt/osmarender.xsl stylesheets/Ecomaps_features_version2.xml > "$5"_version2.svg
xsltproc xslt/osmarender.xsl stylesheets/Ecomaps_features_version3.xml > "$5"_version3.svg
xsltproc xslt/osmarender.xsl stylesheets/Ecomaps_features_version4.xml > "$5"_version4.svg
cd ..
mkdir "$5"
mv osmarender/"$5"_version1.svg "$5"/
mv osmarender/"$5"_version2.svg "$5"/
mv osmarender/"$5"_version3.svg "$5"/
mv osmarender/"$5"_version4.svg "$5"/
mv "$5".osm "$5"/
# mkdir ~/Dropbox\ \(MIT\)/EcoMaps/Existing\ Design\ Files/"$5"
cp -r "$5" ~/Dropbox\ \(MIT\)/NewlyGeneratedMaps/"$5"