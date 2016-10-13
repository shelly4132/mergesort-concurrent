CC = gcc
CFLAGS = -std=gnu99 -Wall -g -pthread
OBJS = list.o threadpool.o main.o

.PHONY: all clean test

GIT_HOOKS := .git/hooks/pre-commit

ifeq ($(strip $(CHECK)),1)
CFLAGS += -DCHECK
endif

all: $(GIT_HOOKS) sort

$(GIT_HOOKS):
	@scripts/install-git-hooks
	@echo

deps := $(OBJS:%.o=.%.o.d)
%.o: %.c
	$(CC) $(CFLAGS) -o $@ -MMD -MF .$@.d -c $<

test_input:
	$(CC) $(CFLAGS) test_input.c -o test_input

sort: $(OBJS)
	$(CC) $(CFLAGS) -o $@ $(OBJS) -rdynamic

check: sort test_input
	for i in `seq 1 1 500`; do\
	    ./test_input $$i; \
	    ./sort 4 $$i; \
	    sort -n test_input.txt > sorted.txt; \
	    diff output.txt sorted.txt; \
	done
	@echo "Verified OK"

clean:
	rm -f $(OBJS) sort test_input output.txt sorted.txt test_input.txt
	@rm -rf $(deps)

-include $(deps)
