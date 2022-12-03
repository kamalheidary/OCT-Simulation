function t = tforward(N, U)
NN = [N.N0 N.Ni];
t = 2*(NN(U.CL+1))/(NN(U.CL+U.d+1) + NN(U.CL+1));