"""
    pshow(dotstr::String)

Show dot format string in web page, e.g. IJulia, Pluto

# Working pipeline
dotstr ─►  dot engine ─►  in-momery svg ─►  HTML rendering
"""
function pshow(dotstr::String)
    global dpi
    dotbuf = IOBuffer();
    run(pipeline(`$dotexe -q -Tsvg -Gdpi=$dpi`,
                 stdin=IOBuffer(dotstr),
                 stdout=dotbuf));
    svgbuf = String(take!(dotbuf))
    return Docs.HTML(svgbuf)
end

