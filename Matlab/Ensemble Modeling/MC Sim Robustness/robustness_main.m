% Check robustness of MC sims which matched desired shape
% Ryland Mortlock
% 4/25/2020

% Load MC parameter values
MC_params = readtable('data/Parameter Sets Desired Shape.csv');
struct_vec = [1 3 4 5 6 7 8];
noise_vec = [0 0.0001 0.001 0.002 0.003 0.004 0.005 0.006 .007 0.008 0.009...
             0.01:0.01:0.99];

result_mat = zeros(length(struct_vec)+1,length(noise_vec));
result_mat(1,:) = noise_vec;

% Call the robustness function
tic
result_mat(2:end,:) = robustness_func(MC_params,struct_vec,noise_vec,100);
toc

save('cache/robustness_mat_combined.mat','result_mat')

