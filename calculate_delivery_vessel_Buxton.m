% This code is the implementation the following papers
% MA Chappell (2012) doi: 10.1002/mrm.24372 (MACQ)
% MA Chappell (2012) doi: 10.1002/mrm.24260 (MACD)
% ET Petersen (2006) doi: 10.1002/mrm.20784 (ETP)

% This function calculates the vessel (microvasculature) delivery function c(t), eq [9] (ETP)
% c(t) = exp(-t / t1_a) * vessel_dispersion_function
function delivery_vessel_Buxton = calculate_delivery_vessel_Buxton(t)

	load('param_basis.mat');
	load('param_user.mat');

	delivery_vessel_Buxton = zeros(length(t), 1);
	aif_dispersion_vessel  = zeros(length(t), 1);
	delivery_Buxton        = zeros(length(t), 1);

	bolus_arrived = 0;

	while(bolus_arrived < param_mr_str.n_bolus)

		%bolus_time_passed = bolus_arrived * (param_mr_str.tau_b + param_user_str.delta_bolus);
		bolus_time_passed = bolus_arrived * param_user_str.delta_bolus;

		% calculate Buxton's delivery c(t)
		delivery_Buxton = calculate_delivery_Buxton(t, bolus_time_passed);

		% calculate dispersion
		switch param_user_str.dispersion_type
			case 1 % eq [6] (MACQ)
				aif_dispersion_vessel = calculate_aif_vessel_no_dispersion(t, bolus_time_passed); % calculate dispersion effect of AIF
			otherwise
				% do nothing now
		end

		delivery_vessel_Buxton = delivery_vessel_Buxton + delivery_Buxton .* aif_dispersion_vessel;

		%{
		% calculate deliver function c(t), eq [5] (MACQ)
		for j = 1 : length(t)
			delivery_vessel_Buxton(j) = delivery_Buxton(j) * aif_dispersion_vessel(j);
		end
		%}

		bolus_arrived = bolus_arrived + 1;

	end

end

