clear all
close all
clc

s = [1, 3, 4, 4, 5];
t = [2, 2, 2, 3, 4];
G = digraph(s, t);

display(topologicalS(G));

function nodes = findNoIncomingNodes(G)
    nodes = [];
    for i = 1:height(G.Nodes)
        if indegree(G, findnode(G, i)) == 0
            nodes(end + 1) = findnode(G, i);
        end
    end
        
end


function sorted = topologicalS(G)
    sorted = [];
    noIncoming = findNoIncomingNodes(G);
    while ~isempty(noIncoming)
        sorted = [sorted noIncoming(1)];
        [~, nodes] = outedges(G, noIncoming(1));
        for i = 1:length(nodes)
            G = rmedge(G, findedge(G, noIncoming(1), nodes(i)));
            if indegree(G, nodes(i)) == 0
                noIncoming(end + 1) = nodes(i);
            end
        end
        noIncoming(1) = [];
    end
    
    [s, ~] = findedge(G);
    if ~isempty(s)
        sorted = [];
        disp("There is at least one circuit in this Graph, Try another one");
    end
        
end