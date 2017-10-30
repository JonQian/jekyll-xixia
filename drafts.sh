#!/bin/bash  

if [ ! -d "_drafts" ]; then
  mkdir _drafts
fi

jekyll serve -w --drafts --host 0.0.0.0