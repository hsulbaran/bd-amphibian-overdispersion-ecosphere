function [t, H, h, ZH, Zh, Z, ZH_H, Zh_h] = integrate_model(T, x0, params)
% Integrate the Bd–amphibian ODE system.
% T: time vector, x0: initial state [H h ZH Zh Z], params: optional struct overrides
  if nargin < 1 || isempty(T), T = 0:0.1:2000; end
  if nargin < 2 || isempty(x0), x0 = [50 50 100 100 500]; end
  if nargin < 3, params = []; end
  opts = odeset('RelTol',1e-6,'AbsTol',1e-6);
  if isempty(params)
    [t, xa] = ode15s(@(t,x) bd_host_ode(t,x), T, x0, opts);
  else
    [t, xa] = ode15s(@(t,x) bd_host_ode(t,x,params), T, x0, opts);
  end
  H = xa(:,1); h = xa(:,2); ZH = xa(:,3); Zh = xa(:,4); Z = xa(:,5);
  ZH_H = (ZH'./H')'; Zh_h = (Zh'./h')';
end
