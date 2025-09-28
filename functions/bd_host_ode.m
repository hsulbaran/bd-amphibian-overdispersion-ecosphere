function dxdt = bd_host_ode(t, x, params)
% Bd–amphibian ODE RHS with defaults and optional overrides via 'params' struct.

% ================= Defaults (weekly rates) =================
p.ah = 0.36;         % metamorphosis (tadpole -> adult)
p.bH = 0.085;        % adult natural mortality
p.bh = 0.85;         % tadpole natural mortality (max)
p.Kbh = 9.7e-04;     % density-dependence tadpoles
p.Kh  = 9.7e-04;     % density effect in metamorphosis term

p.alphaH = 1e-5;     % infection mortality adults
p.alphah = 1e-5;     % infection mortality tadpoles
p.lambdaH = 8e-1;    % shedding rate adults
p.lambdah = 8e-1;    % shedding rate tadpoles
p.muH = 7e-3;        % within-host death (adults)
p.muh = 7e-3;        % within-host death (tadpoles)
p.muZ = 0.80;        % reservoir loss

p.betaH = 0.0125;    % acquisition from reservoir (adults)
p.betah = 0.0125;    % acquisition from reservoir (tadpoles)

p.phiH = 69e-4;      % aggregation adults
p.phih = 69e-4;      % aggregation tadpoles

% Environment & derived rates
p.tmax=27; p.tmin=4; p.plumax=200; p.plumin=10;
p.S = 75;
p.aHmin = 3.8; p.aHmax = 48.0;
p.rHmin = 0.0; p.rHmax = 10.0;
p.rhmin = 0.0; p.rhmax = 10.0;

% =============== Override with params if provided ===============
if nargin >= 3 && ~isempty(params)
  fields = fieldnames(params);
  for i=1:numel(fields)
    p.(fields{i}) = params.(fields{i});
  end
end

% =================== Environmental drivers ======================
pluv = p.plumax - ((p.plumax - p.plumin) * (1 - cos((2*pi/52) * (t - 1.2) + pi)) / 2);
temp = p.tmax   - ((p.tmax   - p.tmin  ) * (1 - cos((2*pi/52) * (t - 0.5) + pi)) / 2);

rh = ((p.rhmax - p.rhmin) / (p.tmax - p.tmin)) * (temp - p.tmin);
rH = ((p.rHmax - p.rHmin) / (p.tmax - p.tmin)) * (temp - p.tmin);

aH = p.aHmax - ((p.aHmax - p.aHmin) / (p.S - p.plumin)) * (pluv - p.plumin);
aH = max(aH,0);

% ========================== State ===============================
H = x(1); h = x(2); ZH = x(3); Zh = x(4); Z = x(5);

% ========================= ODEs =================================
dxdt = zeros(5,1);
dxdt(1) = p.ah * exp(-p.Kh * h) * h - p.bH * H - p.alphaH * ZH;
dxdt(2) = aH * H - (p.ah * exp(-p.Kh * h) + p.bh - p.bh * exp(-p.Kbh * h)) * h - p.alphah * Zh;
dxdt(3) = Z * p.betaH * H / (h + H) + ZH * (rH - p.bH - p.muH - p.alphaH * (1 + ZH/H * (p.phiH + 1) / p.phiH));
dxdt(4) = Z * p.betah * h / (h + H) + Zh * (rh - p.ah * exp(-p.Kh * h) - p.bh + p.bh * exp(-p.Kbh * h) - p.muh - p.alphah * (1 + Zh/h * (p.phih + 1) / p.phih));
dxdt(5) = p.lambdaH * ZH + p.lambdah * Zh - Z * ( p.muZ + p.betaH * H / (h + H) + p.betah * h / (h + H));
end
