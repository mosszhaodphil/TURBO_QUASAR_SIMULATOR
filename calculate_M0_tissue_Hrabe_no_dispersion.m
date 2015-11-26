% This function calculates the tissue magnetization in Hrabe's solution
% Ref: J Hrabe (2003) doi:10.1016/j.jmr.2003.11.002 (JH)
% Input:
% vector t
% Output:
% Tissue magnetization, D(t) of eq [7]

function tissue_m = calculate_M0_tissue_Hrabe_no_dispersion(t, bolus_time_passed)

	% Load User and MRI parameters
	load('param_user.mat');
	load('param_basis.mat');

	tissue_m = zeros(length(t), 1);

	% Intermediate parameters in eq [7]
	%k        = 0;
	t1_a_eff = 0;
	t1_t_eff = 0;
	R        = 0;
	F        = 0;

	current_arrival_time = bolus_time_passed + param_user_str.tau_t;

	% Implementation of eq [7]
	for j = 1 : length(t)

		% Correct T1 in Look-locker readout
		t1_a_eff = correct_t1a_look_locker(t(j) - bolus_time_passed);
		%t1_a_eff = param_user_str.t1_a;
		t1_t_eff = correct_t1t_look_locker(t(j) - bolus_time_passed);

		% Calculate R and F
		R = 1 / t1_t_eff - 1 / t1_a_eff;
		%F = 2 * param_user_str.inversion_efficiency * param_user_str.m_0a * param_user_str.f / param_mr_str.lamda * exp(- t(j) / t1_t_eff);
		F = 2 * param_user_str.inversion_efficiency * param_user_str.m_0a * param_user_str.f * exp(- (t(j) - bolus_time_passed) / t1_t_eff);

		% Calculate tissue magnetization, D(t) of eq [7]
		if(t(j) < current_arrival_time)
			tissue_m(j) = 0;
		end

		if(t(j) >= current_arrival_time && t(j) < current_arrival_time + param_mr_str.tau_b)
			tissue_m(j) = F / R * (exp(R * (t(j) - bolus_time_passed)) - exp(R * param_user_str.tau_t));
		end

		if(t(j) >= current_arrival_time + param_mr_str.tau_b)
			tissue_m(j) = F / R * (exp(R * (param_user_str.tau_t + param_mr_str.tau_b)) - exp(R * param_user_str.tau_t));

		end
	end

end