function U = Propagate_ASM(U0,n, Dz,Ini) 
H = exp(1j*n*Dz*2*pi/Ini.lambda); %transfer function
U = H.*U0; 