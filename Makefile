#----------------------------------------------------------------------
# Make file for Nagelfar
#----------------------------------------------------------------------

VERSION = 1112

# Path to the TclKits used for creating StarPacks.
TCLKIT = /home/peter/tclkit
TCLKIT_LINUX   = $(TCLKIT)/v84/tclkit-linux-x86
TCLKIT_SOLARIS = $(TCLKIT)/v84/tclkit-solaris-sparc
TCLKIT_WIN     = $(TCLKIT)/v84/tclkit-win32.upx.exe
TCLKITSH_WIN   = $(TCLKIT)/v84/tclkitsh-win32.upx.exe
TCLKIT85_LINUX = $(TCLKIT)/v85/tclkit-linux-x86
TCLKIT85_WIN   = $(TCLKIT)/v85/tclkit-win32.upx.exe
TCLKITSH85_WIN = $(TCLKIT)/v85/tclkitsh-win32.upx.exe

# Path to the libraries used
TKDND   = /home/peter/src/packages/tkdnd/lib/tkdnd1.0
#CTEXT   = /home/peter/src/ctext
TEXTSEARCH = /home/peter/src/textsearch

# Path to the interpreter used for generating the syntax database
TCLSHDB  = ~/tcl/install/bin/wish8.5
TCLSHDB2 = ~/tcl/install/bin/wish8.4
DB2NAME  = syntaxdb84.tcl
TCLSHDB3 = ~/tcl/install/bin/wish8.6
DB3NAME  = syntaxdb86.tcl
# Path to the interpreter used for running tests
TCLSH84  = tclsh
TCLSH85  = ~/tcl/install/bin/tclsh8.5
TCLSH86  = ~/tcl/install/bin/tclsh8.6

all: base

base: nagelfar.tcl setup misctest db

#----------------------------------------------------------------
# Setup symbolic links from the VFS to the real files
#----------------------------------------------------------------

#nagelfar.vfs/lib/app-nagelfar/nagelfar.tcl:
#	cd nagelfar.vfs/lib/app-nagelfar ; ln -s ../../../nagelfar.tcl
#nagelfar.vfs/lib/app-nagelfar/syntaxdb.tcl:
#	cd nagelfar.vfs/lib/app-nagelfar ; ln -s ../../../syntaxdb.tcl
#nagelfar.vfs/lib/app-nagelfar/syntaxdb84.tcl:
#	cd nagelfar.vfs/lib/app-nagelfar ; ln -s ../../../syntaxdb84.tcl
#nagelfar.vfs/lib/app-nagelfar/doc:
#	cd nagelfar.vfs/lib/app-nagelfar ; ln -s ../../../doc
nagelfar.vfs/lib/tkdnd:
	cd nagelfar.vfs/lib ; ln -s $(TKDND) tkdnd
#nagelfar.vfs/lib/ctext:
#	cd nagelfar.vfs/lib ; ln -s $(CTEXT) ctext
nagelfar.vfs/lib/textsearch:
	cd nagelfar.vfs/lib ; ln -s $(TEXTSEARCH) textsearch

links: nagelfar.vfs/lib/tkdnd \
	nagelfar.vfs/lib/textsearch

setup: links

#----------------------------------------------------------------
# Concatening source
#----------------------------------------------------------------

CATFILES = src/prologue.tcl src/nagelfar.tcl src/gui.tcl src/dbbrowser.tcl \
	src/registry.tcl src/preferences.tcl src/startup.tcl


nagelfar.tcl: $(CATFILES)
	cat $(CATFILES) | sed "s/\\\$$Revision\\\$$/`git show-ref --hash --heads`/" > nagelfar.tcl
	@chmod 775 nagelfar.tcl

#----------------------------------------------------------------
# Testing
#----------------------------------------------------------------

spell:
	@cat doc/*.txt | ispell -d british -l | sort -u

# Create a common "header" file for all source files.
nagelfar_h.syntax: nagelfar.tcl nagelfar.syntax $(CATFILES)
	@echo Creating syntax header file...
	@./nagelfar.tcl -header nagelfar_h.syntax nagelfar.syntax $(CATFILES)

check: nagelfar.tcl nagelfar_h.syntax
	@./nagelfar.tcl -strictappend nagelfar_h.syntax $(CATFILES)

test: clean base
	@$(TCLSH85) ./tests/all.tcl -notfile gui.test $(TESTFLAGS)

testgui: base
	@$(TCLSH85) ./tests/all.tcl -file gui.test $(TESTFLAGS)

test86: base
	@$(TCLSH86) ./tests/all.tcl -notfile gui.test $(TESTFLAGS)

test84: base
	@$(TCLSH84) ./tests/all.tcl $(TESTFLAGS)

testoo: base
	@./nagelfar.tcl -s syntaxdb86.tcl ootest/*.tcl

#----------------------------------------------------------------
# Coverage
#----------------------------------------------------------------

# Source files for code coverage
SRCFILES = $(CATFILES)
IFILES   = $(SRCFILES:.tcl=.tcl_i)
LOGFILES = $(SRCFILES:.tcl=.tcl_log)
MFILES   = $(SRCFILES:.tcl=.tcl_m)

# Instrument source file for code coverage
%.tcl_i: %.tcl
	@./nagelfar.tcl -instrument $<

# Target to prepare for code coverage run. Makes sure log file is clear.
instrument: base $(IFILES) nagelfar.tcl_i
	@rm -f $(LOGFILES)

# Top file for coverage run
nagelfar_dummy.tcl: $(IFILES)
	@rm -f nagelfar_dummy.tcl
	@touch nagelfar_dummy.tcl
	@echo "#!/usr/bin/env tclsh" >> nagelfar_dummy.tcl
	@for i in $(SRCFILES) ; do echo "source $$i" >> nagelfar_dummy.tcl ; done

# Top file for coverage run
nagelfar.tcl_i: nagelfar_dummy.tcl_i
	@cp -f nagelfar_dummy.tcl_i nagelfar.tcl_i
	@chmod 775 nagelfar.tcl_i

# Run tests to create log file.
testcover $(LOGFILES): nagelfar.tcl_i
	@./tests/all.tcl $(TESTFLAGS)
	@$(TCLSH85) ./tests/all.tcl -match expand-*

# Create markup file for better view of result
%.tcl_m: %.tcl_log 
	@./nagelfar.tcl -markup $*.tcl

# View code coverage result
markup: $(MFILES)
icheck: $(MFILES)
	@for i in $(SRCFILES) ; do eskil -noparse $$i $${i}_m & done

# Remove code coverage files
clean:
	@rm -f $(LOGFILES) $(IFILES) $(MFILES) nagelfar.tcl_* nagelfar_dummy*

#----------------------------------------------------------------
# Generating test examples
#----------------------------------------------------------------

misctests/test.result: misctests/test.tcl nagelfar.tcl
	@cd misctests; ../nagelfar.tcl test.tcl > test.result

misctests/test.html: misctests/test.tcl misctests/htmlize.tcl \
		misctests/test.result
	@cd misctests; ./htmlize.tcl

misctest: misctests/test.result misctests/test.html

#----------------------------------------------------------------
# Generating database
#----------------------------------------------------------------

syntaxdb.tcl: syntaxbuild.tcl $(TCLSHDB)
	$(TCLSHDB) syntaxbuild.tcl syntaxdb.tcl

$(DB2NAME): syntaxbuild.tcl $(TCLSHDB2)
	$(TCLSHDB2) syntaxbuild.tcl $(DB2NAME)

$(DB3NAME): syntaxbuild.tcl $(TCLSHDB3)
	$(TCLSHDB3) syntaxbuild.tcl $(DB3NAME)

db: syntaxdb.tcl $(DB2NAME) $(DB3NAME)

#----------------------------------------------------------------
# Packaging/Releasing
#----------------------------------------------------------------

force: base
	make -B nagelfar.tcl
.phony: force

wrap: base
	sdx wrap nagelfar.kit

wrapexe: base
	@\rm -f nagelfar nagelfar.exe nagelfar.solaris nagelfar_sh.exe
	sdx wrap nagelfar.linux   -runtime $(TCLKIT85_LINUX)
	sdx wrap nagelfar.solaris -runtime $(TCLKIT_SOLARIS)
	sdx wrap nagelfar.exe     -runtime $(TCLKIT85_WIN)
	sdx wrap nagelfar.shexe   -runtime $(TCLKITSH85_WIN)
	mv nagelfar.shexe nagelfar_sh.exe

distrib: base
	@\rm -f nagelfar.tar.gz
	@ln -s . nagelfar$(VERSION)
	@mkdir -p lib
	@ln -sf $(TEXTSEARCH) lib/textsearch
	@tar --exclude .svn -cvf nagelfar.tar nagelfar$(VERSION)/COPYING \
		nagelfar$(VERSION)/README.txt nagelfar$(VERSION)/syntaxbuild.tcl \
		nagelfar$(VERSION)/syntaxdb.tcl nagelfar$(VERSION)/syntaxdb84.tcl \
		nagelfar$(VERSION)/syntaxdb86.tcl \
		nagelfar$(VERSION)/nagelfar.syntax nagelfar$(VERSION)/nagelfar.tcl \
		nagelfar$(VERSION)/misctests/test.tcl nagelfar$(VERSION)/misctests/test.syntax \
		nagelfar$(VERSION)/doc
	@tar --exclude .svn --exclude CVS -rvhf nagelfar.tar \
		nagelfar$(VERSION)/lib
	@gzip nagelfar.tar
	@\rm lib/textsearch
	@\rm nagelfar$(VERSION)

release: force distrib wrap wrapexe
	@cp nagelfar.tar.gz nagelfar`date +%Y%m%d`.tar.gz
	@mv nagelfar.tar.gz nagelfar$(VERSION).tar.gz
	@gzip nagelfar.linux
	@mv nagelfar.linux.gz nagelfar$(VERSION).linux.gz
	@zip nagelfar$(VERSION).win.zip nagelfar.exe
	@zip nagelfar_sh$(VERSION).win.zip nagelfar_sh.exe
	@gzip nagelfar.solaris
	@mv nagelfar.solaris.gz nagelfar$(VERSION).solaris.gz
	@cp nagelfar.kit nagelfar`date +%Y%m%d`.kit
	@cp nagelfar.kit nagelfar$(VERSION).kit
