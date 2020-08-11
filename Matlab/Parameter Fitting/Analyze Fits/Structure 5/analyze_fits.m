% Ryland Mortlock
% June 4th, 2020

% Analyze fitting results from Bayesian estimation

% INPUTS
    % bayes_estimates.mat: results from bayesian fitting

% OUTPUTS
    % PART 1:
        % Plot of error vs iter # to make sure fitting went okay
        % histogram of final error value for each fit to decide how many
            % fits to keep downstream
            
     % PART 2:
        % Trace plot of each parameter value versus iteration # 
        % Histogram of the posterior for each parameter
        % free_params.mat which contains free parameter values 
        % error_values.txt which contains error values

close all
clearvars

%% PART 1: Look at results and decide how many fits to move forward with

% Load param names
param_names =  ["k3",
                "k5",
          %      "deg-ratio",
                "k8A",
                "mult8B",
                "mult8AB",
                "k9",
                "k11",
                "k-13",
                "k14A",
                "mult14B",
                "mult14AB",
                "k15",
                "k16",
                "k17outA",
                "mult17B",
                "k19",
                "k21",
                "k22",
                "k23",
                "k24",
                "k25a",
                "k27",
                "k28",
                "totalSTAT",
                "k30a",
                "RJ",
                "SHP2",
                "PPX",
                "PPN",
                "k34",
                "BCL",
                "k4"];

% Load Bayes fitting result
bayes = load('data/bayes_estimates.mat');
err = bayes.err;
estimates = bayes.estimates;
numFits = length(err);
numParams = size(estimates{1},1);


figure(1)
% Error elbow plot
for i = 1:numFits
    plot(err{i})
    hold all
end
ylabel('error');
xlabel('iteration #');

% histogram of final error value from each fit
ending_error = zeros(numFits,1);
for i = 1:numFits
    ending_error(i) = err{i}(end);
end
figure(2)
subplot(1,2,1)
histogram(ending_error,20)
xlabel('error')

subplot(1,2,2)
sortError = sortrows(ending_error); 
plot(sortError)


%% PART 2: Export parameter sets to include
num_param_set = 1; % Top x param sets to include (change based on cutoff value from histogram of error values)
num_iter = 1000; % Last y iterations to keep to estimate posterior

% Get median error of each run within last y iterations
median_errors = [zeros(1,numFits); 1:numFits]'; % first column is pre-allocated, second column is index
for i = 1:numFits
    median_errors(i,1) = median(err{i}((end-num_iter+1):end));
end

% Sort ascending
sorted_errors = sortrows(median_errors); 

% Parameter sets to be used
my_param_sets = sorted_errors(1:num_param_set,2);

% trace plot of each parameter in my param sets
for j = 1:numParams
f = figure('visible','off');
	for i = 1% 1:num_param_set
        my_set = my_param_sets(i);
		f = plot(estimates{my_set}(j,:));
		hold all
	end
ylabel(param_names(j),'FontSize',16,'FontWeight','bold','Color','k')
xlabel('iteration #','FontSize',16,'FontWeight','bold','Color','k')

box off;
ax = gca;
ax.LineWidth = 2;
ax.FontSize = 16;
ax.FontWeight = 'bold';
set(gcf,'color','w');
ax.TickDir = 'out';

saveas(f,strcat('figures/trace_plots/',param_names(j),'_trace_plot.png'))
end

% Build matrix of last y iterations from each chosen param set
free_params = zeros(num_iter*num_param_set,numParams); % pre-allocate for first one
count_index = 0;
for i = 1:num_param_set
    my_set = my_param_sets(i);
    free_params(count_index+1:num_iter*i,:) = (estimates{my_set}(:,(end-num_iter+1):end))';
    count_index = num_iter*i;
end

% Print histograms of the posterior for each parameter
for j = 1:numParams
f = figure('visible','off');
f = histogram(free_params(:,j));

xlabel(param_names(j),'FontSize',16,'FontWeight','bold','Color','k')
ylabel('counts','FontSize',16,'FontWeight','bold','Color','k')

box off;
ax = gca;
ax.LineWidth = 2;
ax.FontSize = 16;
ax.FontWeight = 'bold';
set(gcf,'color','w');
ax.TickDir = 'out';

saveas(f,strcat('figures/posterior_histograms/',param_names(j),'_posterior_histogram.png'))
end

% Write param values and median errors to .mat files
save('output/free_params.mat','free_params')
dlmwrite('output/error_values.txt',median_errors(my_param_sets,1))

%% Export error values and error histogram
num_fits = 40;
num_iter = 1000; 

% Get median error of each run within last y iterations
median_errors = [zeros(1,numFits); 1:numFits]'; % first column is pre-allocated, second column is index
for i = 1:numFits
    median_errors(i,1) = median(err{i}((end-num_iter+1):end));
end

% Error histogram and elbow plot for all fits
figure()
subplot(1,2,1)
histogram(median_errors(:,1),20)
xlabel('error','FontSize',12,'FontWeight','bold','Color','k')
ylabel('count','FontSize',12,'FontWeight','bold','Color','k')

% Format
box off;
ax = gca;
ax.LineWidth = 2;
ax.FontSize = 12;
ax.FontWeight = 'bold';
set(gcf,'color','w');
ax.TickDir = 'out';

subplot(1,2,2)
sortError = sortrows(median_errors(:,1)); 
plot(sortError,'LineWidth',3)
xlabel('fits (ranked by lowest error)','FontSize',12,'FontWeight','bold','Color','k')
ylabel('error','FontSize',12,'FontWeight','bold','Color','k')

% Format
box off;
ax = gca;
ax.LineWidth = 2;
ax.FontSize = 12;
ax.FontWeight = 'bold';
set(gcf,'color','w');
ax.TickDir = 'out';

% Set size of figure
width = 10;
height = 4;
set(gcf,'units','inches','position',[0,0,width,height])

saveas(gcf, 'figures/error_histogram.png')


% Export median error values for top X independent fits
% Sort ascending
sorted_errors = sortrows(median_errors); 
file_name = strcat("output/error_values_top_",num2str(num_fits),".txt");
dlmwrite(file_name,sorted_errors(1:num_fits,1))
