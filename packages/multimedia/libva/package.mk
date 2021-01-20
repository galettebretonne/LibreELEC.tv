# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libva"
PKG_VERSION="2.10.0"
PKG_SHA256="f04d5c829da602690f9f098a6d92065507ec9d0c957c1a6df3dea4e2de1204c5"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL"
PKG_SITE="https://01.org/linuxmedia"
PKG_URL="https://github.com/intel/libva/archive/${PKG_VERSION}.tar.gz"
PKG_LONGDESC="Libva is an implementation for VA-API (VIdeo Acceleration API)."
PKG_TOOLCHAIN="meson"

if [ "${DISPLAYSERVER}" = "x11" ]; then
  PKG_DEPENDS_TARGET="toolchain libX11 libXext libXfixes libdrm"
  DISPLAYSERVER_LIBVA="-Dwith_x11=yes -Dwith_glx=no -Dwith_wayland=no"
elif [ "${DISPLAYSERVER}" = "weston" ]; then
  DISPLAYSERVER_LIBVA="-Dwith_x11=no -Dwith_glx=no -Dwith_wayland=yes"
  PKG_DEPENDS_TARGET="toolchain libdrm wayland"
else
  PKG_DEPENDS_TARGET="toolchain libdrm"
  DISPLAYSERVER_LIBVA="-Dwith_x11=no -Dwith_glx=no -Dwith_wayland=no"
fi

PKG_MESON_OPTS_TARGET="-Ddisable_drm=false \
                       -Denable_docs=false \
                       -Denable_va_messaging=true \
                       ${DISPLAYSERVER_LIBVA}"
