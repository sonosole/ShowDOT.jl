const dotexe = Graphviz_jll.dot();

function isdotfile(filepath::String)
    !isfile(filepath) && return false
    n = length(filepath)
    !isequal("dot", filepath[n-2:n]) && return false
    return true
end

