clear all
close all
clc


s = [1, 1, 1, 1, 2, 2, 2, 5, 6];
t = [2, 3, 4, 6, 3, 5, 7, 6, 7];

G = graph(s, t);
plot(G);
printEulerTour(G);


function isValid = isValidNextEdge(u, v, G)
    if degree(G, u) == 1
        isValid = true;
    elseif isBridge(u, v, G)
        isValid = false;
    else
        isValid = true;
    end
end

function bridge = isBridge(u, v, G)
    G = rmedge(G, u, v);
    P = shortestpath(G, u, v);
    if isempty(P)
        bridge = true;
    else
        bridge = false;
    end
end

function adjacents = findAdjacents(u, G)
    n = numnodes(G);
    adjacents = [];
    for v = 1:n
        if length(shortestpath(G, u, v)) == 2
            adjacents(end + 1) = v;
        end
    end
end
        
function  printEulerUtil(u, G)
    adjacents = findAdjacents(u, G);
    l = length(adjacents);
    for i = 1:l
        v = adjacents(i);
        if isValidNextEdge(u, v, G)
            display("" + u + " ---> " + v);
            H = rmedge(G, u, v);
            printEulerUtil(v, H);
            break
        end
    end
end

function printEulerTour(G)
    n = numnodes(G);
    u = 1;
    for i = 1:n
        deg = degree(G, i);
        if  ~mod(deg, 2) == 0
            u = i;
            break
        end
    end
    printEulerUtil(u, G);
end



