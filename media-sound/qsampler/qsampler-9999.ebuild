# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils qt4 cvs

DESCRIPTION="QSampler is a graphical frontend to the LinuxSampler engine."
HOMEPAGE="http://qsampler.sourceforge.net"

ECVS_SERVER="qsampler.cvs.sourceforge.net:/cvsroot/qsampler"
ECVS_MODULE="${PN}"
S="${WORKDIR}/${PN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""
RDEPEND="$(qt4_min_version 4.1)
	>=media-libs/liblscp-0.5.5
	>=media-libs/libgig-0.3.3
	>=media-sound/linuxsampler-0.4
	media-libs/alsa-lib"

DEPEND="${RDEPEND}"

src_compile() {
	make -f Makefile.cvs
	econf || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "einstall failed"
	dodoc AUTHORS ChangeLog README
}
