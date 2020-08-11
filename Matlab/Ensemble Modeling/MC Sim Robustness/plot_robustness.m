% Plot results of robustness check
% Ryland Mortlock
% 4/25/2020

% Load results
robustness_mat = importdata('cache/robustness_mat_combined.mat');

% Set noise vec
noise_vec = robustness_mat(1,:);
result_mat = robustness_mat(2:end,:);

% Plot 
figure(1)
h = plot(noise_vec,result_mat,'-o','Linewidth',2,'MarkerSize',3);
set(h, {'MarkerFaceColor'}, get(h,'Color'));
legend({'Structure 1',
    'Structure 3',
    'Structure 4',
    'Structure 5',
    'Structure 6',
    'Structure 7',
    'Structure 8'}, 'Location','northeastoutside')
xlabel('Noise factor')
ylabel('% simulations matching desired shape')

% Aesthetics
box off;
ax = gca;
ax.LineWidth = 3;
ax.FontSize = 12;
set(gcf,'color','w');
ax.TickDir = 'out';
ax.XGrid = 'off';
ax.YGrid = 'off';
xt = get(gca, 'XTick');
set(gca, 'FontWeight', 'Bold')
legend boxoff 
set(gcf,'PaperUnits', 'Inches', 'PaperPosition', [0 0 6 4])

% Save it
saveas(gcf,'figures/robustness_plot.png')

% Plot on log scale
figure(2)
h = semilogx(noise_vec,result_mat,'-o','Linewidth',2,'MarkerSize',3);
set(h, {'MarkerFaceColor'}, get(h,'Color'));
xlim([1E-3 1E0])
legend({'Structure 1',
    'Structure 3',
    'Structure 4',
    'Structure 5',
    'Structure 6',
    'Structure 7',
    'Structure 8'}, 'Location','northeastoutside')
xlabel('Noise factor','FontWeight','bold','Color','k')
ylabel('% simulations matching desired shape','FontWeight','bold','Color','k')

% Aesthetics
box off;
ax = gca;
ax.LineWidth = 3;
ax.FontSize = 12;
set(gcf,'color','w');
ax.TickDir = 'out';
ax.XGrid = 'off';
ax.YGrid = 'off';
xt = get(gca, 'XTick');
set(gca, 'FontWeight', 'Bold')
legend boxoff 
set(gcf,'PaperUnits', 'Inches', 'PaperPosition', [0 0 6 4])

% Save it
saveas(gcf,'figures/robustness_plot_semilog.png')

