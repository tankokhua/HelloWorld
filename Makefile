.SUFFIXES:
.SUFFIXES: .apg .apo .d

.PHONY: clean

obj_dir = ./obj

vpath %.d   $(obj_dir) 
vpath %.apo $(obj_dir)

MONGVER = 2
apg_sources := $(wildcard ./f*.apg)
apg_depends := $(addprefix $(obj_dir)/, $(notdir $(apg_sources:.apg=.d)))
apg_objs := $(notdir $(apg_sources:.apg=.apo))

asc_sources := $(wildcard ./*.asc)
asc_objs := $(notdir $(asc_sources:.asc=.apg))

ifneq (,$(filter common, $(MAKECMDGOALS)))
-include $(apg_depends)
endif

APG_COMPILER = /u/tankok/pgms/tecobralib2/release/v2/cobra_apgc.py
APG_FLAGS = -r $(MONGVER) -D MONGVER=$(MONGVER)
APG_CPP   =cpp
APG_CPP_FLAGS = -I /u/tankok/pgms/v48a_smg2/include -I /u/tankok/pgms/smg2lib/include

A2M = /u/tankok/tools/mongoose_scripts/a2m.py

# Make Dependencies for *.apg files
$(obj_dir)/%.d: %.apg
	@echo 'Creating dependency $(@F) for $<.'
	@set -e; rm -f $@; $(APG_CPP) $(APG_CPP_FLAGS) -MM  $< \
                | sed 's/\($(notdir $*)\)\.o[ :]*/\1.apo $(@F) : /g' > $@; \
                [ -s $@ ] || rm -f $@


# Make obj for *.apg files
%.apo: %.apg
	@$(APG_COMPILER) $(APG_FLAGS) $(APG_CPP_FLAGS) -o $(obj_dir)/$@ $<
	@echo 'Done compiling $< ...'
	@[ -s $(obj_dir)/$@ ] || rm -f $(obj_dir)/$@

%.apg: %.asc
	@echo "Converting $(subst dsf,fsf,$(basename $@))0 ..."
	@$(A2M) -f $< -o -n $(subst dsf,fsf,$(basename $@))'0' -p 0x000

all:
	@make --no-print-directory common

common: $(apg_depends) $(apg_objs)
	@echo ''

conv: $(asc_objs)
	@echo "Done converting asc to apg ..."

clean:
	\rm obj/*.apo obj/*.d
