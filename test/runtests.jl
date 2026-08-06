using Test
using ShowDOT


@testset "Show" begin
    dotstr = """
    digraph G {
    rankdir = LR;
    layout = dot;
    subgraph cluster_0 {
        style=filled;
        color=lightgrey;
        node [style=filled,color=white];
        a0 -> a1 -> a2 -> a3;
        label = "process #1";
    }

    subgraph cluster_1 {
        node [style=filled];
        b0 -> b1 -> b2 -> b3;
        label = "process #2";
        color=blue
    }

    start -> a0; a1 -> b3; a3 -> a0;
    start -> b0; b2 -> a3; a3 -> end; b3 -> end;
    start [shape=Mdiamond];
    end [shape=Msquare];
    }
    """

    @test tshow(dotstr) isa Nothing
    @test pshow(dotstr) isa Docs.HTML{String}
end

