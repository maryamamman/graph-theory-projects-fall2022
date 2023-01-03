clear all
close all
clc

s = [1, 1, 1, 1, 2, 2, 2, 3, 3, 4];
t = [2, 3, 4, 5, 3, 4, 5, 4, 5, 5];
weights = [2, 8, 4, 6, 7, 3, 6, 9, 8, 5];

G = graph(s, t, weights);
MST = MinSpanningTree(G);
plot(MST ,'EdgeLabel', MST.Edges.Weight);


function [sortedWeights, sortedsOut, sortedtOut] = sortEdges(G)
    sortedWeights = sort(G.Edges.Weight);
    [sOut,tOut] = findedge(G);
    sortedsOut = [];
    sortedtOut = [];
    for i = 1:height(G.Edges)
        for j = 1:height(G.Edges)
            if G.Edges.Weight(findedge(G,sOut(j),tOut(j))) == sortedWeights(i)
                sortedsOut(end + 1) = sOut(j);
                sortedtOut(end + 1) = tOut(j);
                break
            end
        end
    end
end

function ciruit = makesCircuit(T, u, v)
    if (length(allpaths(T, u, v)) == 1)
        ciruit = false;
    else 
        ciruit = true;
    end
end

function MST = MinSpanningTree(G)
    [sOut,tOut] = findedge(G);
    [sortedWeights, sortedsOut, sortedtOut] = sortEdges(G);
    
    MST = rmedge(G, sOut, tOut);
    for i = 1:length(sortedsOut)
        MST = addedge(MST, sortedsOut(i), sortedtOut(i), sortedWeights(i));
        if makesCircuit(MST, sortedsOut(i), sortedtOut(i))
            MST = rmedge(MST, sortedsOut(i), sortedtOut(i));
        end
    end
end