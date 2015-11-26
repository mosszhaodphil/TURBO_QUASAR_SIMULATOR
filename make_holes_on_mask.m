% This function maks holes on mask based on Euclidean distance
% The input is 



function make_holes_on_mask(input_mask_file)

	output_file = 'out_mask';
	file_extension = '.nii.gz';

	file_handle = load_nii(strcat(input_mask_file, file_extension));

	input_mask_matrix = file_handle.img;

	output_mask_matrix = input_mask_matrix;

	[x, y, z, t] = size(input_mask_matrix);

	% radius of the hole (10 voxels)
	radius = 10;

	% Position of center of the hole (hypoperfusion)
	x_0 = 32;
	y_0 = 46;
	z_0 = 4;

	% Position of center of the hole (hyperperfusion)
	%x_0 = 32;
	%y_0 = 13;
	%z_0 = 4;

	for d = 1 : t
		for c = 1 : z
			for b = 1 : y
				for a = 1 : x

					distance = sqrt((a - x_0) ^ 2 + (b - y_0) ^ 2 + (c - z_0) ^ 2);

					if(distance <= radius)
						output_mask_matrix(a, b, c, d) = 0;

					end

				end

			end

		end

	end

	file_handle.img = output_mask_matrix;
	save_nii(file_handle, strcat(output_file, file_extension));


end

