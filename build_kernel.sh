#!/bin/bash
#设置环境

# Special Clean For Huawei EMUI 8.0 Kernel.
if [ -d include/config ];
then
    echo "Find config,will remove it"
	rm -rf include/config
else
	echo "No Config,good."
fi


echo " "
echo "***Setting environment...***"
rm -rf out/arch/arm64/boot/Image.gz

# 交叉编译器的路径
export PATH=$PATH:/media/coconutat/Files/Downloads/Github/android_kernel_huawei_victoria/android_kernel_huawei_victoria/aarch64-linux-android-4.9/bin
export CROSS_COMPILE=aarch64-linux-android-
export GCC_COLORS=auto
export ARCH=arm64
if [ ! -d "out" ];
then
	mkdir out
fi

#输入内核版本号
printf "输入P10内核的版本号,输入完成后按下回车: "
read v
echo " "
echo "Setting EXTRAVERSION"
export EV=EXTRAVERSION=_Huawei_P10_Kernel_Lite_V$v

#构建P10部分
echo "***Building for P10 version...***"
make ARCH=arm64 O=out $EV Huawei_P10_defconfig
make ARCH=arm64 O=out $EV -j128

#打包P10版内核
if [ -f out/arch/arm64/boot/Image.gz ];
then
	echo "***Packing P10 version kernel...***"
	cp out/arch/arm64/boot/Image.gz Image.gz  
	cp out/arch/arm64/boot/Image.gz tools/AnyKernel2/Image.gz
	cd tools/AnyKernel2/
	zip -r9 Huawei_P10_EMUI8_Kernel_Lite_V"$v".zip * > /dev/null
	cd ../..
	mv tools/AnyKernel2/Huawei_P10_EMUI8_Kernel_Lite_V"$v".zip Huawei_P10_EMUI8_Kernel_Lite_V"$v".zip
	rm -rf tools/AnyKernel2/Image.gz

	echo " "
	echo "***Sucessfully built P10 version kernel...***"
	echo " "
else
	echo " "
	echo "***Failed!***"
fi