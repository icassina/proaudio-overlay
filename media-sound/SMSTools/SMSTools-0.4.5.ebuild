# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Analyzes, transforms and synthesizes back a given sound using the SMS model."
HOMEPAGE="http://clam.iua.upf.edu/index.html"

SRC_URI="http://clam.iua.upf.edu/download/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""
RESTRICT="nomirror"

RDEPEND="dev-util/scons
	media-libs/libclam
    	=x11-libs/qt-3*"
	
RDEPEND="${DEPEND}
	media-gfx/imagemagick"

src_compile() {
	# required for scons to "see" intermediate install location
	mkdir -p ${D}/usr
	addpredict /usr/share/clam/sconstools
		    
	cd ${S}
	scons clam_prefix=/usr DESTDIR="${D}/usr" install_prefix="${D}/usr" || die "Build failed"
	convert -resize 48x48 -colors 24 resources/SMSTools-icon.png clam-smstools.xpm || die "Icon convert failed"
}

src_install() {
	cd ${S}
	dodir /usr
	addpredict /usr/share/clam/sconstools
	
	scons install || die "scons install failed"
	
	dodoc CHANGES COPYING README || die "doc install failed"
	insinto /usr/share/pixmaps
	doins clam-smstools.xpm || die "icon install failed"
}
