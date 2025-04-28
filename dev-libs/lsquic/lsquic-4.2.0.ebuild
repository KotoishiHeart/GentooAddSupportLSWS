# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="LiteSpeed QUIC (LSQUIC) Library"
HOMEPAGE="https://github.com/litespeedtech/lsquic/"
SRC_URI="
	https://github.com/litespeedtech/lsquic/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="
	dev-lang/go
	dev-libs/ls-qpack:=
	dev-libs/ls-hpack:=
	>=dev-libs/openssl-3.5.0
"
RDEPEND="
	${DEPEND}
	sys-libs/zlib
"

PATCHES=(
	"${FILESDIR}"/${PN}-disable-build-deps-libs.patch
	"${FILESDIR}"/${PN}-disable-override-flags.patch
	"${FILESDIR}"/${PN}-disable-boring-override-flags.patch
	"${FILESDIR}"/${PN}-c23.patch
)

src_configure() {
	local mycmakeargs=(
		-DLSQUIC_SHARED_LIB=ON
		-DLSQUIC_TESTS=$(usex test)
	)
	cmake_src_configure
}
