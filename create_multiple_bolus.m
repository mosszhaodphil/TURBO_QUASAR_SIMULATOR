% This function creates multiple boluses based on the first bolus signal and interval between different boluses
% Input parameters:
% aif_signal: vector that represents the AIF signal (only one bolus)
% time_gap: time (in millisecond) between each successive bolus
% n_bolus: total number of boluses



function create_multiple_bolus(aif_signal, time_gap, n_bolus)

	% total number of TIs available to create AIF signal
	n_ti = size(aif_signal);

	non_zero_signal = aif_signal;
	non_zero_signal(find(non_zero_signal == 0)) = [];

	i = 1; % iterator at each TI

	while(i <= n_ti)




		i = i + 1;
	end


end
