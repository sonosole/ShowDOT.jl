"""
    Show directed graph via dot formatted string/file. Here the `Show`DOT means
    showing it inside a terminal, or save it as a picture so as to show it
    inside other apps that can open it.
"""
module ShowDOT


using Sixel
using FileIO
using PNGFiles
using Graphviz_jll

include("misc.jl")

include("0-storage.jl")
export saveas, png, pdf, svg

include("1-terminal.jl")
export tshow
export setdpi

include("2-webpage.jl")
export pshow

include("3-autoshow.jl")
export autoshow

include("4-vt.jl")
export vt, vt4up, vt6up, vt8up, vt24bit


end # module ShowDOT

