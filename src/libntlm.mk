# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libntlm
$(PKG)_WEBSITE  := https://www.nongnu.org/libntlm/
$(PKG)_DESCR    := Libntlm
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.4
$(PKG)_CHECKSUM := 8415d75e31d3135dc7062787eaf4119b984d50f86f0d004b964cdc18a3182589
$(PKG)_SUBDIR   := libntlm-$($(PKG)_VERSION)
$(PKG)_FILE     := libntlm-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://www.nongnu.org/libntlm/releases/$($(PKG)_FILE)
$(PKG)_DEPS     := cc

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://git.savannah.gnu.org/gitweb/?p=libntlm.git;a=tags' | \
    grep '<a class="list subject"' | \
    $(SED) -n 's,.*<a[^>]*>\([0-9][^<]*\)<.*,\1,p' | \
    head -1
endef

define $(PKG)_BUILD
    cd '$(1)' && ./configure \
        $(MXE_CONFIGURE_OPTS)
    $(MAKE) -C '$(1)' -j 1 install bin_PROGRAMS= sbin_PROGRAMS= noinst_PROGRAMS=
endef
