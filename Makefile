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

.PHONY: all pre-install install install-bin install-doc install-data install-bash-comp install-checks uninstall reinstall

all:

pre-install:
	sed -e "s,TEMPLATE_FILENAME *= *CURRENT_DIR *+ *'/../templates/default.dot',TEMPLATE_FILENAME = '$(yaumldir)/template.dot'," <bin/$(program) >bin/$(program).tmp

install: install-checks pre-install install-data install-doc install-bin

install-bin:
	$(INSTALL_BIN) bin/$(program).tmp $(bindir)/$(program)
	rm bin/$(program).tmp

install-doc: ./doc/$(program).1
	$(info Installing documentation...)
	$(INSTALL_DATA) doc/$(program).1 $(docdir)/$(program).1
	gzip -f $(docdir)/$(program).1

install-data: templates/default.dot
	$(info Installing yauml...)
	mkdir -p $(yaumldir)/templates
	$(INSTALL_DATA) $(wildcard templates/*) $(yaumldir)/templates
	cp $(yaumldir)/templates/default.dot $(yaumldir)/template.dot

install-bash-comp: bin/$(program)_completion
	$(info Installing bash completion script...)
	@if [ ! -d $(bash_completion_dir) ]; then \
		echo "Cannot install bash completion script. "\
			 "See bash_completion_dir variable in Makefile..." >&2 ; exit 1 ;\
	 fi
	$(INSTALL_DATA) bin/$(program)_completion $(bash_completion_dir)/$(program)

install-checks:
	@if [ -d $(yaumldir) ]; then \
		echo "$(yaumldir) already exists. use 'make reinstall'" >&2 ; \
		exit 1 ; \
	 fi

uninstall:
	$(info Uninstalling yauml...)
	rm -rf $(bindir)/$(program) $(yaumldir) $(docdir)/$(program).1.gz $(bash_completion_dir)/$(program)

reinstall: uninstall install
