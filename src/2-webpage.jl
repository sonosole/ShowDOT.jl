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
    svgbuf = take!(dotbuf)
    return Docs.HTML(String(svgbuf))
end


function svgshow(dotsrc::String)
    global dpi
    dotbuf = IOBuffer();
    dotstr = isdotfile(dotsrc) ? read(dotsrc, String) : dotsrc
    run(pipeline(`$dotexe -q -Tsvg -Gdpi=$dpi`,
                 stdin=IOBuffer(dotstr),
                 stdout=dotbuf));
    svgbuf = take!(dotbuf)
    return display(MIME("image/svg+xml"), String(svgbuf))
end
