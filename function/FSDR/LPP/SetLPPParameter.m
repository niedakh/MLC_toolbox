function[param]=SetLPPParameter(~)
%setLPPParameter
param.dim   = '0.8*numF';
param.gamma = 1;
opt_w.k     = 10;
opt_w.NeighborMode = 'KNN';
opt_w.WeightMode = 'HeatKernel';
param.opt_w = opt_w;