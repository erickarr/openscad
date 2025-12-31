.PHONY: all clean sbs

# OpenSCAD executable
oscad := openscad

# All .scad files in this directory
sbs_file := snowblower_skid.scad

# Corresponding .stl files
stl_dir = ../stl
sbs_stl_files := $(addprefix  $(stl_dir)/, snowblower_skid_bushing.stl snowblower_skid_wheel.stl snowblower_skid.stl)

# Default target
all: sbs

sbs: $(sbs_stl_files)

# Generic rule to generate STL from SCAD
$(stl_dir)/%.stl: %.scad
	$(oscad) -o $@ $<

$(stl_dir)/snowblower_skid.stl: $(sbs_file)
	$(oscad) -D 'ASM="skid"' -o $@ $<

$(stl_dir)/snowblower_skid_wheel.stl: $(sbs_file)
	$(oscad) -D 'ASM="wheel"' -o $@ $<

$(stl_dir)/snowblower_skid_bushing.stl: $(sbs_file)
	$(oscad) -D 'ASM="bushing"' -o $@ $<

# Clean generated files
clean:
	rm -f $(sbs_stl_files)

