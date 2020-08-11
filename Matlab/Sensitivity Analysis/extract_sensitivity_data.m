% Ryland Mortlock
% June 22, 2020

% Extract sensitivity results for the measured species at measured time
% points.

% Load total sensitivity indicies from eFAST
Sti_out = importdata('cache/Sti_out_data.mat');

% pSTATA sensitivity indices
pstatA_mat = Sti_out([3 5 6 8 10 12],:,57)';
csvwrite('output/total_pstatA.csv',pstatA_mat)

% pSTATB sensitivity indices
pstatB_mat = Sti_out([3 5 6 8 10 12],:,58)';
csvwrite('output/total_pstatB.csv',pstatB_mat)

% nuclear ratio A sensitivity indices
ncA_mat = Sti_out([5 6 7 9 12],:,59)';
csvwrite('output/ncA.csv',ncA_mat)

% nuclear ratio B sensitivity indices
ncB_mat = Sti_out([2 4 5 6 8 9 10 11 12],:,60)';
csvwrite('output/ncB.csv',ncB_mat)