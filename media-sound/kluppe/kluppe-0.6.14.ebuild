# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit exteutils

RESTRICT="mirror"
DESCRIPTION="live looping sequencer"
HOMEPAGE="http://kluppe.klingt.org"
SRC_URI="http://kluppe.klingt.org/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=media-sound/jack-audio-connection-kit-0.90
		>=x11-libs/gtk+-2.6
		dev-libs/libxml2
		>=media-libs/liblo-0.23
		virtual/libusb
		>=media-libs/libsndfile-1.0.11"
RDEPEND="${DEPEND}"

src_prepare() {
	esed_check -i -e "s@\(^CFLAGS\ *\=\ *-pthread\)\ *-O3@\1 ${CFLAGS}@g" \
		Makefile
	esed_check -i -s 's:/local::g' "Makefile"
}

src_install() {
	dobin "src/frontend/${PN}/${PN}"
	doicon "src/frontend/${PN}/${PN}.png"
	make_desktop_entry "${PN}" "Live Looping Sequencer" "${PN}" "AudioVideo;Audio;Sequencer"
	newdoc CHANGES.log ChangeLog
	newdoc README.txt README
	dodoc TODO
}
