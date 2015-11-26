% This code is the implementation the following papers
% MA Chappell (2012) doi: 10.1002/mrm.24372 (MACQ)
% MA Chappell (2012) doi: 10.1002/mrm.24260 (MACD)
% ET Petersen (2006) doi: 10.1002/mrm.20784 (ETP)
% M  Günther  (1998) doi: 10.1002/mrm.1284 (MG)

% This function calculates the magnetic relaxation function m(t - tau_t), eq [6] (MG). tau_t or t' is bolus arrival time to tissue
% Since the term (cos(alpha)) ^ n is considered in AIF calculation
% m(t) = exp(-t / t1_t)

function relaxation_m = calculate_relaxation_m(t)
	
	load('param_user.mat');
	load('param_basis.mat');

	relaxation_m = zeros(length(t), 1); % create zero vector for relaxation function values

	for j = 1 : length(t)
		% Calculate effective T1 of tissue with eq [10] of (MACQ)
		t1_t_eff = correct_t1t_look_locker(t(j));

		%relaxation_m(j) = exp((-(t(j))) / param_user_str.t1_t);
		relaxation_m(j) = exp((-(t(j))) / t1_t_eff);

	end % end for loop

end
