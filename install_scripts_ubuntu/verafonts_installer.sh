#!/bin/bash

if [ $USER != "root" ]; then
   $0 $USER
   exit 0
fi

sudo apt install ttf-bitstream-vera -y

#section Below is for turning of AA in the fonts system wide. On desktop based systems, this is unwanted behavior.
#However, if libgdiplus is out of date and cannot turn of AA from the code, uncomment the instructions below

#we will create a new config file (or overwrite an existing one if needed) that turns of anti-aliasing for the fonts we just installed
# outdir=/etc/fonts/conf.d
# outconf=$outdir/18-bitstream_vera_fonts-no_aa.conf

# mkdir -p $outdir;

# if [ ! -d $outdir ]; then
    # echo "Could not create (part of) path " $outdir;
    # echo "The output of the mkdir command should give an error indicating the problem. Please forward this error to Opticon";
    # exit 0;
# fi

#section This creates the config file
# echo "<?xml version=\"1.0\"?>
# <!DOCTYPE fontconfig SYSTEM \"fonts.dtd\">
# <fontconfig>" > $outconf; #this creates the outconf file
#now we create a list of fonts for which we want to turn off anti-aliasing
# declare -a fontarr=("Bitstream Vera Sans" "Bitstream Vera Serif" "Bitstream Vera Sans Mono");
# for i in "${fontarr[@]}"
# do
    # echo "  <match target=\"font\">
    # <test qual=\"any\" name=\"family\" compare=\"eq\"><string>$i</string></test>
    # <edit name=\"antialias\" mode=\"assign\" binding=\"same\"><bool>false</bool></edit>
  # </match>" >> $outconf; #this appends to the outconf file
# done
# echo "</fontconfig>" >> $outconf; #this appends to the outconf file, making a correct .conf file
#endsection
#endsection

exit 0
$SHELL
