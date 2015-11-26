% This code is the implementation the following papers
% MA Chappell (2012) doi: 10.1002/mrm.24372 (MACQ)
% MA Chappell (2012) doi: 10.1002/mrm.24260 (MACD)
% ET Petersen (2006) doi: 10.1002/mrm.20784 (ETP)
% M  Günther  (1998) doi: 10.1002/mrm.1284 (MG)

% This function calculates the residue function r(t - tau_t), eq [2] (MG). tau_t or t' is bolus arrival time
% r(t) = exp(-t * f / lamda)

function residue_r = calculate_residue_r_Buxton(t)

	load('param_user.mat');
	load('param_basis.mat');

	residue_r = zeros(length(t), 1); % create zero vector for residue function values

	for j = 1 : length(t)

		residue_r(j) = exp((-(t(j))) * param_user_str.f / param_mr_str.lamda);

	end % end for loop

end
