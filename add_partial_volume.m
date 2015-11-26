% This function creates partial volume ASL signal
% Input:
% asl_gm_matrix: simulated (noise free) GM ASL matrix
% asl_wm_matrix: simulated (noise free) WM ASL matrix
% file_pv_gm: GM partial volume map nifty file
% file_pv_wm: WM partial volume map nifty file
% Output:
% partial volume ASL signal matrix

function pv_matrix = add_partial_volume(asl_gm_matrix, asl_wm_matrix, file_pv_gm, file_pv_wm)


	file_extension = '.nii.gz';

	% Reoriente input files
	reoriente_nifty_file(file_pv_gm);
	reoriente_nifty_file(file_pv_wm);

	% Load files
	pv_gm_handle  = load_nii(strcat(file_pv_gm, file_extension));
	pv_wm_handle  = load_nii(strcat(file_pv_wm, file_extension));

	pv_gm_matrix  = pv_gm_handle.img;
	pv_wm_matrix  = pv_wm_handle.img;

	[x, y, z, t] = size(asl_gm_matrix);

	pv_matrix = zeros(x, y, z, t);

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

				% Assign partail volume signal to current voxel
				pv_matrix(i, j, k, :) = pv_signal;

			end
		end
	end

end
