% This code is the implementation the following papers
% MA Chappell (2012) doi: 10.1002/mrm.24372 (MACQ)
% MA Chappell (2012) doi: 10.1002/mrm.24260 (MACD)
% ET Petersen (2006) doi: 10.1002/mrm.20784 (ETP)
% RB Buxton (1998) doi: 10.1002/mrm.1910400308 (RBB)
% L Ostergaard (1996) doi: 10.1002/mrm.1910360510 (LO)
% J Hrabe (2003) doi:10.1016/j.jmr.2003.11.002 (JH)

% This function calculates ASL signal deltaM of tissue using Buxton's model (RBB)
% The same method is also used in equation [5] of (MACQ)
% delta_M_tissue = 2 * alpha * M0a * f * (c(t) * r(t) * m(t))
% c(t) = exp(-1 / T1a) * a(t)
% a(t) depends on dispersion

% Here we adopt JH's analytical solution to calculate tissue magnetization

function delta_M_tissue = calculate_delta_M_tissue(t)

	load('param_user.mat');
	load('param_basis.mat');

	delta_M_tissue       = zeros(length(t), 1); % ASL signal of tissue
	input_function       = zeros(length(t), 1); % c(t) of (MACQ)
	residue_buxton       = zeros(length(t), 1); % r(t) of (MACQ)
	magnetization_buxton = zeros(length(t), 1); % m(t) of (MACQ)
	residue_product      = zeros(length(t), 1); % r(t) * m(t) of (MACQ)

	bolus_arrived = 0;

	% Check dispersion

	% New parameter param_mr_str.bolus_order

	% No dispersion
	if(param_user_str.dispersion_type == 1)
		while(bolus_arrived < param_mr_str.n_bolus)

			%bolus_time_passed = bolus_arrived * (param_mr_str.tau_b + param_user_str.delta_bolus);
			%bolus_time_passed = bolus_arrived * param_user_str.delta_bolus;
			bolus_time_passed = bolus_arrived * param_user_str.delta_ti;

			% Get the current bolus duration (if current bolus is skipped, then the bolus duration is zero, otherwise it is one)
			current_bolus_duration = param_mr_str.tau_b * param_mr_str.bolus_order(bolus_arrived + 1);

			delta_M_tissue = delta_M_tissue + calculate_M0_tissue_Hrabe_no_dispersion(t, bolus_time_passed, current_bolus_duration);

			bolus_arrived = bolus_arrived + 1;
		end
	end


	% calculate c(t)
	%input_function = calculate_delivery_tissue_Buxton(t);
	%input_function_matrix = convert_to_low_tri(input_function); % create a lower triangular matrix as in eq[11] of (LO)

	% calculate r(t)
	%residue_buxton = calculate_residue_r_Buxton(t);

	% calculate m(t)
	%magnetization_buxton = calculate_relaxation_m(t);

	% calculate r(t) * m(t) element by element multiplication
	%residue_product = residue_buxton .* magnetization_buxton;

	% calculate convolution (first length(t) number of elements)
	%convolution_result = param_mr_str.delta_ti * input_function_matrix * residue_product;

	% calculate ASL signal
	% delta_M_tissue = 2 * param_user_str.inversion_efficiency * param_user_str.m_0a * param_user_str.f * convolution_result;
	%delta_M_tissue = 2 * param_user_str.inversion_efficiency * param_user_str.m_0a * param_user_str.f * convolution_result;

end

