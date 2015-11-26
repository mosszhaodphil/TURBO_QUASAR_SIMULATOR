% This function saves the parameters of the current situation to a text file


function [] = save_parameters()

	load('param_basis.mat');
	load('param_user.mat');

	format bank;

	file_handle = fopen('parameters.txt', 'wt');

	fprintf(file_handle, '****************************\n');
	fprintf(file_handle, 'Simulation Parameters\n');
	fprintf(file_handle, '****************************\n\n');

	fprintf(file_handle, 'GM CBF: %.2f \n', param_user_str.f_gm * 6000);
	fprintf(file_handle, 'WM CBF: %.2f \n', param_user_str.f_wm * 6000);
	fprintf(file_handle, 'ABV: %.2f%% \n', param_user_str.arterial_blood_volume * 100);
	fprintf(file_handle, 'Bolus duration: %.2f \n', param_mr_str.tau_b);
	fprintf(file_handle, 'Bolus Arrival Time GM Tissue: %.2f \n', param_user_str.tau_t_gm);
	fprintf(file_handle, 'Bolus Arrival Time WM Tissue: %.2f \n', param_user_str.tau_t_wm);
	fprintf(file_handle, 'Bolus Arrival Time Arterial Blood: %.2f \n', param_user_str.tau_m);
	fprintf(file_handle, 'T1 GM Tissue: %.2f \n', param_user_str.t1_t_gm);
	fprintf(file_handle, 'T1 WM Tissue: %.2f \n', param_user_str.t1_t_wm);
	fprintf(file_handle, 'T1 Arterial Blood: %.2f \n', param_user_str.t1_a);
	fprintf(file_handle, 'T1 GM Tissue Corrected (Look-Locker): %.2f \n', param_user_str.t1_t_gm_correct);
	fprintf(file_handle, 'T1 WM Tissue Corrected (Look-Locker): %.2f \n', param_user_str.t1_t_wm_correct);
	fprintf(file_handle, 'T1 Arterial Blood Corrected (Look-Locker): %.2f \n', param_user_str.t1_a_correct);
	fprintf(file_handle, 'M0 Arterial blood: %.2f \n', param_user_str.m_0a);
	fprintf(file_handle, 'Inversion efficiency: %.2f \n', param_user_str.inversion_efficiency);
	fprintf(file_handle, 'Blood tissue partition coefficient: %.2f \n', param_mr_str.lamda);
	
	fprintf(file_handle, '\n');

	fprintf(file_handle, 'Flip angle norm: %.2f \n', radtodeg(param_mr_str.flip_angle));
	fprintf(file_handle, 'Flip angle corrected: %.2f \n', radtodeg(param_mr_str.flip_angle_correct));
	fprintf(file_handle, 'Flow suppression angle phi: %.2f \n', radtodeg(param_mr_str.phi));
	fprintf(file_handle, 'Flow suppression angle theta: %.2f \n', radtodeg(param_mr_str.theta));
	fprintf(file_handle, 'g: %.2f \n', param_mr_str.g);
	fprintf(file_handle, 'delta_g: %.4f \n', param_mr_str.delta_g);

	fprintf(file_handle, '\n');

	fprintf(file_handle, 'Mask file: %s\n', strcat(param_user_str.mask, '.nii.gz'));
	fprintf(file_handle, 'GM PV Map file: %s\n', strcat(param_user_str.pvgm, '.nii.gz'));
	fprintf(file_handle, 'WM PV Map file: %s\n', strcat(param_user_str.pvwm, '.nii.gz'));
	fprintf(file_handle, 'ABV Mask file: %s\n', strcat(param_user_str.abv_mask, '.nii.gz'));

	fprintf(file_handle, '\n');

	fprintf(file_handle, 'SNR: %d\n', param_user_str.snr);
	%fprintf(file_handle, 'Standard deviation: %.6f \n', param_user_str.sd);
	fprintf(file_handle, 'Total number of bolus(es): %d\n', param_mr_str.n_bolus);
	fprintf(file_handle, 'Delta TI: %.2f \n', param_user_str.delta_ti);
	fprintf(file_handle, 'Number of delta TI between each successive bolus: %d\n', param_user_str.delta_ti_gap_factor);
	fprintf(file_handle, 'Time gap between each successive bolus: %.2f\n', param_user_str.delta_bolus);
	fprintf(file_handle, 'Slice shifting: %d\n', param_user_str.slice_shifting_factor);
	fprintf(file_handle, 'Actual sampling rate: %.2f\n', param_user_str.actual_sampling_rate);

	fprintf(file_handle, '\n');

	fprintf(file_handle, 'Inversion Time (TI): %.2f \n', param_user_str.t);

	fprintf(file_handle, '\n');
	
	[m, n_tis] = size(param_user_str.t); % we only need the second parameter n_tis: total number of TIs

	for i = 1 : n_tis
		fprintf(file_handle, '--ti%d=%.2f ', i, param_user_str.t(i));
	end

	fprintf(file_handle, '\n\n');
	fprintf(file_handle, '****************************\n');
	fprintf(file_handle, 'End\n');
	fprintf(file_handle, '****************************\n');

	fclose(file_handle);

end
