# Compiler and compiler flags
CC = gcc
CFLAGS = -I Include -Wall -Wextra -Werror

# Define the target executable
TARGET = First

# Define the source and object files
SRCS = $(wildcard Utils/*.c) First.c
OBJS = $(SRCS:.c=.o)

# The first rule is the default rule
# Build the target executable
$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $(TARGET) $(OBJS)

# Rule to generate object files
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Clean rule
clean:
	rm -f $(OBJS) $(TARGET)

# Phony targets
.PHONY: clean
