"""
    pshow(dotsrc::String)

Show dot format string/file in web page, e.g. IJulia, Pluto
# Example
```julia
julia> pshow("digraph {a->b}")
julia> pshow("/path/to/my.dot")
```
# Working pipeline
dotsrc ─►  dot engine ─►  in-momery svg ─►  HTML rendering
"""
function pshow(dotsrc::String)
    global dpi
    dotbuf = IOBuffer();
    dotstr = isdotfile(dotsrc) ? read(dotsrc, String) : dotsrc
    run(pipeline(`$dotexe -q -Tsvg -Gdpi=$dpi`,
                 stdin=IOBuffer(dotstr),
                 stdout=dotbuf));
    svgbuf = String(take!(dotbuf))
    return Docs.HTML(svgbuf)
end

