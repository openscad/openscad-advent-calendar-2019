PARAMS=$(wildcard *.param)
PNGS=$(patsubst %.param,%.png,$(PARAMS))

_%.png : %.param .options
	openscad -o $@ `cat .options` `cat $<`

%.png : _%.png
	convert $< -scale 240x-1 $@

all : $(PNGS)

clean :
	rm -f *.png

.PHONY: clean
