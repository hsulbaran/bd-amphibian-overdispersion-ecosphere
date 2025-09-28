%% Baseline integration (2000 weeks) and save outputs
addpath(genpath('functions'));
opts = odeset('RelTol',1e-6,'AbsTol',1e-6,'Stats','off');
T = 0:0.1:2000;           % weeks
x0 = [50 50 100 100 500]; % [H h ZH Zh Z]

% Integrate using helper
[t, H, h, ZH, Zh, Z, ZH_H, Zh_h] = integrate_model(T, x0);

% Save
if ~exist('output/sims','dir'), mkdir('output/sims'); end
save('output/sims/baseline.mat','t','H','h','ZH','Zh','Z','ZH_H','Zh_h');
disp('Saved baseline outputs to output/sims/baseline.mat');
