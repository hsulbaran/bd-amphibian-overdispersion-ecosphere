%% Environmental drivers: pluviosity & temperature derived functions
T = linspace(0,220,2201);  % 0:0.1:220
[PLUV,TEMP,aH_curve,rH_curve] = env_drivers(T);
COL = colors();

f1 = figure('Position',[100 100 1400 800]);
subplot(2,1,1); plot(T,PLUV,'LineWidth',3,'Color',COL.red);
ylabel('Pluviosity'); xlabel('Time t (weeks)'); grid on; box on; title('A');
subplot(2,1,2); plot(T,aH_curve,'LineWidth',3,'Color',COL.blue_light);
ylabel('Fecundity a_H(t)'); xlabel('Time t (weeks)'); grid on; box on; title('B');
if ~exist('output/figures','dir'), mkdir('output/figures'); end
exportgraphics(f1,'output/figures/fig_env_pluv_aH.png','Resolution',300);
exportgraphics(f1,'output/figures/fig_env_pluv_aH.pdf');

f2 = figure('Position',[100 100 1400 800]);
subplot(2,1,1); plot(T,TEMP,'LineWidth',3,'Color',COL.green); ylim([0 30]);
ylabel('Temperature'); xlabel('Time t (weeks)'); grid on; box on; title('A');
subplot(2,1,2); plot(T,rH_curve,'LineWidth',3,'Color',COL.brown);
ylabel('Zoospore growth r_H(t)'); xlabel('Time t (weeks)'); grid on; box on; title('B');
exportgraphics(f2,'output/figures/fig_env_temp_rH.png','Resolution',300);
exportgraphics(f2,'output/figures/fig_env_temp_rH.pdf');
disp('Saved environmental figures.');
