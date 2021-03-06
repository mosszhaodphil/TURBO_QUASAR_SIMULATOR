% This code is the implementation the following papers
% MA Chappell (2012) doi: 10.1002/mrm.24372 (MACQ)
% MA Chappell (2012) doi: 10.1002/mrm.24260 (MACD)
% ET Petersen (2006) doi: 10.1002/mrm.20784 (ETP)

% This function calculates the vessel (microvasculature) delivery function c(t), eq [9] (ETP)
% c(t) = exp(-t / t1_a) * vessel_dispersion_function
function delivery_vessel_Buxton = calculate_delivery_vessel_Buxton_no_dispersion(t, bolus_time_passed, current_bolus_duration)

	load('param_basis.mat');
	load('param_user.mat');

	delivery_vessel_Buxton = zeros(length(t), 1);
	%aif_dispersion_vessel  = zeros(length(t), 1);
	%delivery_Buxton        = zeros(length(t), 1);

	current_value = 0;


	current_arrival_time = bolus_time_passed + param_user_str.tau_m;

	for j = 1 : length(t)

		% corrent Look-locker readout T1
		t1_a_eff = correct_t1a_look_locker(t(j) - bolus_time_passed);
		t1_a_eff = param_user_str.t1_a; % This is for simulation only

		if(t(j) < current_arrival_time)
			%delivery_vessel_Buxton(j) = 2 * exp((-1) * param_user_str.tau_m / t1_a_eff) * (0.98 * exp((t(j) - bolus_time_passed - param_user_str.tau_m) / 0.05) + 0.02 * (t(j) - bolus_time_passed) / param_user_str.tau_m);
			delivery_vessel_Buxton(j) = 0;
		end

		if(t(j) >= current_arrival_time && t(j) < current_arrival_time + current_bolus_duration)
			delivery_vessel_Buxton(j) = exp( (-1) * (t(j) - bolus_time_passed) / t1_a_eff);
		end

		if(t(j) >= current_arrival_time + current_bolus_duration)
			
			%{
			current_value = 2 * exp((-1) * (param_user_str.tau_m + param_mr_str.tau_b) / t1_a_eff);
			current_value = current_value * (0.98 * exp( (-1) * (t(j) - bolus_time_passed - param_user_str.tau_m - param_mr_str.tau_b) / 0.05) + 0.02 * (1 - (t(j) - bolus_time_passed - param_user_str.tau_m - param_mr_str.tau_b) / 5));

			if(current_value >= 0)
				delivery_vessel_Buxton(j) = current_value;
			else
				delivery_vessel_Buxton(j) = 0;
			end
			%}

			delivery_vessel_Buxton(j) = 0;
		end


	end

	% scale the arterial blood signal with ABV and calibration
	delivery_vessel_Buxton = 2 * param_user_str.inversion_efficiency * param_user_str.m_0a * param_user_str.arterial_blood_volume * delivery_vessel_Buxton;



end

