% This function simulates partial volume ASL data
% Input:
% file_asl_gm: simulated (noise free) GM ASL data nifty file
% file_asl_wm: simulated (noise free) WM ASL data nifty file
% file_pv_gm: GM partial volume map nifty file
% file_pv_wm: WM partial volume map nifty file
% Output:
% 1 Partial volume ASL signal
% 2 Partial volume ASL signal with noise

function pv_matrix = simulate_partial_volume_asl(file_asl_gm, file_asl_wm, file_pv_gm, file_pv_wm)


	file_extension = '.nii.gz';
	file_pv        = 'pv_asltissue';
	file_pv_noise  = 'pv_asltissue_noise';

	snr = 10;

	% Reoriente input files
	reoriente_nifty_file(file_asl_gm);
	reoriente_nifty_file(file_asl_wm);
	reoriente_nifty_file(file_pv_gm);
	reoriente_nifty_file(file_pv_wm);

	% Load files
	asl_gm_handle = load_nii(strcat(file_asl_gm, file_extension));
	asl_wm_handle = load_nii(strcat(file_asl_wm, file_extension));
	pv_gm_handle  = load_nii(strcat(file_pv_gm, file_extension));
	pv_wm_handle  = load_nii(strcat(file_pv_wm, file_extension));

	asl_gm_matrix = asl_gm_handle.img;
	asl_wm_matrix = asl_wm_handle.img;
	pv_gm_matrix  = pv_gm_handle.img;
	pv_wm_matrix  = pv_wm_handle.img;

	[x, y, z, t] = size(asl_gm_matrix);

	pv_matrix       = zeros(x, y, z, t);
	pv_noise_matrix = zeros(x, y, z, t);

	for i = 1 : x
		for j = 1 : y
			for k = 1 : z
				% Extract ASL GM and WM signal of current voxel
				asl_gm_signal = reshape(asl_gm_matrix(i, j, k, :), [t, 1]);
				% asl_gm_signal(:);
				asl_wm_signal = reshape(asl_wm_matrix(i, j, k, :), [t, 1]);
				% asl_wm_signal(:);

				% Create partail volume signal by summing GM and WM signal with their weighting
				pv_signal = pv_gm_matrix(i, j, k) * asl_gm_signal + pv_wm_matrix(i, j, k) * asl_wm_signal;

				% Add some white noise
				pv_singal_noise = add_white_noise(pv_signal, snr);

				% Assign partail volume signal to current voxel
				pv_matrix(i, j, k, :) = pv_signal;
				pv_noise_matrix(i, j, k, :) = pv_singal_noise;

			end
		end
	end

	% Save pv_matrix to a nifty file
	pv_handle       = make_nifty_file(pv_matrix);
	pv_noise_handle = make_nifty_file(pv_noise_matrix);

	save_nii(pv_handle, strcat(file_pv, file_extension));
	save_nii(pv_noise_handle, strcat(file_pv_noise, file_extension));

end
