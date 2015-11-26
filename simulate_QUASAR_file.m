% cbf_vector = 5 : 5: 320; change alone x direction, 64 elements
% user_vector = 1 : 1 : 64; change along y direction, 64 elements
% aBV_vector = 0.5 : 0.5 : 3.5; change along z direction, 7 elements

% This function create a simulated ASL Nifty file of 64 x 64 x 7 x 13
% The X direction simulates the changes of CBF values
% The Y direction simulates the changes of another parameter
% The Z direction simulates the changes of arterial blood volume (aBV)
% Input:
% cbf_vector: changes of 64 CBF values
% another_param: changes of 64 another parameter
% aBV_vector: changes of 7 aBV values
% Output:
% aBV nifty file (64 x 64 x 7)
% AIF nifty file (64 x 64 x 7 x 13)
% Tissue nifty file (64 x 64 x 7 x 13)

function [abv_matrix aif_matrix tissue_matrix] = simulate_QUASAR_file(cbf_vector, another_param, aBV_vector)

	% Set default parameters
	set_param_basis();
	set_param_user();

	% Load parameters
	load('param_basis.mat');
	load('param_user.mat');

	% Create empty matrices to store results
	%tissue_matrix = zeros(param_mr_str.m, param_mr_str.m, param_mr_str.n_slices, length(param_user_str.t));
	%aif_matrix    = zeros(param_mr_str.m, param_mr_str.m, param_mr_str.n_slices, length(param_user_str.t));
	%abv_matrix    = zeros(param_mr_str.m, param_mr_str.m, param_mr_str.n_slices);

	tissue_matrix = zeros(3, 3, 3, length(param_user_str.t));
	aif_matrix    = zeros(3, 3, 3, length(param_user_str.t));
	abv_matrix    = zeros(3, 3, 3);

	for z = 1 : 3
		load('param_user.mat');
		param_user_str.arterial_blood_volume = aBV_vector(z) / 100; % Update arterial blood volume
		for y = 1 : 3
			% Place to update another parameter
			for x = 1 : 3
				load('param_user.mat');
				param_user_str.f = cbf_vector(x) / 6000; % Update CBF
				save('param_user.mat', 'param_user_str');

				abv_matrix(x, y, z)       = aBV_vector(z); % assign arterial blood volume to its matrix
				aif_matrix(x, y, z, :)    = calculate_delivery_tissue_Buxton(param_user_str.t); % calculate aif signal
				tissue_matrix(x, y, z, :) = calculate_QUASAR_ASL_signal(param_user_str.t); % calculate QUASAR (tissue) signal
			end
		end
	end



end

