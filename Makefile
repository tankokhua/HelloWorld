.SUFFIXES:
.SUFFIXES: .c .o

.PHONY: clean

obj_dir = ./bin

c_sources := $(wildcard ./*.c)
_c_objs := $(notdir $(c_sources:.c=.o))
c_objs = $(patsubst %,$(obj_dir)/%, $(_c_objs))


C_COMPILER = gcc
C_FLAGS = -lpthread


# Make obj for *.apg files
$(obj_dir)/%.o: %.c
	$(C_COMPILER) $(C_FLAGS) -o $@ $<

all:
	@make --no-print-directory common

common: $(c_objs)
	@echo ''


clean:
	\rm bin/*.o
