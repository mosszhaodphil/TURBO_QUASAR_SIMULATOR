% This code is the implementation the following papers
% MA Chappell (2012) doi: 10.1002/mrm.24372 (MACQ)
% MA Chappell (2012) doi: 10.1002/mrm.24260 (MACD)
% ET Petersen (2006) doi: 10.1002/mrm.20784 (ETP)
% RB Buxton (1998) doi: 10.1002/mrm.1910400308 (RBB)

% This function calculates ASL signal deltaM of arterial blood using Buxton's model (RBB)
% The same method is also used in equation [5] of (MACQ)
% Assuming no dispersion of bolus between labeling and imaging sites
% delta_M_blood = 2 * alpha * M0a * aBV * c(t)
% c(t) = exp(-1 / T1a) * a(t)
% a(t) depends on dispersion

function delta_M_blood = calculate_delta_M_blood(t)

	load('param_user.mat');
	load('param_basis.mat');

	delta_M_blood  = zeros(length(t), 1); % ASL signal of tissue
	input_function = zeros(length(t), 1); % c(t) of (MACQ)
	aif_dispersion = zeros(length(t), 1); % a(t) of (MACQ)

	bolus_arrived = 0;

	% Check dispersion

	% No dispersion
	if(param_user_str.dispersion_type == 1)

		while(bolus_arrived < param_mr_str.n_bolus)

			%bolus_time_passed = bolus_arrived * (param_mr_str.tau_b + param_user_str.delta_bolus);
			bolus_time_passed = bolus_arrived * param_user_str.delta_bolus;

			delta_M_blood = delta_M_blood + calculate_delivery_vessel_Buxton_no_dispersion(t, bolus_time_passed); % calculate ASL signal

			bolus_arrived = bolus_arrived + 1;
		end
	end

end

