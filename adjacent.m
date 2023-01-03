clc
clear all
close all

n = input('nodes number: ');
A = zeros(n,n);

disp('Adjacency Matrix')
for i = 1:n
    for j = 1:n
        A(i,j) = input("Enter element for row " + i + " col " + j + ": ");
    end
end

G = graph(A);
G.plot()