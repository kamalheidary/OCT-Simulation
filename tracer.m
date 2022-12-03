function [Ur, Ut] = tracer(U, N, D, Ini)

NN = [N.N0 N.Ni];
ph = exp((NN(U.CL+1+U.d) > NN(U.CL+1))*1j*pi);

Ut.Ui = tforward(N, U).*U.Ui;
Ut.CL = U.CL+U.d; %passed wave's current layer
Ut.d = U.d; %passed wave's diraction no changed
Ut.f = 0;
Ut.R = U.R;
Ur.Ui = rforward(N, U).*U.Ui.*ph;
Ur.CL = U.CL;
Ur.d = -U.d; %reflected waves diraction
Ur.f = 0;
Ur.R = U.R+1;

if (Ur.R < Ini.rfl+1) && (Ur.CL ~= 0)
    Ur.Ui = Propagate_ASM(Ur.Ui, N.Ni(Ur.CL), D(Ur.CL), Ini);

else
    Ur.f = 1;
end

if (Ut.CL < length(N.Ni)) && (Ut.CL ~= 0)
    Ut.Ui = Propagate_ASM(Ut.Ui, N.Ni(Ut.CL), D(Ut.CL), Ini);
else
    Ut.f = 1;
end