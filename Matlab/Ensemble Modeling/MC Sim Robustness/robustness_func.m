function [robustness_mat] = robustness_func(MC_params, struct_vec, noise_vec, num_sim)
% Given a set of parameters and a vector of noise values to add to each,
% determine what percentage of simulations still match the desired shape

% Pre-allocate robustness_mat
robustness_mat = zeros(length(struct_vec),length(noise_vec));

% Simulation time
predTime = 0:60:6*3600;

% Loop through each value of the Structure variable
for s = 1:length(struct_vec)
    
    % Desired structure
    struct_choice = struct_vec(s);
    
    % Subset the MC params to only include the desired structure
    my_params = table2array(MC_params(MC_params.Structure == struct_choice,:));
    num_param_set = size(my_params,1);
    
    
    % Loop thorugh each value of noise_vec
    for i = 1:length(noise_vec)
        noise_val = noise_vec(i);
        disp(noise_val)
        
        % Pre-allocate success_mat
        success_vec = zeros(1,num_sim);

        % Loop through 100 simulations, picking a random param set each time
        for j = 1:num_sim

            % Pick a param set
            my_param_set = my_params(randi(num_param_set),2:end);
            
            % Generate a random vector of -1 and 1
            plus_minus_vec = round(rand(1,length(my_param_set)))*2-1;
            
            % Add random noise to parameter set
            noised_param_set = my_param_set + plus_minus_vec.*noise_val.*my_param_set;

            % Assign the parameter values
            params(2,1) = noised_param_set(1,1);
            params(3,1) = noised_param_set(1,2);
            params(4,1) = noised_param_set(1,3);
            params(5,1) = noised_param_set(1,4);
            params(6,1) = noised_param_set(1,5);
            params(7,1) = noised_param_set(1,6);
            params(8,1) = noised_param_set(1,7);
            params(9,1) = noised_param_set(1,8);
            params(11,1) = noised_param_set(1,9);
            params(12,1) = noised_param_set(1,10);
            params(13,1) = noised_param_set(1,11);
            params(14,1) = noised_param_set(1,12);
            params(15,1) = noised_param_set(1,13);
            params(16,1) = noised_param_set(1,14);
            params(17,1) = noised_param_set(1,15);
            params(18,1) = noised_param_set(1,16);
            params(19,1) = noised_param_set(1,17);
            params(20,1) = noised_param_set(1,18);
            params(21,1) = noised_param_set(1,19);
            params(22,1) = noised_param_set(1,20);
            params(23,1) = noised_param_set(1,21);
            params(24,1) = noised_param_set(1,22);
            params(25,1) = noised_param_set(1,23);
            params(26,1) = noised_param_set(1,24);
            params(27,1) = noised_param_set(1,25);
            params(29,1) = noised_param_set(1,26);
            params(30,1) = noised_param_set(1,27);
            params(31,1) = noised_param_set(1,28);
            params(32,1) = noised_param_set(1,29);
            params(33,1) = noised_param_set(1,30);
            params(34,1) = noised_param_set(1,31);
            params(35,1) = noised_param_set(1,32);
            params(36,1) = noised_param_set(1,33);
            params(37,1) = noised_param_set(1,34);
            params(38,1) = noised_param_set(1,35);
            params(39,1) = noised_param_set(1,36);
            params(40,1) = noised_param_set(1,37);
            params(41,1) = noised_param_set(1,38);
            params(42,1) = noised_param_set(1,39);
            params(43,1) = noised_param_set(1,40);
            params(44,1) = noised_param_set(1,41);
            params(47,1) = noised_param_set(1,42);

            initvalues(2,1) = noised_param_set(1,43);
            initvalues(4,1) = noised_param_set(1,44);
            initvalues(5,1) = noised_param_set(1,45);
            initvalues(6,1) = noised_param_set(1,46);

            % Assign fixed params and IVs
            params(1,1) = 0.00308065413582198;
            params(10,1) = 0.000256721177985165;
            params(28,1) = 0.0355;
            params(45,1) = 0.5;
            params(46,1) = 1.42;

            initvalues(1,1)= 9.09;
            initvalues(3,1)= 0;
            initvalues(7,1)= 0;
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

            % Assign variables for calculated quantities
            kdeg = params(10,1);
            RJ = initvalues(2,1);
            Vratio = params(45,1);
            ncratio = params(46,1);
            totalSTAT = params(47,1);
            k17b = params(29,1);

            % Calculate quantities
            ksyn = kdeg*RJ; % syn rate of RJ
            S5c = totalSTAT/(1 + ncratio*Vratio); % STAT5 in cytosol
            S5n = (totalSTAT - S5c)/Vratio; %STAT5 in nucleus
            k17a = S5n/S5c*(Vratio)*k17b;

            %Assign them
            params(1,1) = ksyn;
            initvalues(3,1) = S5c;
            initvalues(21,1) = S5n;
            params(28,1) = k17a;

            % Set options
            options = odeset('RelTol',1e-9,'AbsTol',1e-12,'NonNegative',[1:length(initvalues)]);

            % simulate the model
            [~, predConc] = ode15s(@core_file_master,predTime,initvalues,options,params);
            
            % Calculated quantities
            total_pStat = predConc(:,11) + predConc(:,12) +2.*predConc(:,13) + predConc(:,15) + 2*predConc(:,16) + predConc(:,17) + 2*predConc(:,18) + predConc(:,19) + predConc(:,20) + 2*predConc(:,22) + predConc(:,23);
            total_pStat_norm = total_pStat./max(total_pStat);
            total_pStat_inverted = max(total_pStat_norm)-total_pStat_norm;
            
            Stat_cyto = predConc(:,3) + predConc(:,10) + predConc(:,11) + predConc(:,12) + 2*predConc(:,13) + predConc(:,15) + 2*predConc(:,16) + 2*predConc(:,17) + predConc(:,28);
            Stat_nucleus = 2*predConc(:,18) + predConc(:,19) + predConc(:,20) + predConc(:,21) + 2*predConc(:,22) + 2*predConc(:,23);

            
            % Run find peaks
            [pks, loc] = findpeaks(total_pStat_norm,predTime,'MinPeakDistance',20*60,'MinPeakProminence',0.01);

            %Find valleys
            [vls, loc_vls] = findpeaks(total_pStat_inverted,predTime,'MinPeakDistance',20*60,'MinPeakProminence',0.01);

            % Classification
            % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            

            
            
            % For two peaks
            if length(pks) == 2
                if loc(1) <= 3600 % first peak in correct timescale
                    if total_pStat(loc_vls(1)/60+1) <= 0.7*total_pStat(loc(1)/60+1)  % strong enough feedback
                        if pks(2) >= pks(1) % Larger second peak
                            if total_pStat(end) >= 0.75*total_pStat(loc(1)/60+1) %prolonged activation
                                if (loc_vls(1) >= 3600) &&  (loc_vls(1) <= 3600*3) % Time of valley
                                    if max(total_pStat_norm) <= 2.5*pks(1) % Pos FB not too strong
                                        if loc(2) >= 3600*3 % Second peak correct timescale
                                            success_vec(j) = 1;
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
            
            % For one peak
            if length(pks) == 1
                if loc(1) <= 3600 % first peak in correct timescale
                    if total_pStat(end) >= 0.75*total_pStat(loc(1)/60+1) %prolonged activation
                        if length(loc_vls) > 0
                            if (loc_vls(1) >= 3600) &&  (loc_vls(1) <= 3600*3) % Time of valley
                                if total_pStat(loc_vls(1)/60+1) <= 0.7*total_pStat(loc(1)/60+1)  % strong enough feedback
                                    if max(total_pStat_norm) <= 2.5*pks(1) % Pos FB not too strong
                                        success_vec(j) = 1;
                                    end
                                end
                            end
                        end
                    end
                end
            end

            % Rule out weak activation
            if max(total_pStat) <= 0.01*Stat_cyto(1) 
                success_vec(j) = 0;
            end
                    
            % Reset values
            predConc = [];
            pks = [];
            loc = []; 
            loc_vls = [];



        end
        
        % Store the success percentage
        robustness_mat(s,i) = sum(success_vec)./length(success_vec);
        
    end
end
    
end

