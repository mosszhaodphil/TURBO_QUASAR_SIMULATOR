% This code is the implementation the following papers
% MA Chappell (2012) doi: 10.1002/mrm.24372 (MACQ)
% MA Chappell (2012) doi: 10.1002/mrm.24260 (MACD)
% ET Petersen (2006) doi: 10.1002/mrm.20784 (ETP)

% This function calculates the delivery function c(t) of Buxton's model
% c(t) = exp(-t / t1_a)
function delivery_Buxton = calculate_delivery_Buxton(t, bolus_time_passed)

	load('param_basis.mat');
	load('param_user.mat');

	delivery_Buxton = zeros(length(t), 1);

	current_arrival_time = bolus_time_passed + param_user_str.tau_t;

	% calculate deliver function c(t), eq [5] (MACQ)
	for j = 1 : length(t)
		% Calculate effective T1 of arterial blood with eq [11] of (MACQ)
		t1_a_eff = correct_t1a_look_locker(t(j) - bolus_time_passed);

		%delivery_Buxton(j) = exp((-t(j)) / param_user_str.t1_a);
		%delivery_Buxton(j) = exp((-t(j)) / t1_a_eff);

		%{
		if(t(j) < current_arrival_time)
			delivery_Buxton(j) = 0; % residue function values remains zero

		elseif (( t(j) >= current_arrival_time ) && (t(j) < current_arrival_time + param_mr_str.tau_b))
			delivery_Buxton(j) = exp((- (t(j) - bolus_time_passed) ) / t1_a_eff);
		
		elseif (t(j) >= current_arrival_time + param_mr_str.tau_b)
			delivery_Buxton(j) = 0;
		
		else
			% do nothing at the moment

		end % end if else
		%}
	
		if(t(j) < bolus_time_passed)
			delivery_Buxton(j) = 0;

		else if(t(j) >= bolus_time_passed)
			delivery_Buxton(j) = exp((- (t(j) - bolus_time_passed) ) / t1_a_eff);
		else
			% do nothing
		end
		
	end

end

