"""
    detect_display_env() -> Symbol
Return
+ :pluto      Pluto.jl notebook
+ :ijulia     IJulia(Jupyter notebook/lab)
+ :terminal   REPL terminal
+ :script     script mode
"""
function detect_display_env()
    isdefined(Main, :PlutoRunner) && return :pluto
    isdefined(Main, :IJulia) && return :ijulia
    if Base.isinteractive() && isa(stdout, Base.TTY)
        return :terminal
    end
    return :script
end


"""
    autoshow(dotsrc::AbstractString)

Automatically Show dot format string/file inside terminal or Pluto or IJulia notebooks.
It's up to you where to show the DOT file. 😁
!!! note 
    The terminal should support Sixel graphics.
"""
function autoshow(dotsrc::String)
    showenv = detect_display_env()
    isequal(showenv, :pluto)    && return pshow(dotsrc)
    isequal(showenv, :ijulia)   && return pshow(dotsrc)
    isequal(showenv, :terminal) && return tshow(dotsrc)
    isequal(showenv, :script)   && return tshow(dotsrc)
    @info ":( Unknown display environment ..."
end

