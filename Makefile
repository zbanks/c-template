TARGET = my_binary

CC=gcc

CFLAGS = -std=c11 -Wall -Wextra -Wconversion -Werror -D_DEFAULT_SOURCE -Isrc/
CFLAGS += -ggdb3 -O0
#CFLAGS += -O3
LFLAGS = 

$(shell mkdir -p build)
OBJECTS = $(patsubst src/%.c,build/%.o,$(wildcard src/*.c))
DEPS = $(OBJECTS:.o=.d)
-include $(DEPS)

build/%.o: src/%.c
	$(CC) -c $(CFLAGS) src/$*.c -o build/$*.o
	$(CC) -MM $(CFLAGS) src/$*.c > build/$*.d

$(TARGET): $(OBJECTS)
	$(CC) $^ $(CFLAGS) $(LFLAGS) -o $@

.PHONY: clean
clean:
	-rm -rf build my_binary

.PHONY: all
all: $(TARGET)

.DEFAULT_GOAL = all
