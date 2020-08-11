%% Load parameter vector

pars(1) = 0.04;
pars(2) = 0.008;
pars(3) = 10;
pars(4) = 0.02;
pars(5) = 1;
pars(6) = 1;
pars(7) = 0.001;
pars(8) = 0.001;
pars(9) = 0.2;
pars(10) = 0.005;
pars(11) = 1;
pars(12) = 1;
pars(13) = 0.001;
pars(14) = 0.005;
pars(15) = 0.05;
pars(16) = 1;
pars(17) = 0.001;
pars(18) = 0.02;
pars(19) = 0.0005;
pars(20) = 0.0005;
pars(21) = 0.0005;
pars(22) = 0.01*.1;
pars(23) = 0.0005;
pars(24) = 0.01;
pars(25) = 1000;
pars(26) = 0.01;
pars(27) = 12;
pars(28) = 100;
pars(29) = 50;
pars(30) = 60;

pars(31) = 1.93E-5; % Bcl deg rate
pars(32) = 50; %BCL initial value
pars(33) = 0.005; %k4

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





