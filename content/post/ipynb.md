---
title: "The Jupyter Notebook"
date: "2014-12-02"
author: "Spencer Lyon"
series: ["Hacking"]
tags: ["tips", "python", "ipython"]
---


# Ipynb

## Slidemode

To activate slide mode I did the following

1. Clone nbextensions repo into the right place:

```
cd ~/.ipython
git clone git@github.com:ipython-contrib/IPython-notebook-extensions.git nbextensions
```
2. Edit `~/.ipython/profile_default` and `~/.ipython/profile_default` so that in the section titled `$([IPython.events]).on('app_initialized.NotebookApp', function(){` I had the line `IPython.load_extensions('slidemode/main')`.


If I want to use nbconvert to give me reveal.js slides and then view them locally I need to start a python webserver:


```bash
ipython nbconvert --to slides my_notebook.ipynb
python -m SimpleHTTPServer 8000
open http://127.0.0.1:8000
```

## Registering kernels in IPython 3.0+

IPython versions 3.0+ have a great feature where you can launch the notebook and then select the kernel you want from a dropdown list. Right now I have python2, python3, R, and Julia ready to go. This makes it so we can switch from notebooks in different languages without having to restart IPython.

To register a new kernel you only need to create a file named `kernel.json` in `~/.ipython/kernels/<language_name>/kernel.json`. For example I have:

```
HW2|master⚡ ⇒ cat ~/.ipython/kernels/julia/kernel.json
{
 "display_name": "Julia",
 "language": "julia",
 "argv": [
    "julia",
    "-i",
    "-F",
    "/Users/sglyon/.julia/v0.3/IJulia/src/kernel.jl",
    "{connection_file}"
 ],
 "codemirror_mode":"julia"
}
```

```
HW2|master⚡ ⇒ cat ~/.ipython/kernels/ir/kernel.json
{"argv": ["R","-e","IRkernel::main()","--args","{connection_file}"],
 "display_name":"R"
}
```

```
HW2|master⚡ ⇒ cat ~/.ipython/kernels/python3/kernel.json
{
 "argv": ["/Users/sglyon/anaconda/envs/py3/bin/python3", "-m", "IPython.kernel",
          "-f", "{connection_file}"],
 "display_name": "Python 3",
 "language": "python"
}
```


### Remote access to ipynb

See also the note about setting up a persistent notebook on GCE in the cloud.md file.


### Extensions

https://github.com/ipython-contrib/IPython-notebook-extensions/wiki/config-extension

Editing: `/usr/local/share/jupyter/nbextensions/livereveal/main.js`


## nbviewer

nbviewer caches the rendered version of a notebook. If you recently updated the
source and want to see the updated version on nbviewer, append
`?flush_cache=true` to the url.

For example, to force a re-compile of the notebook at `http://nbviewer.jupyter.org/gist/sglyon/d884a4f7ef9e9bd5862428303179b2bd` you would visit the url `http://nbviewer.jupyter.org/gist/sglyon/d884a4f7ef9e9bd5862428303179b2bd?flush_cache=true`
