# Detect system OS.
ifeq ($(OS),Windows_NT)
	detected_OS := Windows
else
	detected_OS := $(shell sh -c 'uname -s 2>/dev/null || echo not')
endif

C_SRCS=$(shell find src -name *.c)

OBJS=$(C_SRCS:.c=.o)

# Modify the executable name by yourself.
ifeq (,$(LIBRARY))
	LIBRARY=libalgebra
endif

ifeq ($(detected_OS),Windows)
	DYNAMIC_LIB=$(LIBRARY).dll
else
ifeq ($(detected_OS),Darwin)
	DYNAMIC_LIB=$(LIBRARY).dylib
else
	DYNAMIC_LIB=$(LIBRARY).so
endif  # Darwin
endif  # Windows
STATIC_LIB=$(LIBRARY).a

# Set the C standard.
ifeq (,$(C_STD))
	C_STD=c11
endif


# Set the include path of libobjc on non-Apple platforms.
OBJC_INCLUDE := -I $(GCC_LIB)/include

.PHONY: all dynamic static clean

all: dynamic

dynamic: dist/$(DYNAMIC_LIB)

dist/$(DYNAMIC_LIB): $(OBJS)
	$(CC) -shared -o dist/$(DYNAMIC_LIB) $(OBJS)

static: dist/$(STATIC_LIB)

dist/$(STATIC_LIB): $(OBJS)
ifeq ($(detected_OS),Darwin)
	libtool -o dist/$(STATIC_LIB) $(OBJS)
else
	$(AR) rcs -o dist/$(STATIC_LIB) $(OBJS)
endif

%.o:%.c
ifeq (dynamic,$(MAKECMDGOALS))
	$(CC) -fPIC -std=$(C_STD) -c $< -o $@ $(CFLAGS) -I include
else
	$(CC) -std=$(C_STD) -c $< -o $@ $(CFLAGS) -I include
endif

clean:
	$(RM) dist/$(DYNAMIC_LIB) dist/$(STATIC_LIB) $(OBJS)
