% Ryland Mortlock
% June 14th, 2019

clearvars
clc
close all
type = 'weighted';

% Data_time = importdata('tspan.mat'); 

%Run the model at these timepoints
predTime = [0:60:1*3600];


ALL_params = importdata('data/free_params.mat');
% ALL_params = sortrows(ALL_params,1);
numFits = size(ALL_params,1);
% free_params = [0.109709750601466;0.00927907244997107;0.971457672185374;20.6432024829247;0.0472809692961210;16.0927968865182;1.70563079879507;0.00810980838332706;6.02453236050481;9.68165950029885;0.00211566044269692;0.0266225524010845;0.0312073732750853;0.0391172367213432;0.00502926999502561;0.101761349137690;0.000302086702765119;0.0230977638435886;0.000296177213569438;0.00534606788865659;709.452852763266;42.2489853309736;39.6479671713842;66.6123840756945];
% numFits = 19;

% Run with fits (PRL stimulation)

% numFits = 5;

% Doses
dose_response_ng_mL = [50 100 200 500 1000 5000];
dose_response_nm = [2.2725 4.545 9.09 22.725 45.45 227.25];
num_doses = length(dose_response_ng_mL);

for j = 1:num_doses

for i = 1:numFits
    
free_params1 = ALL_params(i,:);


% Assign the fitted parameter values
                k3 = free_params1(1);
                k5 = free_params1(2);
                deg_ratio = free_params1(3);
                k8A = free_params1(4);
                mult8B = free_params1(5);
                mult8AB = free_params1(6);
                k9 = free_params1(7);
                k11 = free_params1(8);
                k_13 = free_params1(9);
                k14A = free_params1(10);
                mult14B = free_params1(11);
                mult14AB = free_params1(12);
                k15 = free_params1(13);
                k16 = free_params1(14);
                k17outA = free_params1(15);
                mult17B = free_params1(16);
                k19 = free_params1(17);
                k21 = free_params1(18);
                k22 = free_params1(19);
                k23 = free_params1(20);
                k24 = free_params1(21);
                k25a = free_params1(22);
                k27 = free_params1(23);
                k28 = free_params1(24);
                totalSTAT = free_params1(25);
                k30a = free_params1(26);
                RJ = free_params1(27);
                SHP2 = free_params1(28);
                PPX = free_params1(29);
                PPN = free_params1(30);
                
                k34 = free_params1(31);
                BCL = free_params1(32);
                k4 = free_params1(33);


% Calculate based on multiplication ratios
                    k8B = mult8B*k8A;
                    k8AB = mult8AB*k8A;
                    k14B = mult14B*k14A;
                    k14AB = mult14AB*k8A;
                    k17outB = mult17B*k17outA;

              % Assign to parameter values
                params(4,1) = k3;
                params(7,1) = k5;
                params(11,1) = deg_ratio;
                params(12,1) = k8A;
                params(14,1) = k8B;
                params(16,1) = k8AB;
                params(18,1) = k9;
                params(21,1) = k11;
                params(25,1) = k_13;
                params(26,1) = k14A;
                params(27,1) = k14B;
                params(28,1) = k14AB;
                params(29,1) = k15;
                params(31,1) = k16;
                params(33,1) = k17outA;
                params(35,1) = k17outB;
                params(38,1) = k19;
                params(40,1) = k21;
                params(42,1) = k22;
                params(43,1) = k23;
                params(44,1) = k24;
                params(45,1) = k25a;
                params(48,1) = k27;
                params(49,1) = k28;
                params(54,1) = totalSTAT;
                params(55,1) = k30a;

                initvalues(2,1) = RJ;
                initvalues(5,1) = SHP2;
                initvalues(6,1) = PPX;
                initvalues(7,1) = PPN;

                params(60,1) = k34;
                initvalues(56,1) = BCL;
                params(6,1) = k4;


                % Parameter values 
                params(2,1) = 0.000056;
                params(3,1) = 0.0056;
%                 params(4,1) = 0.04;
                params(5,1) = 0.2;
            %    params(6,1) = 0.005;
%                 params(7,1) = 0.008;
                params(8,1) = 0.8;
                params(9,1) = 0.4;
                params(10,1) = 0.000256721177985165;
%                 params(11,1) = 10;
%                 params(12,1) = 0.02;
                params(13,1) = 0.1;
%                 params(14,1) = 0.02;
                params(15,1) = 0.1;
%                 params(16,1) = 0.02;
                params(17,1) = 0.1;
%                 params(18,1) = 0.001;
                params(19,1) = 0.2;
                params(20,1) = 0.003;
%                 params(21,1) = 0.001;
                params(22,1) = 0.2;
                params(23,1) = 0.003;
                params(24,1) = 0.0000002;
%                 params(25,1) = 0.2;
%                 params(26,1) = 0.005;
%                 params(27,1) = 0.005;
%                 params(28,1) = 0.005;
%                 params(29,1) = 0.001;
                params(30,1) = 0.2;
%                 params(31,1) = 0.005;
                params(32,1) = 0.0355;
%                 params(33,1) = 0.05;
                params(34,1) = 0.0355;
%                 params(35,1) = 0.05;
                params(36,1) = 0.01;
                params(37,1) = 400;
%                 params(38,1) = 0.001;
                params(39,1) = 0.01;
%                 params(40,1) = 0.02;
                params(41,1) = 0.1;
%                 params(42,1) = 0.0005;
%                 params(43,1) = 0.0005;
%                 params(44,1) = 0.0005;
%                 params(45,1) = 0.01;
                params(46,1) = 400;
                params(47,1) = 0.001;
%                 params(48,1) = 0.0005;
%                 params(49,1) = 0.01;
                params(50,1) = 0.01;
                params(51,1) = 0.5;
                params(52,1) = 1.2;
                params(53,1) = 1.36;
%                 params(54,1) = 1000;
%                 params(55,1) = 0.01;
                params(56,1) = 400;
                params(57,1) = 0.001;
                params(58,1) = 0.0005;
                params(59,1) = 0.01;
           %     params(60,1) = 1.92540883488874E-05;
                params(61,1) = 0;


               % Initial values from Yamada 2003
                initvalues(1,1)= dose_response_nm(j);
                % initvalues(2,1)= 12;
                initvalues(3,1)= 0;
                initvalues(4,1)= 0;
                % initvalues(5,1)= 100;
                % initvalues(6,1)= 50;
                % initvalues(7,1)= 60;
                initvalues(8,1)= 0;
                initvalues(9,1)= 0;
                initvalues(10,1)= 0;
                initvalues(11,1)= 0;
                initvalues(12,1)= 0;
                initvalues(13,1)= 0;
                initvalues(14,1)= 0;
                initvalues(15,1)= 0;
                initvalues(16,1)= 0;
                initvalues(17,1)= 0;
                initvalues(18,1)= 0;
                initvalues(19,1)= 0;
                initvalues(20,1)= 0;
                initvalues(21,1)= 0;
                initvalues(22,1)= 0;
                initvalues(23,1)= 0;
                initvalues(24,1)= 0;
                initvalues(25,1)= 0;
                initvalues(26,1)= 0;
                initvalues(27,1)= 0;
                initvalues(28,1)= 0;
                initvalues(29,1)= 0;
                initvalues(30,1)= 0;
                initvalues(31,1)= 0;
                initvalues(32,1)= 0;
                initvalues(33,1)= 0;
                initvalues(34,1)= 0;
                initvalues(35,1)= 0;
                initvalues(36,1)= 0;
                initvalues(37,1)= 0;
                initvalues(38,1)= 0;
                initvalues(39,1)= 0;
                initvalues(40,1)= 0;
                initvalues(41,1)= 0;
                initvalues(42,1)= 0;
                initvalues(43,1)= 0;
                initvalues(44,1)= 0;
                initvalues(45,1)= 0;
                initvalues(46,1)= 0;
                initvalues(47,1)= 0;
                initvalues(48,1)= 0;
                initvalues(49,1)= 0;
                initvalues(50,1)= 0;
                initvalues(51,1)= 0;
                initvalues(52,1)= 0;
                initvalues(53,1)= 0;
                initvalues(54,1) = 0;
                initvalues(55,1) = 0;
          %      initvalues(56,1) = 50;

                % Assign variables for calculated quantities
                kdeg = params(10,1);
                RJ = initvalues(2,1);

                Vratio = params(51,1);
                ncratioA = params(52,1);
                ncratioB = params(53,1);
                totalSTAT = params(54,1);

                k17outA = params(33,1);
                k17outB = params(35,1);
                
                k34 = params(60,1);
                BCL = initvalues(56,1);

                % Calculate quantities
                ksyn = kdeg*RJ; % syn rate of RJ
                S5Ac = totalSTAT/(1 + ncratioA*Vratio); % STAT5 in cytosol
                S5An = (totalSTAT - S5Ac)/Vratio; %STAT5 in nucleus
                S5Bc = totalSTAT/(1 + ncratioB*Vratio); % STAT5 in cytosol
                S5Bn = (totalSTAT - S5Bc)/Vratio; %STAT5 in nucleus
                k17inA = S5An/S5Ac*(Vratio)*k17outA;
                k17inB = S5Bn/S5Bc*(Vratio)*k17outB;
                k35 = k34*BCL;

                %Assign them
                params(1,1) = ksyn;
                initvalues(3,1) = S5Ac;
                initvalues(35,1) = S5An;
                initvalues(4,1) = S5Bc;
                initvalues(36,1) = S5Bn;
                params(32,1) = k17inA;
                params(34,1) = k17inB;
                params(61,1) = k35;

% Set options
options = odeset('RelTol',1e-9,'AbsTol',1e-12,'NonNegative',[1:length(initvalues)]);

% simulate the model
[~, predConc] = ode15s(@core_file_new,predTime,initvalues,options,params);
  
% Calculated quantities
total_pStatA = predConc(:,13) +2.*predConc(:,15) + predConc(:,16) + predConc(:,19) + 2*predConc(:,21) + predConc(:,23) + predConc(:,24) + predConc(:,27) + 2*predConc(:,28) + predConc(:,29) + predConc(:,31) + predConc(:,33) + 2*predConc(:,37) + predConc(:,38) + predConc(:,40) + predConc(:,43);
total_pStatB = predConc(:,14) +2.*predConc(:,17) + predConc(:,16) + predConc(:,20) + 2*predConc(:,22) + predConc(:,23) + predConc(:,25) + predConc(:,26) + 2*predConc(:,30) + predConc(:,29) + predConc(:,32) + predConc(:,34) + 2*predConc(:,39) + predConc(:,38) + predConc(:,41) + predConc(:,42);

pStatA_norm(:,i) = total_pStatA./total_pStatA(31);% normalized to 30 minute
pStatB_norm(:,i) = total_pStatA./total_pStatA(31);% normalized to 30 minute

Stat_cytoA = predConc(:,3) + predConc(:,11) + predConc(:,13) + 2*predConc(:,15) + predConc(:,16) + predConc(:,19) + 2*predConc(:,21) + predConc(:,23) + 2*predConc(:,24) + predConc(:,26) + predConc(:,27) + predConc(:,48);
Stat_cytoB = predConc(:,4) + predConc(:,12) + predConc(:,14) + 2*predConc(:,17) + predConc(:,16) + predConc(:,20) + 2*predConc(:,22) + predConc(:,23) + 2*predConc(:,25) + predConc(:,26) + predConc(:,27) + predConc(:,49);

Stat_nucleusA = 2*predConc(:,28) + predConc(:,29) + predConc(:,31) + predConc(:,33) + predConc(:,35) + 2*predConc(:,37) + predConc(:,38) + 2*predConc(:,40) + predConc(:,42) + predConc(:,43);
Stat_nucleusB = 2*predConc(:,30) + predConc(:,29) + predConc(:,32) + predConc(:,34) + predConc(:,36) + 2*predConc(:,39) + predConc(:,38) + 2*predConc(:,41) + predConc(:,42) + predConc(:,43);

nucleus_cyto_ratioA = Stat_nucleusA./Stat_cytoA;
nucleus_cyto_ratioB = Stat_nucleusB./Stat_cytoB;

transloc_predA(:,i) = nucleus_cyto_ratioA;
transloc_predB(:,i) = nucleus_cyto_ratioB;

rec_total = predConc(:,2) + predConc(:,8) + 2*predConc(:,9) + 2*predConc(:,10) + 2*predConc(:,11) + 2*predConc(:,12) + 2*predConc(:,18) + 2*predConc(:,47) + 2*predConc(:,48) + 2*predConc(:,49) + 2*predConc(:,50);
rec_internalized = 1 - rec_total./initvalues(2);
intern_pred(i) = rec_internalized(31);

% Bcl fold change
Bcl(:,i) = predConc(:,56)./predConc(1,56);

% clc
% %Dose response
% if i == numFits
%    % disp(transloc_predA(31,:)')
%     disp(transloc_predB(19,:)')
%    % disp(max(transloc_predA(1:61,:))')
%    % disp(max(transloc_predB(1:61,:))')
% end

end

save(strcat('output/dr_',num2str(dose_response_ng_mL(j)),'.mat'),'transloc_predB')

end
