function U_S = OCTsimulator( U, N, Di, Ini )
%initial value for incoming wave
U(1).Ui = U.Ui;
U_S = zeros(size(U.Ui));
U(1).R = 0;  %number of reflection
U(1).d = 1;  %direction of  wave
U(1).f = 0;  %flag
U(1).CL = 0; %Current Layer
CC = 1;
while ~isempty(CC)
    U(CC(1)).f = 1;
    U(CC).Ui;
    [U(numel(U)+1), U(numel(U)+1)] = tracer(U(CC(1)), N, Di, Ini);
    CC = find(cell2mat({U(:).f})==0);
end
for i = 1: length(U)
    if U(i).CL ==0 && U(i).d == -1
        U_S = U(i).Ui + U_S; %sum of reflected waves
    end
end