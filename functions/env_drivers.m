function [PLUV,TEMP,aH_curve,rH_curve] = env_drivers(t)
% Environmental drivers and derived rates (weekly)
  tmax=27; tmin=4; plumax=200; plumin=10; S=75;
  aHmin=3.8; aHmax=48.0; rHmin=0.0; rHmax=10.0;

  PLUV = plumax - ((plumax - plumin) .* (1 - cos((2*pi/52) .* (t - 1.2) + pi)) ./ 2);
  TEMP = tmax   - ((tmax   - tmin  ) .* (1 - cos((2*pi/52) .* (t - 0.5) + pi)) ./ 2);

  aH_curve = max(aHmax - ((aHmax - aHmin)/(S - plumin)) * (PLUV - plumin), 0.0);
  rH_curve = ((rHmax - rHmin)/(tmax - tmin)) * (TEMP - tmin);
end
