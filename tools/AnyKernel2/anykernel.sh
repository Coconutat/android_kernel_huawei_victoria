# AnyKernel2 Ramdisk Mod Script
# osm0sis @ XDA

## AnyKernel setup
# begin properties
properties() {
kernel.string="Huawei P10 EMUI 8 Lite Kernel"
do.devicecheck=0
do.modules=0
do.cleanup=1
do.cleanuponabort=1
device.name1=
device.name2=
} # end properties

## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;

ui_print "     ____  ____  ____  __________   ";
ui_print "    Huawei P10 EMUI 8 Lite Kernel   ";
ui_print "			by Coconutat			  ";

# shell variables
block=/dev/block/bootdevice/by-name/kernel;
ramdisk_compression=auto;

# reset for kernel patching
reset_ak;
mv /tmp/anykernel/kernel-Image.gz /tmp/anykernel/Image.gz;


## AnyKernel kernel install

ui_print "Huawei P10 EMUI 8 Lite is being infused";

split_boot;

flash_boot;

## end install
