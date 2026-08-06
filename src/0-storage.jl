const FmtSet = Set{String}(
["svg",
 "svgz",
 "png",
 "pdf",
 "canon",
 "cmap",
 "cmapx",
 "cmapx_np",
 "dot",
 "dot_json",
 "eps",
 "fig",
 "gv",
 "imap",
 "imap_np",
 "ismap json",
 "json0",
 "mp",
 "pdf",
 "pic",
 "plain/plain-ext",
 "pov",
 "ps",
 "ps2",
 "tk",
 "vdx",
 "vml",
 "vmlz",
 "xdot",
 "xdot1.2",
 "xdot1.4",
 "xdot_json"]
)


"""
    saveas(path_to_file::String, dotstr::String)

Save into `path_to_file` via dot formatted string `dotstr`, format info shall be included in filename.
# Arguments
`path_to_file`: file's path and name, like `"/my/path/to/xxx.svg"` .
Supported types are svg, svgz, png, pdf, canon, cmap, cmapx, cmapx_np,
dot, dot_json, eps, fig, gv, imap, imap_np, ismap json, json0, mp, pdf, pic,
plain, plain-ext, pov, ps, ps2, tk, vdx, vml, vmlz, xdot, xdot1.2, xdot1.4, xdot_json
"""
function saveas(path_to_file::String, dotstr::String)
    path_suffix = split(path_to_file, ".", limit=2)

    if length(path_suffix) == 1
        error("The file name must have a format suffix like svg/png/pdf")
    end

    fmt = string(last(path_suffix))

    if fmt ∉ FmtSet
        error("""Typical supported formats are: svg, svgz, png, pdf
        Some minorities formats are:
            canon cmap cmapx cmapx_np dot dot_json eps fig gv 
            imap imap_np ismap json json0 mp pdf pic plain plain-ext 
            pov ps ps2 tk vdx vml vmlz xdot xdot1.2 xdot1.4 xdot_json""")
    end
    global dpi
    dotcmd = `$dotexe -q -T$fmt -Gdpi=$dpi -o $path_to_file`
    runme! = pipeline(IOBuffer(dotstr), dotcmd)
    run(runme!)
    return nothing
end


const shortfmts = """
    png(path_and_name_with_no_suffix::String, dotstr::String)
    svg(path_and_name_with_no_suffix::String, dotstr::String)
    pdf(path_and_name_with_no_suffix::String, dotstr::String)
Short ways to save dot formatted string as png or svg or pdf.
# Example
```julia
png("/path/until/name_with_no_suffix", my_dot_str) # dotstr saved as /path/until/name_with_no_suffix.png
svg("/path/until/name_with_no_suffix", my_dot_str) # dotstr saved as /path/until/name_with_no_suffix.svg
pdf("/path/until/name_with_no_suffix", my_dot_str) # dotstr saved as /path/until/name_with_no_suffix.pdf
```
"""

png(path2name::String, dotstr::String) = saveas(path2name * ".png", dotstr)
svg(path2name::String, dotstr::String) = saveas(path2name * ".svg", dotstr)
pdf(path2name::String, dotstr::String) = saveas(path2name * ".pdf", dotstr)

@doc shortfmts png
@doc shortfmts svg
@doc shortfmts pdf
