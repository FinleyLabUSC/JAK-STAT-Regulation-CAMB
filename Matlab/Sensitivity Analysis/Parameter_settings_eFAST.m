global efast_var y_var_label numTimepoints

% Ryland Mortlock
% March 3rd, 2019

%% PARAMETER INITIALIZATION
%  set up max and mix matrices for three input variables
%  pmin and pmax has to be of the same length as the 
%  length of the input variables including the dummy.

% Load free parameters
free_vars = importdata('free_vars.csv');

param_bounds = zeros(length(free_vars),2);
param_bounds(:,1) = free_vars./100;
param_bounds(:,2) = free_vars.*100;


A1 = param_bounds(:,1);
A2 = param_bounds(:,2);
pmin = [log10(A1);            %Our parameters
        log10(0.001)];        %Dummy variable
pmax = [log10(A2);                
        log10(100)];
%% Number of timepoints
%%% update here and in the simulation file
numTimepoints = 12; %%% UPDATE TO INCLUDE THE TOTAL NUMBER OF TIMEPOINTS FOR WHICH YOU HAVE DATA
    
%% Input  Labels

% Load param names
efast_var = table2cell(readtable('free_var_names.csv','ReadVariableNames',false))';

%% Outputs from the model

% Load eFast output names (predicted conc.s)
y_var_label = table2cell(readtable('predicted_var_names.csv','ReadVariableNames',false))';