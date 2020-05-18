include config.mk

SRC = dwmblocks.c
OBJ = ${SRC:.c=.o}

all: install clean

.c.o:
	${CC} -c ${CFLAGS} $< -o ${<:.c=.o}

${OBJ}: blocks.h config.mk

dwmblocks: ${OBJ}
	mkdir -p bin
	${CC} -o bin/$@ dwmblocks.o ${LDFLAGS} 
	chmod 755 bin/dwmblocks

clean:
	rm -rf *.o *.gch dwmblocks bin/

scripts:
	mkdir -p bin/scripts
	cp -fp bash-utility-scripts/wm-scripts/* bin/scripts
	chmod 755 bin/scripts/*

install: dwmblocks scripts
	mkdir -p ${DESTDIR}${PREFIX}/bin ${DESTDIR}${SCRIPTPREFIX}/dwmblocks
	cp -fp bin/dwmblocks $(DESTDIR)${PREFIX}/bin
	cp -fp bin/scripts/* $(DESTDIR)${SCRIPTPREFIX}/dwmblocks/

uninstall:
	rm -rf $(DESTDIR)$(PREFIX)/bin/dwmblocks $(DESTDIR)${SCRIPTPREFIX}/dwmblocks

.PHONY: all clean scripts install uninstall
