function [H, ZH_H] = func_phiH_betaH(phiH, betaH)
% Run the model for given (phiH, betaH) and return H(t) and ZH/H(t)

opts = odeset('RelTol',1e-4,'AbsTol',1e-4,'Stats','off');
T = 0:1:2000;
x0 = [50 50 100 100 500];

params.phiH = phiH;
params.betaH = betaH;

[t, xa] = ode15s(@(t,x) bd_host_ode(t,x,params), T, x0, opts);
H    = xa(:,1);
ZH_H = (xa(:,3)' ./ xa(:,1)')';
end
