PORTSDIR	= $(HOME)/ports
DISTFILES	= $(PORTSDIR)/distfiles

FETCH		= /usr/bin/curl
OPENSSL		= /usr/bin/openssl
SHASUM		= $(OPENSSL) dgst -sha256
TAR		= /usr/bin/tar

SUFFIX		= tar.gz
TARBALL		= $(NAME)-$(VERSION).$(SUFFIX)
DISTFILE	= $(DISTFILES)/$(TARBALL)
DISTINFO	= distinfo

WRKDIR		= work
FILESDIR	= files
PATCHDIR	= patches
SRCDIR		= $(WRKDIR)/$(NAME)-$(VERSION)

EXTRACTED	= $(WRKDIR)/.extracted
PATCHED		= $(WRKDIR)/.patched
CONFIGURED	= $(WRKDIR)/.configured
BUILT		= $(WRKDIR)/.built

all: build

fetch: $(DISTFILE)
$(DISTFILE):
	@install -d -m 0755 $(DISTFILES)
	$(FETCH) $(DOWNLOAD)/$(TARBALL) > $(DISTFILE)

makesum: $(DISTINFO)
$(DISTINFO): $(DISTFILE)
	@( cd $(DISTFILES) && $(SHASUM) $(TARBALL) ) > $(DISTINFO)

checksum: $(DISTFILE) $(DISTINFO)
	@( cd $(DISTFILES) && $(SHASUM) $(TARBALL) ) | diff -q - $(DISTINFO)

extract: checksum $(EXTRACTED)
$(EXTRACTED): $(DISTFILE)
	@install -d $(WRKDIR)
	$(TAR) -C $(WRKDIR) -xzf $(DISTFILE)
	@date > $(EXTRACTED)

patch: extract $(PATCHED)
$(PATCHED):
	test -d $(FILESDIR) && install $(FILESDIR)/* $(SRCDIR)
	#test -d $(PATCHDIR) && install $(FILESDIR)/* $(SRCDIR)
	@date > $(PATCHED)

configure: patch $(CONFIGURED)
$(CONFIGURED): $(PATCHED)
	( cd $(SRCDIR) && ./configure )
	@date > $(CONFIGURED)

build: configure $(BUILT)
$(BUILT): $(CONFIGURED)
	( cd $(SRCDIR) && make )
	@date > $(BUILT)

install: build
	( cd $(SRCDIR) && make install )

uninstall:
	( cd $(SRCDIR) && make uninstall )

clean:
	@rm -rf $(WRKDIR) *~

distclean: clean
	@rm -f $(DISTFILE)
