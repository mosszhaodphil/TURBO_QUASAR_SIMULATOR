% This function makes a 4D matrix whose dimension is set by user parameters
% input_vector: timeseries signal of length 13
% mask_file: a mask file to mask the signal
% Output:
% result matrix

function matrix_4D = make_4D_matrix(input_vector, mask_file)

	% Load parameters
	load('param_basis.mat');
	load('param_user.mat');

	% Load the mask matrix
	file_handle = load_nii(strcat(mask_file, '.nii.gz'));
	mask_matrix = file_handle.img;
	[x, y, z] = size(mask_matrix);

	matrix_4D = zeros(x, y, z, length(input_vector));

	% Create 4D matrix by mask
	for i = 1 : x
		for j = 1 : y
			for k = 1 : z
				if(mask_matrix(i, j, k) > 0)

					matrix_4D(i, j, k, :) = input_vector;

				end
			end
		end
	end


end
