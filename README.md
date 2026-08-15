$$
\Huge{
    \bf
    \color{RoyalBlue}{Show}
    \color{Orange}{DOT}
    \color{purple}{{}^{👁}⎣{}^{👁}}
    }

$$

Show directed graph via DOT formatted `String` or a `*.dot` file. Here the **Show**DOT means showing it inside a terminal 💻 or a webpage based notebook 📕 , or VSCode plotpane, or save it as a picture so as to show it inside other apps that can open it.

![GitHub Created At](https://img.shields.io/github/created-at/sonosole/ShowDOT.jl?color=%233F6184) ![GitHub Release Date](https://img.shields.io/github/release-date/sonosole/ShowDOT.jl?color=%232684FC) ![GitHub Tag](https://img.shields.io/github/v/tag/sonosole/ShowDOT.jl?sort=date&color=%230288D1) ![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/sonosole/ShowDOT.jl) ![GitHub Downloads (all assets, all releases)](https://img.shields.io/github/downloads/sonosole/ShowDOT.jl/total?color=%23E60012) [![Hits](https://hits.dwyl.com/sonosole/ShowDOT.jl.svg)](https://hits.dwyl.com/sonosole/ShowDOT.jl)
![GitHub License](https://img.shields.io/github/license/sonosole/ShowDOT.jl?style=flat&logoColor=%23003A9A&color=%239558B2) ![Static Badge](https://img.shields.io/badge/Julia-v1.6%2B-%239558B2?logo=julia&link=https%3A%2F%2Fjulialang.org) ![Static Badge](https://img.shields.io/badge/email-sonosole%40163.com-%239558B2?logo=gmail)

 Installation 💾

```julia
using Pkg; Pkg.add("ShowDOT")
```

# Navigation of APIs

| Where You Are | ![](doc/logo-term.svg) | ![](doc/logo-pluto.svg) |        ![](doc/logo-jupyter.svg)        |     ![](doc/logo-vscode.svg)     |
| :-------------: | :----------------------: | :-----------------------: | :----------------------------------------: | :---------------------------------: |
|  What to Use  |  *`autoshow`* `tshow`  |  *`autoshow`* `pshow`  | *`autoshow`* `pshow` `svgshow` `pngshow` | *`autoshow`* `svgshow` `pngshow` |

`autoshow` works everywhere, but if it fails 💔, fall back to others in the above table 😁.

+ In Jupyter, `pngshow` output can be exported as a **.png* file, `svgshow` output can be exported as a **.svg* or **.pdf* file.
+ In VSCode, `pngshow` output can be exported as a **.png* file, `svgshow` output can be exported as a **.svg* file.

All the APIs in table accept only one input argument which is a DOT format string or a `/path/to/my.dot` file.

# Usage 👨‍🏫

## Show Inside Terminal 💻

It's a very simple API, pass the dot format string into `tshow`

```julia
tshow(dotstr_or_dotfile::AbstractString)
```

here is an easy example

```julia
mygraph = """
digraph G {
  rankdir = LR;

  subgraph cluster_0 {
    style=filled;
    color=lightgrey;
    node [style=filled,color=white];
    a0 -> a1 -> a2 -> a3;
    label = "process #1";
  }

  subgraph cluster_1 {
    node [style=filled];
    b0 -> b1 -> b2 -> b3;
    label = "process #2";
    color=blue
  }

  start -> a0; a1 -> b3; a3 -> a0;
  start -> b0; b2 -> a3; a3 -> end; b3 -> end;
  start [shape=Mdiamond];
  end [shape=Msquare];
}
"""
setdpi(100)    # default dpi is 100, it affects both showing and saving
tshow(mygraph)
```

<div align="center">
  <img src="doc/show-inside-terminal.PNG" alt="show-in-terminal" width="800"/>
</div>

## Show Inside Webpage Notebooks 🌐📕

With this simple API

```julia
pshow(dotstr_or_dotfile::String)
```

we can show dot format string inside 🎈**Pluto** notebook

<div align="center">
  <img src="doc/show-inside-pluto.PNG" alt="show-in-pluto" width="800"/>
</div>

## Automatically Show Wherever You Are 🎡

This simple API

```julia
autoshow(dotstr_or_dotfile::String)
```

automatically shows DOT string/file when you are inside a terminal or Pluto or IJulia notebooks.


| `autoshow` in term                        | `autoshow` in Pluto                    | `autoshow` in VSCode                   |
| ------------------------------------------- | ---------------------------------------- | ----------------------------------------- |
| ![img](doc/show-inside-terminal-auto.PNG) | ![img](doc/show-inside-pluto-auto.PNG) | ![img](doc/show-inside-vscode-auto.PNG) |

## Low Quality Pixels in Terminal 🏁

```julia
vt(dotsrc::String)
vt4up(dotsrc::String)
vt6up(dotsrc::String)
vt8up(dotsrc::String)
vt24bit(dotsrc::String)
```

their usage is the same as `tshow`. I bet you won't like it 🤣

## Save As Pictures 🗺️

### Unified Common Interface 📁

```julia
saveas(path_to_file::String, dotsrc::String)
```

for example, save `mygraph::String` as a png file

```julia
my_pic_file = "/home/work/pic.png"
saveas(my_pic_file, mygraph)
```

supported picture types are: canon cmap cmapx cmapx_np dot dot_json eps fig gv imap imap_np ismap json json0 kitty kittyz pdf pic plain plain-ext png pov ps ps2 svg svg_inline svgz tk vt vt-24bit vt-4up vt-6up vt-8up vt-8up2 xdot xdot1.2 xdot1.4 xdot_json.

### Three Convenient APIs 📁

```julia
png(path_and_name_with_no_suffix::String, dotstr_or_dotfile::String)
svg(path_and_name_with_no_suffix::String, dotstr_or_dotfile::String)
pdf(path_and_name_with_no_suffix::String, dotstr_or_dotfile::String)
```

for example, save `mygraph::String` as a svg file

```julia
my_pic_file = "/home/work/pic"
svg(my_pic_file, mygraph)
```

or save a `/path/to/my.dot` as a svg file

```julia
my_pic_file = "/home/work/pic"
svg(my_pic_file, "/path/to/my.dot")
```

then `/home/work/pic.svg` is saved.

## Advanced Showcase for User Defined Struct

Just see a minimal example

```julia
struct MyStruct
    src::Int
    dst::Int
end

function mystruct2dotstr(x)
    s = x.src
    d = x.dst
    return "digraph G {$s -> $d}"
end

# show MyStruct object inside a terminal
Base.show(io::IO, ::MIME"text/plain", x::MyStruct)
    dotstr = mystruct2dotstr(x)
    return tshow(dotstr)
end

# show MyStruct object inside a webpage notebook, like Pluto/IJulia
Base.show(io::IO, ::MIME"image/svg+xml", x::MyStruct)
    dotstr = mystruct2dotstr(x)
    return pshow(dotstr)
end
```

now you can customize your own pretty shows. 💖
