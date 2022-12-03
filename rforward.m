function r = rforward(N, U)
NN = [N.N0 N.Ni];
r = abs((NN(U.CL+1) - NN(U.CL+1+U.d))/(NN(U.CL+U.d+1) + NN(U.CL+1)));