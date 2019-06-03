PKG             := mesa
$(PKG)_VERSION  := 19.0.5
$(PKG)_CHECKSUM := 6aecb7f67c136768692fb3c33a54196186c6c4fcafab7973516a355e1a54f831
$(PKG)_SUBDIR   := mesa-$($(PKG)_VERSION)
$(PKG)_FILE     := mesa-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := ftp://ftp.freedesktop.org/pub/mesa/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc

$(PKG)_TARGETS       := $(BUILD) $(MXE_TARGETS)

MACHINE_ARCHITECTURE := x86

ifeq ($(BITS), 64) 
	MACHINE_ARCHITECTURE := $(MACHINE_ARCHITECTURE)_64
endif

define $(PKG)_BUILD
    cd '$(1)' && \
    MINGW_PREFIX='$(TARGET)-' scons platform=windows toolchain=crossmingw machine='$(MACHINE_ARCHITECTURE)' verbose=1 build=release libgl-gdi
    $(INSTALL) -m 755 '$(1)/build/windows-'$(MACHINE_ARCHITECTURE)'/gallium/targets/libgl-gdi/opengl32.dll' '$(PREFIX)/$(TARGET)/bin/'
    mv '$(PREFIX)/$(TARGET)/bin/opengl32.dll'  '$(PREFIX)/$(TARGET)/bin/opengl32sw.dll'
endef
