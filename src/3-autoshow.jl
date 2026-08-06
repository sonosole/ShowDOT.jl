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
    autoshow(dotstr::AbstractString)

Automatically Show dot format string inside terminal or Pluto or IJulia notebooks.
It's up to you where to show the DOT file. 😁
!!! note 
    The terminal should support Sixel graphics.
"""
function autoshow(dotstr::String)
    showenv = detect_display_env()
    isequal(showenv, :pluto)    && return pshow(dotstr)
    isequal(showenv, :ijulia)   && return pshow(dotstr)
    isequal(showenv, :terminal) && return tshow(dotstr)
    isequal(showenv, :script)   && return tshow(dotstr)
    @info ":( Unknown display environment ..."
end

