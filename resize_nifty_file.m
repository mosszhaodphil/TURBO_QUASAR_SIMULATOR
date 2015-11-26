% This function resize the nifty file
% The voxels in the new file is the same
% Input:
% file_old: old nifty file (1x1x1xt)
% x, y, z: new dimension
% Output:
% new nifty file of the same name


function [] = resize_nifty_file(file_old, x, y, z);

	% Copy old file name to new file name
	file_new = file_old;

	% Load matrix in old nifty file
	file_extension = '.nii.gz';
	handle_old = load_nii(strcat(file_old, file_extension));
	matrix_old = handle_old.img;

	% Get the dimension of old nifty file
	[x_old, y_old, z_old, t] = size(matrix_old);

	% Create new nifty file
	matrix_new = zeros(x, y, z, t);
	
	% Duplicate values to new nifty file
	for i = 1 : x
		for j = 1 : y
			for k = 1 : z
				matrix_new(i, j, k, :) = matrix_old(x_old, y_old, z_old, :);
			end
		end
	end

	% Save the new nifty file
	handle_new = make_nifty_file(matrix_new);
	save_nii(handle_new, strcat(file_new, file_extension));
end
