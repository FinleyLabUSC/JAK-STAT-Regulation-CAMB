function [t_ode, x_ode] = driver_eFAST(X,runnum)

% Ryland Mortlock
% July 22nd, 2019


% Vary free parameters
free_vars(1,1) = 10^(X(runnum,1));
free_vars(2,1) = 10^(X(runnum,2));
free_vars(3,1) = 10^(X(runnum,3));
free_vars(4,1) = 10^(X(runnum,4));
free_vars(5,1) = 10^(X(runnum,5));
free_vars(6,1) = 10^(X(runnum,6));
free_vars(7,1) = 10^(X(runnum,7));
free_vars(8,1) = 10^(X(runnum,8));
free_vars(9,1) = 10^(X(runnum,9));
free_vars(10,1) = 10^(X(runnum,10));
free_vars(11,1) = 10^(X(runnum,11));
free_vars(12,1) = 10^(X(runnum,12));
free_vars(13,1) = 10^(X(runnum,13));
free_vars(14,1) = 10^(X(runnum,14));
free_vars(15,1) = 10^(X(runnum,15));
free_vars(16,1) = 10^(X(runnum,16));
free_vars(17,1) = 10^(X(runnum,17));
free_vars(18,1) = 10^(X(runnum,18));
free_vars(19,1) = 10^(X(runnum,19));
free_vars(20,1) = 10^(X(runnum,20));
free_vars(21,1) = 10^(X(runnum,21));
free_vars(22,1) = 10^(X(runnum,22));
free_vars(23,1) = 10^(X(runnum,23));
free_vars(24,1) = 10^(X(runnum,24));
free_vars(25,1) = 10^(X(runnum,25));
free_vars(26,1) = 10^(X(runnum,26));
free_vars(27,1) = 10^(X(runnum,27));
free_vars(28,1) = 10^(X(runnum,28));
free_vars(29,1) = 10^(X(runnum,29));
free_vars(30,1) = 10^(X(runnum,30));
free_vars(31,1) = 10^(X(runnum,31));
free_vars(32,1) = 10^(X(runnum,32));
free_vars(33,1) = 10^(X(runnum,33));
free_vars(34,1) = 10^(X(runnum,34));
free_vars(35,1) = 10^(X(runnum,35));
free_vars(36,1) = 10^(X(runnum,36));
free_vars(37,1) = 10^(X(runnum,37));
free_vars(38,1) = 10^(X(runnum,38));
free_vars(39,1) = 10^(X(runnum,39));
free_vars(40,1) = 10^(X(runnum,40));
free_vars(41,1) = 10^(X(runnum,41));
free_vars(42,1) = 10^(X(runnum,42));
free_vars(43,1) = 10^(X(runnum,43));
free_vars(44,1) = 10^(X(runnum,44));
free_vars(45,1) = 10^(X(runnum,45));
free_vars(46,1) = 10^(X(runnum,46));
free_vars(47,1) = 10^(X(runnum,47));
free_vars(48,1) = 10^(X(runnum,48));
free_vars(49,1) = 10^(X(runnum,49));
free_vars(50,1) = 10^(X(runnum,50));
free_vars(51,1) = 10^(X(runnum,51));
free_vars(52,1) = 10^(X(runnum,52));
free_vars(53,1) = 10^(X(runnum,53));
free_vars(54,1) = 10^(X(runnum,54));
free_vars(55,1) = 10^(X(runnum,55));
free_vars(56,1) = 10^(X(runnum,56));
free_vars(57,1) = 10^(X(runnum,57));
free_vars(58,1) = 10^(X(runnum,58));
free_vars(59,1) = 10^(X(runnum,59));
free_vars(60,1) = 10^(X(runnum,60));
free_vars(61,1) = 10^(X(runnum,61));

% Name the free variables
k2 = free_vars(1);
k_2 = free_vars(2);
k3 = free_vars(3);
k_3 = free_vars(4);
k4 = free_vars(5);
k5 = free_vars(6);
k_5 = free_vars(7);
k6 = free_vars(8);
kdeg = free_vars(9);
deg_ratio = free_vars(10);
k8A = free_vars(11);
k_8A = free_vars(12);
k8B = free_vars(13);
k_8B = free_vars(14);
k8AB = free_vars(15);
k_8AB = free_vars(16);
k9 = free_vars(17);
k_9 = free_vars(18);
k10 = free_vars(19);
k11 = free_vars(20);
k_11 = free_vars(21);
k12 = free_vars(22);
k13 = free_vars(23);
k_13 = free_vars(24);
k14A = free_vars(25);
k14B = free_vars(26);
k14AB = free_vars(27);
k15 = free_vars(28);
k_15 = free_vars(29);
k16 = free_vars(30);

k17outA = free_vars(31);

k17outB = free_vars(32);
k18a = free_vars(33);
k18b = free_vars(34);
k19 = free_vars(35);
k20 = free_vars(36);
k21 = free_vars(37);
k_21 = free_vars(38);
k22 = free_vars(39);
k23 = free_vars(40);
k24 = free_vars(41);
k25a = free_vars(42);
k25b = free_vars(43);
k26 = free_vars(44);
k27 = free_vars(45);
k28 = free_vars(46);
k29 = free_vars(47);
Vratio = free_vars(48);
ncratioA = free_vars(49);
ncratioB = free_vars(50);
totalSTAT = free_vars(51);
k30a = free_vars(52);
k30b = free_vars(53);
k31 = free_vars(54);
k32 = free_vars(55);
k33 = free_vars(56);


PRL = free_vars(57);
RJ = free_vars(58);
SHP2 = free_vars(59);
PPX = free_vars(60);
PPN = free_vars(61);


% Assign parameter values to params vector (from excel sheet)
params(2,1) = k2;
params(3,1) = k_2;
params(4,1) = k3;
params(5,1) = k_3;
params(6,1) = k4;
params(7,1) = k5;
params(8,1) = k_5;
params(9,1) = k6;
params(10,1) = kdeg;
params(11,1) = deg_ratio;
params(12,1) = k8A;
params(13,1) = k_8A;
params(14,1) = k8B;
params(15,1) = k_8B;
params(16,1) = k8AB;
params(17,1) = k_8AB;
params(18,1) = k9;
params(19,1) = k_9;
params(20,1) = k10;
params(21,1) = k11;
params(22,1) = k_11;
params(23,1) = k12;
params(24,1) = k13;
params(25,1) = k_13;
params(26,1) = k14A;
params(27,1) = k14B;
params(28,1) = k14AB;
params(29,1) = k15;
params(30,1) = k_15;
params(31,1) = k16;

params(33,1) = k17outA;

params(35,1) = k17outB;

params(36,1) = k18a;
params(37,1) = k18b;
params(38,1) = k19;
params(39,1) = k20;
params(40,1) = k21;
params(41,1) = k_21;
params(42,1) = k22;
params(43,1) = k23;
params(44,1) = k24;
params(45,1) = k25a;
params(46,1) = k25b;
params(47,1) = k26;
params(48,1) = k27;
params(49,1) = k28;
params(50,1) = k29;
params(51,1) = Vratio;
params(52,1) = ncratioA;
params(53,1) = ncratioB;
params(54,1) = totalSTAT;
params(55,1) = k30a;
params(56,1) = k30b;
params(57,1) = k31;
params(58,1) = k32;
params(59,1) = k33;


initvalues(1,1)= PRL;
initvalues(2,1)= RJ;

initvalues(5,1)= SHP2;
initvalues(6,1)= PPX;
initvalues(7,1)= PPN;


% Assign zero initial values
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
initvalues(54,1)= 0;
initvalues(55,1)= 0;
initvalues(56,1)= 50;

BCL = initvalues(56,1);
k34 = 1.93E-05;
params(60,1) = k34;

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



% Set details
options = odeset('RelTol',1e-9,'AbsTol',1e-12,'NonNegative',[1:length(initvalues)]); %Specifies level of accuracy, smaller is more accurate but longer processing time

% Set timepoints to run simulation at   
tspan = importdata('exp_timepoints.mat');


[t_ode predConc] = ode15s(@core_file_new,tspan,initvalues,options,params);


% Calculated quantities FIXED FOR COMP
total_pStatA = predConc(:,13) +2.*predConc(:,15) + predConc(:,16) + predConc(:,19) + 2*predConc(:,21) + predConc(:,23) + predConc(:,24) + predConc(:,27) + 2*predConc(:,28) + predConc(:,29) + predConc(:,31) + predConc(:,33) + 2*predConc(:,37) + predConc(:,38) + predConc(:,40) + predConc(:,43);
total_pStatB = predConc(:,14) +2.*predConc(:,17) + predConc(:,16) + predConc(:,20) + 2*predConc(:,22) + predConc(:,23) + predConc(:,25) + predConc(:,26) + 2*predConc(:,30) + predConc(:,29) + predConc(:,32) + predConc(:,34) + 2*predConc(:,39) + predConc(:,38) + predConc(:,41) + predConc(:,42);

Stat_cytoA = predConc(:,3) + predConc(:,11) + predConc(:,13) + 2*predConc(:,15) + predConc(:,16) + predConc(:,19) + 2*predConc(:,21) + predConc(:,23) + 2*predConc(:,24) + predConc(:,26) + predConc(:,27) + predConc(:,48);
Stat_cytoB = predConc(:,4) + predConc(:,12) + predConc(:,14) + 2*predConc(:,17) + predConc(:,16) + predConc(:,20) + 2*predConc(:,22) + predConc(:,23) + 2*predConc(:,25) + predConc(:,26) + predConc(:,27) + predConc(:,49);

Stat_nucleusA = 2*predConc(:,28) + predConc(:,29) + predConc(:,31) + predConc(:,33) + predConc(:,35) + 2*predConc(:,37) + predConc(:,38) + 2*predConc(:,40) + predConc(:,42) + predConc(:,43);
Stat_nucleusB = 2*predConc(:,30) + predConc(:,29) + predConc(:,32) + predConc(:,34) + predConc(:,36) + 2*predConc(:,39) + predConc(:,38) + 2*predConc(:,41) + predConc(:,42) + predConc(:,43);

nucleus_cyto_ratioA = Stat_nucleusA./Stat_cytoA;
nucleus_cyto_ratioB = Stat_nucleusB./Stat_cytoB;

rec_total = predConc(:,2) + predConc(:,8) + 2*predConc(:,9) + 2*predConc(:,10) + 2*predConc(:,11) + 2*predConc(:,12) + 2*predConc(:,18) + 2*predConc(:,47) + 2*predConc(:,48) + 2*predConc(:,49) + 2*predConc(:,50);
rec_internalized = 1 - rec_total./initvalues(2,1);

% Add calculated quantities to results matrix
x_ode = zeros(length(tspan),length(initvalues));
x_ode(:,1:length(initvalues)) = predConc;

x_ode(:,length(initvalues)+1) = total_pStatA;
x_ode(:,length(initvalues)+2) = total_pStatB;
x_ode(:,length(initvalues)+3) = nucleus_cyto_ratioA; 
x_ode(:,length(initvalues)+4) = nucleus_cyto_ratioB; 
x_ode(:,length(initvalues)+5) = rec_internalized; 
