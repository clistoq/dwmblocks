include config.mk

all: clean install

output: dwmblocks.c blocks.h
	${CC} ${CFLAGS} ${LDFLAGS} dwmblocks.c -o dwmblocks
	chmod 755 dwmblocks

clean:
	rm -rf *.o *.gch dwmblocks bin/

scripts:
	mkdir -p bin/scripts
	$(foreach script,$(wildcard scripts/*.sh),cp -f ${script} bin/${script:src/%.sh=%};)
	chmod 755 bin/*

install: output scripts
	mkdir -p $(DESTDIR)${PREFIX}/bin/dwmblocks-scripts
	cp -f dwmblocks $(DESTDIR)${PREFIX}/bin
	cp -f bin/scripts/* $(DESTDIR)${PREFIX}/bin/dwmblocks-scripts

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/dwmblocks

.PHONY: all clean scripts install uninstall
