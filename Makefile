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

sort: $(OBJS)
	$(CC) $(CFLAGS) -o $@ $(OBJS) -rdynamic

checker:
	$(CC) $(CFLAGS) checker.c -o checker

check: sort checker
	uniq words.txt | sort -R > words_input.txt
	./sort 4
	./checker

clean:
	rm -f $(OBJS) sort checker output.txt words_input.txt
	@rm -rf $(deps)

-include $(deps)
