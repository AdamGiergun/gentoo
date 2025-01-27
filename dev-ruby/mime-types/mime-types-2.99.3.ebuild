# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ruby30: not compatible
USE_RUBY="ruby26 ruby27"

RUBY_FAKEGEM_EXTRADOC="History.rdoc History-Types.rdoc README.rdoc"

RUBY_FAKEGEM_EXTRAINSTALL="data"

inherit ruby-fakegem

DESCRIPTION="Provides a mailcap-like MIME Content-Type lookup for Ruby"
HOMEPAGE="https://github.com/mime-types/ruby-mime-types"

LICENSE="MIT Artistic GPL-2"
SLOT="2"
KEYWORDS="~alpha amd64 arm arm64 ~hppa ppc ppc64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

ruby_add_bdepend "test? ( dev-ruby/minitest:5 )"

all_ruby_prepare() {
	# Avoid unneeded dependency on minitest-focus.
	sed -i -e '/focus/ s:^:#:' \
		-e 's:fivemat/::' \
		test/minitest_helper.rb || die
}

each_ruby_test() {
	${RUBY} -Ilib:test:. -e 'Dir["test/test_*.rb"].each{|f| require f}' || die
}
