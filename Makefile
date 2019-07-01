.SUFFIXES:
.SUFFIXES: .c .o

.PHONY: clean

obj_dir = ./bin

c_sources := $(wildcard ./*.c)
c_objs := $(notdir $(c_sources:.c=.o))


C_COMPILER = gcc
C_FLAGS = -lpthread


# Make obj for *.apg files
%.o: %.c
	$(C_COMPILER) $(C_FLAGS) -o $(obj_dir)/$@ $<

all:
	@make --no-print-directory common

common: $(c_objs)
	@echo ''


clean:
	\rm bin/*.o
