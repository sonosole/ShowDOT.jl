global dpi::Int = 100

"""
    setdpi(newdpi::Int)
Resolution settings, default DPI is 100.
"""
function setdpi(newdpi::Int)
    global dpi
    dpi = newdpi > 0 ? newdpi : 100
    return nothing
end


"""
    tshow(dotsrc::AbstractString)

Show dot format string/file inside terminal.
!!! note 
    The terminal should support Sixel graphics.
# Example
```julia
julia> tshow("digraph {a->b}")
julia> tshow("/path/to/my.dot")
```
# Working pipeline
dotsrc ─►  dot engine ─►  in-momery PNG ─►  Sixel
"""
function tshow(dotsrc::String)
    global dpi
    dotbuf = IOBuffer();
    dotstr = isdotfile(dotsrc) ? read(dotsrc, String) : dotsrc
    run(pipeline(`$dotexe -q -Tpng -Gdpi=$dpi`,
                 stdin=IOBuffer(dotstr),
                 stdout=dotbuf));
    tmpbuf = take!(dotbuf)           # read PNG data in-momery
    pngbuf = load(IOBuffer(tmpbuf))  # load png buf
    return Sixel.sixel_encode(pngbuf)
end

