#--------------------------------------------------------
# File: Makefile    Author(s): Alexandre Blondin Massé
#                              Simon Désaulniers
# Date: 2013-09-05
#--------------------------------------------------------

# INSTALL CONFIGURATION -------------------------------
program             = yauml
bindir              = /usr/bin
datadir             = /usr/share
yaumldir            = $(datadir)/$(program)
docdir              = /usr/share/man/man1
bash_completion_dir = /usr/share/bash-completion/completions
# -----------------------------------------------------

# Install variables -------------
INSTALL      = install
INSTALL_BIN  = $(INSTALL) -m 755
INSTALL_DATA = $(INSTALL) -m 644
# -------------------------------

all:

pre-install:
	sed -i -e "s,TEMPLATE_FILENAME *= *CURRENT_DIR *+ *'/../templates/default.dot',TEMPLATE_FILENAME = '$(yaumldir)/template.dot'," bin/$(program)

install: pre-install install-data install-doc install-bin

install-bin:
	$(INSTALL_BIN) bin/$(program) $(bindir)/$(program)

install-doc: ./doc/$(program).1
	$(info Installing documentation...)
	$(INSTALL_DATA) doc/$(program).1 $(docdir)/$(program).1
	gzip -f $(docdir)/$(program).1

install-data: templates/default.dot 
	@test ! -d $(yaumldir) || echo "$(yaumldir) already exists. use 'make reinstall'" >&2
	$(info Installing yauml...)
	mkdir -p $(yaumldir)/templates
	$(INSTALL_DATA) -t $(yaumldir)/templates $(wildcard templates/*)
	cp $(yaumldir)/templates/default.dot $(yaumldir)/template.dot
	$(info Installing bash completion script...)
	@test -d $(bash_completion_dir) || echo "Cannot install bash completion script. See bash_completion_dir variable..." >&2
	$(INSTALL_DATA) bin/$(program)_completion $(bash_completion_dir)/$(program)

uninstall:
	$(info Uninstalling yauml...)
	rm -rf $(bindir)/$(program) $(yaumldir) $(docdir)/$(program).1.gz $(bash_completion_dir)/$(program)

reinstall: uninstall install
