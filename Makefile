# ****************************************************************
# Makefile for KarelLearnsC

SHELL=/bin/bash
# Sets the target platform for SPL
# Valid values for variable platform are unixlike and windows
ifeq ($(OS),Windows_NT)
PLATFORM=windows
else
PLATFORM=unixlike
endif

KAREL=src/karel
SDL=src/mingw/SDL-1.2.15

# Additional compiler flags
CFLAGS=-std=gnu11 -w -g


BUILD = \
	build \
    build/$(PLATFORM) \
    build/$(PLATFORM)/lib \
    build/$(PLATFORM)/obj 

OBJECTS = \
    build/$(PLATFORM)/obj/cursor.o \
    build/$(PLATFORM)/obj/draw.o \
    build/$(PLATFORM)/obj/font.o \
    build/$(PLATFORM)/obj/graphicsManager.o \
    build/$(PLATFORM)/obj/init.o \
    build/$(PLATFORM)/obj/input.o \
    build/$(PLATFORM)/obj/karel.o \
    build/$(PLATFORM)/obj/main.o \
    build/$(PLATFORM)/obj/world.o

LIBRARIES = build/$(PLATFORM)/lib/libkarel.a

PROJECT = StarterProject \
		  StarterProjects

# ***************************************************************
# Entry to bring the package up to date
#    The "make all" entry should be the first real entry

all: $(BUILD) $(OBJECTS) $(LIBRARIES) copy

# ***************************************************************
# directories

$(BUILD):
	@echo "Build Directories"
	@mkdir -p $(BUILD)


# ***************************************************************
# Library compilations

build/$(PLATFORM)/obj/cursor.o:
	@echo "Build curser.o"
	@gcc $(CFLAGS) -c -o build/$(PLATFORM)/obj/cursor.o -I$(SDL)/include -I$(KAREL)/include $(KAREL)/cursor.c

build/$(PLATFORM)/obj/draw.o: 
	@echo "Build draw.o"
	@gcc $(CFLAGS) -c -o build/$(PLATFORM)/obj/draw.o -I$(SDL)/include -I$(KAREL)/include $(KAREL)/draw.c

build/$(PLATFORM)/obj/font.o: 
	@echo "Build font.o"
	@gcc $(CFLAGS) -c -o build/$(PLATFORM)/obj/font.o -I$(SDL)/include -I$(KAREL)/include $(KAREL)/font.c

build/$(PLATFORM)/obj/graphicsManager.o: 
	@echo "Build graphicsManger.o"
	@gcc $(CFLAGS) -c -o build/$(PLATFORM)/obj/graphicsManager.o -I$(SDL)/include -I$(KAREL)/include $(KAREL)/graphicsManager.c

build/$(PLATFORM)/obj/init.o: 
	@echo "Build init.o"
	@gcc $(CFLAGS) -c -o build/$(PLATFORM)/obj/init.o -I$(SDL)/include -I$(KAREL)/include $(KAREL)/init.c

build/$(PLATFORM)/obj/input.o: 
	@echo "Build init.o"
	@gcc $(CFLAGS) -c -o build/$(PLATFORM)/obj/input.o -I$(SDL)/include -I$(KAREL)/include $(KAREL)/input.c

build/$(PLATFORM)/obj/karel.o: 
	@echo "Build karel.o"
	@gcc $(CFLAGS) -c -o build/$(PLATFORM)/obj/karel.o -I$(SDL)/include -I$(KAREL)/include $(KAREL)/karel.c

build/$(PLATFORM)/obj/main.o: 
	@echo "Build main.o"
	@gcc $(CFLAGS) -c -o build/$(PLATFORM)/obj/main.o -I$(SDL)/include -I$(KAREL)/include $(KAREL)/main.c

build/$(PLATFORM)/obj/world.o: 
	@echo "Build world.o"
	@gcc $(CFLAGS) -c -o build/$(PLATFORM)/obj/world.o -I$(SDL)/include -I$(KAREL)/include $(KAREL)/world.c

#build/$(PLATFORM)/obj/exception.o: c/src/exception.c c/include/cslib.h \
#                 c/include/exception.h c/include/strlib.h \
#                 c/include/unittest.h
#	gcc $(CFLAGS) -c -o build/$(PLATFORM)/obj/exception.o -Ic/include c/src/exception.c

# ***************************************************************
# Entry to reconstruct the library archive

build/$(PLATFORM)/lib/libkarel.a: $(OBJECTS)
	@echo "Build libkarel.a"
	@-rm -f build/$(PLATFORM)/lib/libkarel.a
	@ar crs build/$(PLATFORM)/lib/libkarel.a $(OBJECTS)
	@ranlib build/$(PLATFORM)/lib/libkarel.a

copy:
	@echo "Copy static files, header and libs"
	@cp -r src/karel/include build/$(PLATFORM)/
	@cp -r src/mingw/SDL-1.2.15/include build/$(PLATFORM)/
	@cp -r src/mingw/SDL-1.2.15/lib build/$(PLATFORM)/
	@cp -r src/karel/assets build/$(PLATFORM)/
	@cp -r src/karel/data build/$(PLATFORM)/

clion_windows: clean $(BUILD) $(OBJECTS) $(LIBRARIES) copy
	@echo "Build StarterProject for Clion on Windows"
	@rm -rf StarterProject
	@cp -r ide/clion/windows StarterProject
	@cp -r build/$(PLATFORM)/include StarterProject/include
	@cp -r build/$(PLATFORM)/lib StarterProject/lib
	@cp -r build/$(PLATFORM)/assets StarterProject/assets
	@cp -r build/$(PLATFORM)/data StarterProject/data
	@echo "Check the StarterProject folder"

# ***************************************************************
# Standard entries to remove files from the directories
#    tidy    -- eliminate unwanted files
#    scratch -- delete derived files in preparation for rebuild

tidy: 
	@echo "Clean Project"
	@rm -f `find . -name ',*' -o -name '.,*' -o -name '*~'`
	@rm -f `find . -name '*.tmp' -o -name '*.err'`
	@rm -f `find . -name core -o -name a.out`
	@rm -rf build/classes
	@rm -rf build/obj

scratch clean: tidy
	@echo "Remove Directories"
	@rm -f -r $(BUILD) $(OBJECTS) $(LIBRARIES) $(PROJECT)
	@echo "Cleaning is Done!"
