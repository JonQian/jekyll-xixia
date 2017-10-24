---
layout: post
title:  "JupyterLab使用笔记"
categories: Python
tags: Jupyter Python
author: JonQian
description: 
---

[Github JupyterLab](https://github.com/jupyterlab/jupyterlab)

## 1. 启动JupyterLab
```
jupyter lab --ip=0.0.0.0 --no-browser --notebook-dir=notebook
```

> `--ip=0.0.0.0` 监听所有ip，允许其他电脑访问  
> `--no-brower` 不启动本地浏览器  
> `--notebook-dir` 指定根目录 


注：发现还是jupyter notebook比jupyter lab好用一些，前者允许notebook中的markdown文本引用目录下的图片等资源，而jupyter lab则可能是增强了安全控制，禁止引用本地资源

## 2.设置密码登录
[ Running a notebook server](http://jupyter-notebook.readthedocs.io/en/latest/public_server.html) 

## 3.隐藏代码导出html
```
jupyter nbconvert --to html --template=hidecode.tpl --post serve $1
```
> `--post serve` 可以通过127.0.0.1:8000访问html文件  
> `--template=hidecode.tpl` 隐藏python代码

hidecode.tpl
{% assign openTag = '{%' %}
```
{{ openTag }} extends 'full.tpl'%}
{{ openTag }} block input_group -%}
{{ openTag }} endblock input_group %}
```

tpl语法参考[Customizing nbconvert](http://nbconvert.readthedocs.io/en/5.x/customizing.html "Customizing nbconvert")

## 4.嵌入显示matplotlib结果
``` python
%matplotlib inline
import matplotlib.pyplot as plt
import numpy
x=numpy.arange(-2,2,0.1)
plt.plot(x,numpy.sin(x))
plt.show()
```
![png](http://img.blog.csdn.net/20170310150628595?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvY29kZV9nYW1l/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

## 5.matplotlib显示中文
``` python
#matplotlib字体目录：/site-packages/matplotlib/mpl-data/fonts/ttf/
#不支持ttc格式字体文件，譬如放入微软雅黑字体文件msyh.ttf
from matplotlib.font_manager import _rebuild
_rebuild()#重新创建字体索引列表
import matplotlib
matplotlib.rcParams['font.family']=['Microsoft YaHei']
#或者修改/site-packages/matplotlib/mpl-data/matplotlibrc文件中的'font.family'字段
plt.title('中文标题')
plt.plot(x,numpy.sin(x))
plt.show()
```
![png](http://img.blog.csdn.net/20170310150926490?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvY29kZV9nYW1l/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)