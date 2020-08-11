% Ryland Mortlock
% July 22nd, 2019

% Run sensitivity analysis


% First order and total effect indices for a given
% model computed with Extended Fourier Amplitude
% Sensitivity Test (EFAST).
% Andrea Saltelli, Stefano Tarantola and Karen Chan.
% 1999. % "A quantitative model-independent method for global
% sensitivity analysis of model output". % Technometrics 41:3956

% OUTPUT
    % SI[] : first order sensitivity indices
    % STI[] : total effect sensitivity indices
    % Other used variables/constants:
    % OM[] : vector of k frequencies
    % OMi : frequency for the group of interest
    % OMCI[] : set of freq. used for the compl. group
    % X[] : parameter combination rank matrix
    % AC[],BC[]: fourier coefficients
    % FI[] : random phase shift
    % V : total output variance (for each curve)
    % VI : partial var. of par. i (for each curve)
    % VCI : part. var. of the compl. set of par...
    % AV : total variance in the time domain
    % AVI : partial variance of par. i
    % AVCI : part. var. of the compl. set of par.
    % Y[] : model output
clc
clear;
close all;
tic
global efast_var y_var_label numTimepoints
% poolobj = gcp;
% addAttachedFiles(poolobj,{'driver_eFAST',...
%     'Parameter_settings_eFAST.m',...
%     'CVmethod.m','efast_sd.m','efast_ttest.m',...
%     'parameterdist.m','core_file_new.m','SETFREQ.m'})

%% PARAMETERS AND ODE SETTINGS (they are included in the following file)
Parameter_settings_eFAST;

%% INPUT
NR = 3; %: no. of search curves - RESAMPLING
k = length(efast_var); % # of input factors (parameters varied) + dummy parameter
NS = 200; % # of samples per search curve
wantedN=NS*k*NR; % wanted no. of sample points

MI = 4; %: maximum number of fourier coefficients
% that may be retained in calculating the partial
% variances without interferences between the
% assigned frequencies
% Computation of the frequency for the group
% of interest OMi and the # of sample points NS (here N=NS)
OMi = floor(((wantedN/NR)-1)/(2*MI)/k);
NS = 2*MI*OMi+1;
if(NS*NR < 65)
    fprintf(['Error: sample size must be >= ' ...
        '65 per factor.\n']);
    return;
end
diary my_data.txt
%% Pre-allocation of the output matrix Y
% Y will save only the points of interest specified in the vector time_points

% Pre-allocate the size of the matrix that will hold all of the model
% predictions for each parameter set
Y(NS,numTimepoints,length(y_var_label),length(efast_var),NR)=0;  

% Loop over k parameters (input factors)
for i=1:k % i=# of replications (or blocks)
    % Algorithm for selecting the set of frequencies.
    % OMci(i), i=1:k-1, contains the set of frequencies
    % to be used by the complementary group.
    OMci = SETFREQ(k,OMi/2/MI,i);
    % Loop over the NR search curves.
    for L=1:NR
        % Setting the vector of frequencies OM
        % for the k parameters
        cj = 1;
        for j=1:k
            if(j==i)
                % For the parameter (factor) of interest
                OM(i) = OMi;
            else
                % For the complementary group.
                OM(j) = OMci(cj);
                cj = cj+1;
            end
        end
        % Setting the relation between the scalar
        % variable S and the coordinates
        % {X(1),X(2),...X(k)} of each sample point.
        FI = rand(1,k)*2*pi; % random phase shift
        S_VEC = pi*(2*(1:NS)-NS-1)/NS;
        OM_VEC = OM(1:k);
        FI_MAT = FI(ones(NS,1),1:k)';
        ANGLE = OM_VEC'*S_VEC+FI_MAT;
        X(:,:,i,L) = 0.5+asin(sin(ANGLE'))/pi; % between 0 and 1
        % Transform distributions from standard uniform to general.
        X(:,:,i,L) = parameterdist(X(:,:,i,L),pmin,pmax,[],[],NS,'unif'); %%this is what assigns 'our' values rather than 0:1 dist
        % Do the NS model evaluations.
        %paramsdidnotwork = zeros(NS,length(pmin));
        parfor run_num=1:NS
            % This gives the output for
            % keeps track of [parameter run NR]
            [i run_num L]
            % ODE system file
            % @pathway_ode.m
            % ODE solver call t,y,params,X,run_num
            try
               [t,y] = driver_eFAST(X(:,:,i,L),run_num);
               y;
             catch
                err = 1;
                fprintf( 1, 'Error: some problem encountered while integrating ODE network!\n' );
                y = zeros(numTimepoints,length(y_var_label));
             end
           Y(run_num,:,:,i,L)= y(:,:);% time points of interest for the US analysis
        end %run_num=1:NS
    end % L=1:NR
end % i=1:k
diary off
save Model_efast.mat;
%%
%CALCULATE Si AND STi for each resample (1,2,...,NR) [ranges]
[Si,Sti,rangeSi,rangeSti] = efast_sd(Y,OMi,MI,1:numTimepoints,1:length(y_var_label));
save('cache/Si.mat','Si')
save('cache/Sti.mat','Sti')
save('cache/rangeSi.mat','rangeSi')
save('cache/rangeSti.mat','rangeSti')

%CALCULATE the significance of the sensitivity indices for the parameter, compared 
%to the index for the dummy value
for SensCalc = 1:length(y_var_label)
    ind = SensCalc;
    [CVsi(:,:,SensCalc)  CVsti(:,:,SensCalc)]=CVmethod(Si, rangeSi,Sti,rangeSti,ind);
    save('cache/CVsi.mat','CVsi')
    save('cache/CVsti.mat','CVsti')
    
    %T-test on Si and STi for Viral load (variable 4)
    time_points = importdata('exp_timepoints.mat');
    [eFASToutputs{SensCalc}, Si_out(:,:,SensCalc), p_Si_out(:,:,SensCalc), Sti_out(:,:,SensCalc), p_Sti_out(:,:,SensCalc)] = efast_ttest(Si,rangeSi,Sti,rangeSti,1:length(time_points),efast_var,ind,y_var_label,0.05);
    % This is where error in code was leading to p-values being saved only at 1 timepoint.
    % Previously, the code was like this
    % [eFASToutputs{SensCalc}, Si_out(:,:,SensCalc), p_Si_out(:,:,SensCalc), Sti_out(:,:,SensCalc), p_Sti_out(:,:,SensCalc)] = efast_ttest(Si,rangeSi,Sti,rangeSti,1,efast_var,ind,y_var_label,0.05);
 
    save('cache/eFASToutputs.mat','eFASToutputs')
    save('cache/Si_out_data.mat','Si_out')
    save('cache/p_Si_out_data.mat','p_Si_out')
    save('cache/Sti_out_data.mat','Sti_out')
    save('cache/p_Sti_out_data.mat','p_Sti_out')
end
%%
toc
%delete(gcp)
