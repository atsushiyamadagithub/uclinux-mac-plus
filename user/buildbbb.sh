#!/bin/bash

set -e

CWD="$(pwd)"
UCLINUX_DIR="$(pwd)/../uClinux"
CONT_UCLINUX_DIR="/linux"
CROSS="m68k-elf-"
CFLAGS="-m68000 -Os -g -fomit-frame-pointer -Dlinux -D__linux__ -Dunix -D__uClinux__ -DEMBED -D_POSIX_VERSION -I${CONT_UCLINUX_DIR}/lib/libc/include -I${CONT_UCLINUX_DIR}/lib/libm -I${CONT_UCLINUX_DIR}/lib/libcrypt_old -I${CONT_UCLINUX_DIR} -fno-builtin -msep-data -I${CONT_UCLINUX_DIR}/linux-2.0.x/include"
#CFLAGS="-m68000 -Os -g -fomit-frame-pointer -Dlinux -D__linux__ -Dunix -D__uClinux__ -DEMBED -D_POSIX_VERSION -I${CONT_UCLINUX_DIR}/lib/libc/include -I${CONT_UCLINUX_DIR}/lib/libm -I${CONT_UCLINUX_DIR}/lib/libcrypt_old -I${CONT_UCLINUX_DIR} -fno-builtin -I${CONT_UCLINUX_DIR}/linux-2.0.x/include"
LDFLAGS="${CFLAGS} -Wl,-elf2flt -Wl,-move-rodata -L${CONT_UCLINUX_DIR}/lib/libc/. -L${CONT_UCLINUX_DIR}/lib/libc/lib -L${CONT_UCLINUX_DIR}/lib/libm -L${CONT_UCLINUX_DIR}/lib/libnet -L${CONT_UCLINUX_DIR}/lib/libdes -L${CONT_UCLINUX_DIR}/lib/libaes -L${CONT_UCLINUX_DIR}/lib/libpcap -L${CONT_UCLINUX_DIR}/lib/libssl -L${CONT_UCLINUX_DIR}/lib/libcrypt_old -L${CONT_UCLINUX_DIR}/prop/libsnapgear++ -L${CONT_UCLINUX_DIR}/prop/libsnapgear -L${CONT_UCLINUX_DIR}/lib/zlib"
LDLIBS="-lc -lcrypt_old"

ROOTDIR="$(pwd)/rootdir"

makeFileIn() {
    makefile=${1}
    dir=${2}
    target=${3}
    before=${4:-true}
    wd=$(pwd)

    echo " ==== making ${target} in ${dir} with ${makefile}..."
    cd "${dir}"
    docker run \
        --user $(id -u):$(id -u) \
        --mount type=bind,source="$(pwd)",target=/build \
        --mount type=bind,source="${UCLINUX_DIR}",target="${CONT_UCLINUX_DIR}" \
        --workdir /build \
        -t uclinux-buildenv:0.1 \
        sh -c "$before ; make -f \"${makefile}\" CROSS=\"${CROSS}\" CC=\"${CROSS}gcc\" LD=\"${CROSS}ld\" CFLAGS=\"${CFLAGS}\" LDFLAGS=\"${LDFLAGS}\" LDLIBS=\"${LDLIBS}\" ${target}"
    cd "${wd}"
}

makeIn() {
    makeFileIn Makefile $@
}

makeIn ../bootloader boot_block.bin
