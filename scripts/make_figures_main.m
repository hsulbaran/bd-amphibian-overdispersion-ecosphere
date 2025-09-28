%% Reproduce main panels (A–D): H, ZH/H, h, Zh/h
load('output/sims/baseline.mat','t','H','h','ZH_H','Zh_h');
COL = colors();

f = figure('Position',[100 100 1400 900]);

subplot(2,2,1); plot(t,H,'LineWidth',3,'Color',COL.blue_dark);
ylabel('Adults H(t)'); xlabel('Time t (weeks)'); grid on; box on; title('A');

subplot(2,2,2); plot(t,ZH_H,'LineWidth',3,'Color',COL.green);
ylabel('Average burden Z_H/H'); xlabel('Time t (weeks)'); grid on; box on; title('B');

subplot(2,2,3); plot(t,h,'LineWidth',3,'Color',COL.orange);
ylabel('Tadpoles h(t)'); xlabel('Time t (weeks)'); grid on; box on; title('C');

subplot(2,2,4); plot(t,Zh_h,'LineWidth',3,'Color',COL.magenta);
ylabel('Average burden Z_h/h'); xlabel('Time t (weeks)'); grid on; box on; title('D');

sgtitle('Modeling of amphibian–Bd dynamics');

if ~exist('output/figures','dir'), mkdir('output/figures'); end
exportgraphics(f,'output/figures/fig_main.png','Resolution',300);
exportgraphics(f,'output/figures/fig_main.pdf');
disp('Saved output/figures/fig_main.(png|pdf)');
