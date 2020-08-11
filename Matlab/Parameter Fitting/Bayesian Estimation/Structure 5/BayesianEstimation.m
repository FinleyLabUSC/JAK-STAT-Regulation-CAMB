%% Load parameter vector

pars(1) = 0.04;
pars(2) = 0.008;
% pars(3) = 10;
pars(3) = 0.02;
pars(4) = 1;
pars(5) = 1;
pars(6) = 0.001;
pars(7) = 0.001;
pars(8) = 0.2;
pars(9) = 0.005;
pars(10) = 1;
pars(11) = 1;
pars(12) = 0.001;
pars(13) = 0.005;
pars(14) = 0.05;
pars(15) = 1;
pars(16) = 0.001;
pars(17) = 0.02;
pars(18) = 0.0005;
pars(19) = 0.0005;
pars(20) = 0.0005;
pars(21) = 0.01*.1;
pars(22) = 0.0005;
pars(23) = 0.01;
pars(24) = 1000;
pars(25) = 0.01;
pars(26) = 12;
pars(27) = 100;
pars(28) = 50;
pars(29) = 60;

pars(30) = 1.93E-5; % Bcl deg rate
pars(31) = 50; %BCL initial value
pars(32) = 0.005; %k4

g = pars';

nruns = 50;

estimates = cell(nruns,1);
err = cell(nruns,1);

parfor i = 1:nruns
    disp(i)
    [output1,output2] = Bayes_func_new(g);
    estimates{i} = output1;
    err{i} = output2;
end

save('output/bayes_estimates.mat','estimates','err');





