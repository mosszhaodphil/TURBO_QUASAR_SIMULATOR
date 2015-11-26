% This function calculate the arterial blood signal
% It is smoothed to facilitate FABBER model fitting
% The same technique is used in fwdmodel_asl_quasar.cc

function input_signal = calculate_arterial_signal_smooth(t)

	load('param_user.mat');
	load('param_basis.mat');

	input_signal  = zeros(length(t), 1);

	delta_t_blood = param_user_str.tau_m;
	tau = param_mr_str.tau_b;

	for j = 1 : length(t)

		t1_a_eff = correct_t1a_look_locker(t(j));

		if (t(j) < delta_t_blood)
			input_signal(j) = exp(-delta_t_blood / t1_a_eff) * (0.98 * exp( (t(j) - delta_t_blood) / 0.05)  +  0.02 * t(j) / delta_t_blood  );

		elseif ((t(j) >= delta_t_blood) && (t(j) < delta_t_blood + tau))
			input_signal(j) = exp(-t(j) / t1_a_eff);

		elseif (t(j) >= delta_t_blood + tau)
			input_signal(j) = exp(-(delta_t_blood + tau) / t1_a_eff) * (0.98 * exp(-(t(j) - delta_t_blood - tau) / 0.05)  +  0.02 * (1 - (t(j) - delta_t_blood - tau) / 0.05) );
			
			if(input_signal(j) < 0)
				input_signal(j) = 0;
			end
		else
			% do nothing at the moment

		end % end if else
	
	end

end
