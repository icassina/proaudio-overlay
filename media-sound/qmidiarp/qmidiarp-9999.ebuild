# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

AUTOTOOLS_IN_SOURCE_BUILD="1"
AUTOTOOLS_AUTORECONF="1"
inherit autotools-utils git-2

DESCRIPTION="An arpeggiator, sequencer and MIDI LFO for ALSA and JACK"
HOMEPAGE="http://qmidiarp.sourceforge.net/"
SRC_URI=""
EGIT_REPO_URI="git://${PN}.git.sourceforge.net/gitroot/${PN}/${PN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="doc"

RDEPEND=">=dev-qt/qtcore-4.2:4
	>=dev-qt/qtgui-4.2:4
	>=media-sound/jack-audio-connection-kit-0.103.0
	>=media-libs/alsa-lib-0.9.0"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( app-doc/doxygen )"

src_configure() {
	local myeconfargs=(
		$(use_enable doc doxygen-doc)
	)
	autotools-utils_src_configure
}

src_compile() {
	autotools-utils_src_compile
	use doc && emake doxygen-doc
}

src_install() {
	use doc && HTML_DOCS=( doxygen-doc/html/ )
	autotools-utils_src_install
}
