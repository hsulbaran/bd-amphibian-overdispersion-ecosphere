%% Simple scenarios figure (optional)
% Scenario 1: alphah = 0 (tadpole infection mortality off)
T = 0:0.1:220; x0 = [50 50 100 100 500];
params1.alphah = 0.0;
[t1,H1,h1,ZH1,Zh1,Z1,ZH_H1,Zh_h1] = integrate_model(T,x0,params1);

% Scenario 2: moderate overdispersion phiH=phih=0.1
params2.phih = 0.1; params2.phiH = 0.1;
[t2,H2,h2,ZH2,Zh2,Z2,ZH_H2,Zh_h2] = integrate_model(T,x0,params2);

COL = colors();
f = figure('Position',[100 100 1400 900]);

subplot(2,2,1);
yyaxis left;  plot(t1,H1,'LineWidth',3,'Color',COL.blue_dark);
ylabel('Adults H(t)');
yyaxis right; plot(t1,h1,'LineWidth',3,'Color',COL.orange);
ylabel('Tadpoles h(t)'); xlabel('Time (weeks)'); title('Scenario 1: \alpha_h=0'); grid on;

subplot(2,2,2);
yyaxis left;  semilogy(t1,max(ZH_H1,1e-10),'LineWidth',3,'Color',COL.green);
ylabel('Z_H/H');
yyaxis right; semilogy(t1,max(Zh_h1,1e-10),'LineWidth',3,'Color',COL.magenta);
ylabel('Z_h/h'); xlabel('Time (weeks)'); title('Scenario 1 burdens'); grid on;

subplot(2,2,3);
yyaxis left;  plot(t2,H2,'LineWidth',3,'Color',COL.blue_dark);
ylabel('Adults H(t)');
yyaxis right; plot(t2,h2,'LineWidth',3,'Color',COL.orange);
ylabel('Tadpoles h(t)'); xlabel('Time (weeks)'); title('Scenario 2: \varphi=0.1'); grid on;

subplot(2,2,4);
yyaxis left;  semilogy(t2,max(ZH_H2,1e-10),'LineWidth',3,'Color',COL.green);
ylabel('Z_H/H');
yyaxis right; semilogy(t2,max(Zh_h2,1e-10),'LineWidth',3,'Color',COL.magenta);
ylabel('Z_h/h'); xlabel('Time (weeks)'); title('Scenario 2 burdens'); grid on;

if ~exist('output/figures','dir'), mkdir('output/figures'); end
exportgraphics(f,'output/figures/fig_scenarios.png','Resolution',300);
exportgraphics(f,'output/figures/fig_scenarios.pdf');
disp('Saved scenarios figure.');
