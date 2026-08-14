"""
    vt(dotsrc::String)
Show dot format string/file inside terminal.
"""
function vt(dotsrc::String)
    isdotfile(dotsrc) && return read(dotsrc, String)
    dotbuf = IOBuffer();
    run(pipeline(`$dotexe -q -Tvt -Gdpi=$dpi`,
                 stdin=IOBuffer(dotsrc),
                 stdout=dotbuf));
    tmpbuf = take!(dotbuf)
    return print(string(prod(Char.(tmpbuf))))
end


"""
    vt4up(dotsrc::String)
Show dot format string/file inside terminal.
"""
function vt4up(dotsrc::String)
    isdotfile(dotsrc) && return read(dotsrc, String)
    dotbuf = IOBuffer();
    run(pipeline(`$dotexe -q -Tvt-4up -Gdpi=$dpi`,
                 stdin=IOBuffer(dotsrc),
                 stdout=dotbuf));
    tmpbuf = take!(dotbuf)
    return print(string(prod(Char.(tmpbuf))))
end


"""
    vt6up(dotsrc::String)
Show dot format string/file inside terminal.
"""
function vt6up(dotsrc::String)
    isdotfile(dotsrc) && return read(dotsrc, String)
    dotbuf = IOBuffer();
    run(pipeline(`$dotexe -q -Tvt-6up -Gdpi=$dpi`,
                 stdin=IOBuffer(dotsrc),
                 stdout=dotbuf));
    tmpbuf = take!(dotbuf)
    return print(string(prod(Char.(tmpbuf))))
end


"""
    vt8up(dotsrc::String)
Show dot format string/file inside terminal.
"""
function vt8up(dotsrc::String)
    isdotfile(dotsrc) && return read(dotsrc, String)
    dotbuf = IOBuffer();
    run(pipeline(`$dotexe -q -Tvt-8up -Gdpi=$dpi`,
                 stdin=IOBuffer(dotsrc),
                 stdout=dotbuf));
    tmpbuf = take!(dotbuf)
    return print(string(prod(Char.(tmpbuf))))
end


"""
    vt24bit(dotsrc::String)
Show dot format string/file inside terminal.
"""
function vt24bit(dotsrc::String)
    isdotfile(dotsrc) && return read(dotsrc, String)
    dotbuf = IOBuffer();
    run(pipeline(`$dotexe -q -Tvt-24bit -Gdpi=$dpi`,
                 stdin=IOBuffer(dotsrc),
                 stdout=dotbuf));
    tmpbuf = take!(dotbuf)
    return print(string(prod(Char.(tmpbuf))))
end


