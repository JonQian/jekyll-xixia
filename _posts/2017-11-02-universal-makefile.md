---
layout: post
title:  "通用Makefile"
categories: 
tags: 
author: JonQian
description: 
---
主要用于Linux下十来个源文件的小型程序，无论修改源文件还是头文件，每一次都会重新编译所有文件  
默认以项目文件夹名称作为输出程序名称  
新建bin文件夹存放输出文件，obj文件夹存放中间文件  
编译2层子目录下的所有c与cpp文件

```
PNAME = $(shell pwd |sed 's/^\(.*\)[/]//')

CC = gcc
AR = ar
LD = g++
WINDRES = windres

INC = -I.
CFLAGS = -Wall -fexceptions -O2
RESINC =
LIBDIR =
LIB =
LDFLAGS = -s

OUTDIR = bin
OBJDIR = obj
OUT = $(OUTDIR)/$(PNAME)

exclude_dirs = $(OUTDIR) $(OBJDIR) $(OUTDIR)/% $(OBJDIR)/%
SUBDIR = $(shell find . -maxdepth 2 -type d)
SUBDIR := $(basename $(patsubst ./%,%,$(SUBDIR)))
SUBDIR := $(filter-out $(exclude_dirs),$(SUBDIR))

SRCS = $(wildcard *.cpp) $(foreach dir,$(SUBDIR), $(wildcard $(dir)/*.cpp)) $(wildcard *.c) $(foreach dir,$(SUBDIR), $(wildcard $(dir)/*.c))
INCS = $(wildcard *.hpp) $(foreach dir,$(SUBDIR), $(wildcard $(dir)/*.hpp)) $(wildcard *.h) $(foreach dir,$(SUBDIR), $(wildcard $(dir)/*.h))
OBJS = $(patsubst %.c,$(OBJDIR)/%.o,$(patsubst %.cpp,$(OBJDIR)/%.o,$(SRCS)))

all: before out

before:
	@test -d $(OBJDIR) || mkdir -p $(OBJDIR)
	@test -d $(OUTDIR) || mkdir -p $(OUTDIR)
	@for dir in $(addprefix $(OBJDIR)/,$(SUBDIR));do test -d $$dir || mkdir -p $$dir;done

out: $(OBJS)
	$(LD) $(LIBDIR) -o $(OUT) $(OBJS) $(LDFLAGS) $(LIB)

$(OBJS): $(SRCS) $(INCS)
	$(CC) $(CFLAGS) $(INC) -c $(filter $(patsubst $(OBJDIR)/%.o,%,$@).%,$(SRCS)) -o $@

clean:
	rm -f $(OUT)
	test ! -d $(OUTDIR) || rmdir --ignore-fail-on-non-empty $(OUTDIR)
	rm -rf $(OBJDIR)

.PHONY: all clean
```