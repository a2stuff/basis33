
CAFLAGS = --target apple2enh --list-bytes 0
LDFLAGS = --config apple2-asm.cfg

TARGETS = total.replay.SYS

.PHONY: clean all
all: $(TARGETS)

HEADERS = $(wildcard *.inc)

clean:
	rm -f *.o
	rm -f $(TARGETS)

%.o: %.s $(HEADERS)
	ca65 $(CAFLAGS) --listing $(basename $@).list -o $@ $<

%.SYS: %.o
	ld65 $(LDFLAGS) -o $@ $<
	xattr -wx prodos.AuxType '00 20' $@
