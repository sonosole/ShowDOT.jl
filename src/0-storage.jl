const FmtSet = Set{String}(
["svg", "svgz", "svg_inline",
 "png",
 "pdf",
 "canon", "cmap", "cmapx", "cmapx_np",
 "dot", "dot_json",
 "eps",
 "fig",
 "gv",
 "imap", "imap_np", "ismap", 
 "json", "json0",
 "kitty", "kittyz",
 "pdf", "pic", "plain", "plain-ext",
 "pov", "ps", "ps2",
 "tk",
 "vt", "vt-24bit", "vt-4up", "vt-6up", "vt-8up", "vt-8up2",
 "xdot", "xdot1.2", "xdot1.4", "xdot_json"]
)


"""
    saveas(path_to_file::String, dotsrc::String)

Save into `path_to_file` via dot formatted string/file `dotsrc`, format info shall be included in filename.
# Arguments
`path_to_file`: file's path and name, like `"/my/path/to/xxx.svg"` .
Supported types are canon cmap cmapx cmapx_np dot dot_json eps 
fig gv imap imap_np ismap json json0 kitty kittyz pdf pic plain 
plain-ext png pov ps ps2 svg svg_inline svgz tk vt vt-24bit vt-4up 
vt-6up vt-8up vt-8up2 xdot xdot1.2 xdot1.4 xdot_json
"""
function saveas(path_to_file::String, dotsrc::String)
    path_suffix = split(path_to_file, ".", limit=2)

    if length(path_suffix) == 1
        error("The file name must have a format suffix like svg/png/pdf")
    end

    fmt = string(last(path_suffix))

    if fmt ∉ FmtSet
        error("""Typical supported formats are: svg, svgz, png, pdf
        Some minorities formats are:
            canon cmap cmapx cmapx_np dot dot_json eps 
            fig gv imap imap_np ismap json json0 kitty kittyz pdf pic plain 
            plain-ext png pov ps ps2 svg svg_inline svgz tk vt vt-24bit vt-4up 
            vt-6up vt-8up vt-8up2 xdot xdot1.2 xdot1.4 xdot_json""")
    end
    global dpi
    dotstr = isdotfile(dotsrc) ? read(dotsrc, String) : dotsrc
    dotcmd = `$dotexe -q -T$fmt -Gdpi=$dpi -o $path_to_file`
    runme! = pipeline(IOBuffer(dotstr), dotcmd)
    run(runme!)
    return nothing
end


const shortfmts = """
    png(path_and_name_with_no_suffix::String, dotsrc::String)
    svg(path_and_name_with_no_suffix::String, dotsrc::String)
    pdf(path_and_name_with_no_suffix::String, dotsrc::String)
Short ways to save dot formatted string as png or svg or pdf.
# Example
```julia
my_dotstr_or_dotfile = "digraph {a->b}" # or "/path/to/my.dot"
png("/path/until/name_with_no_suffix", my_dotstr_or_dotfile) # dotsrc saved as /path/until/name_with_no_suffix.png
svg("/path/until/name_with_no_suffix", my_dotstr_or_dotfile) # dotsrc saved as /path/until/name_with_no_suffix.svg
pdf("/path/until/name_with_no_suffix", my_dotstr_or_dotfile) # dotsrc saved as /path/until/name_with_no_suffix.pdf
```
"""

png(path2name::String, dotsrc::String) = saveas(path2name * ".png", dotsrc)
svg(path2name::String, dotsrc::String) = saveas(path2name * ".svg", dotsrc)
pdf(path2name::String, dotsrc::String) = saveas(path2name * ".pdf", dotsrc)

@doc shortfmts png
@doc shortfmts svg
@doc shortfmts pdf


function testsaves(file_with_no_suffix::String)
    dotstr = "digraph {a->b}"
    for fmt ∈ FmtSet
        try
            saveas(file_with_no_suffix * ".$fmt", dotstr)
        catch
            @info "$fmt not supported :|"
        end
    end
    return nothing
end

