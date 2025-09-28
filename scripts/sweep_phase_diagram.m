%% Phase diagram over (phi_H, beta_H)
COL = colors();
cmap = [COL.red; COL.green; COL.blue_dark];  % extinction; Bd fails; coexistence

phiH  = linspace(1e-14,1,150);
betaH = linspace(1e-14,1,150);
[Lb, Lp] = deal(length(betaH), length(phiH));
[PhiH,BetaH] = meshgrid(phiH,betaH);
PhiH = PhiH(:); BetaH = BetaH(:);

labels = zeros(size(PhiH));
useParallel = true; try, if isempty(gcp('nocreate')), parpool; end, catch, useParallel=false; end

if useParallel
  parfor k = 1:numel(PhiH)
    [H, ZH_H] = func_phiH_betaH(PhiH(k), BetaH(k));
    labels(k) = classify_outcome(H,ZH_H);
  end
else
  for k = 1:numel(PhiH)
    [H, ZH_H] = func_phiH_betaH(PhiH(k), BetaH(k));
    labels(k) = classify_outcome(H,ZH_H);
  end
end

M = reshape(labels, Lb, Lp);

figure('Position',[100 100 1400 600]);
subplot(1,2,1);
pcolor(phiH,betaH,M); shading flat; colormap(cmap); caxis([0.5 45.5]);
cb = colorbar; cb.Ticks=[1 20 45]; cb.TickLabels={'Host extinction','Bd fails','Bd–host coexistence'};
xlabel('\varphi_H'); ylabel('\beta_H'); title('B1'); grid on;

subplot(1,2,2);
idx = phiH <= 0.02; pz = phiH(idx); Mz = M(:,idx);
pcolor(pz,betaH,Mz); shading flat; colormap(cmap); caxis([0.5 45.5]);
cb2 = colorbar; cb2.Ticks=[1 20 45]; cb2.TickLabels={'Host extinction','Bd fails','Bd–host coexistence'};
xlabel('\varphi_H'); ylabel('\beta_H'); title('B2'); grid on;

if ~exist('output/figures','dir'), mkdir('output/figures'); end
exportgraphics(gcf,'output/figures/fig_phase_diagram.png','Resolution',300);
exportgraphics(gcf,'output/figures/fig_phase_diagram.pdf');

function lab = classify_outcome(H,ZH_H)
  if mean(H(end-10:end)) > 2
    if mean(ZH_H(end-10:end)) > 10, lab = 45; else, lab = 20; end
  else
    lab = 1;
  end
end
