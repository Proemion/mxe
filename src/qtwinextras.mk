# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := qtwinextras
$(PKG)_WEBSITE  := https://www.qt.io/
$(PKG)_DESCR    := Qt
$(PKG)_IGNORE   :=
$(PKG)_VERSION   = $(qtbase_VERSION)
$(PKG)_CHECKSUM := f985b8553077768bb32e67f3ec2f0c205f0be4e690a157c7d19821b7c22a67e8
$(PKG)_SUBDIR    = $(subst qtbase,qtwinextras,$(qtbase_SUBDIR))
$(PKG)_FILE      = $(subst qtbase,qtwinextras,$(qtbase_FILE))
$(PKG)_URL       = $(subst qtbase,qtwinextras,$(qtbase_URL))
$(PKG)_DEPS     := cc qtbase qtdeclarative qtmultimedia

define $(PKG)_UPDATE
    echo $(qtbase_VERSION)
endef

define $(PKG)_BUILD
    cd '$(1)' && '$(PREFIX)/$(TARGET)/qt5/bin/qmake' \
        -after \
	'LIBS_PRIVATE += -lgdi32'
    $(MAKE) -C '$(1)' -j '$(JOBS)'
    $(MAKE) -C '$(1)' -j 1 install
endef
