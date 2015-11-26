



function masked_4D_matrix = apply_mask(input_4D_matrix, mask_file) 

	file_extension = '.nii.gz';
	file_handle = load_nii(strcat(mask_file, file_extension));
	mask_matrix = file_handle.img;

	masked_4D_matrix = input_4D_matrix;

	[x, y, z, t] = size(input_4D_matrix);

	for i = 1 : x
		for j = 1 : y
			for k = 1 : z
				if(mask_matrix(i, j, k) <= 0)

					tmp_signal = reshape(masked_4D_matrix(i, j, k, :), [t, 1]);
					tmp_signal(:) = 0;
					masked_4D_matrix(i, j, k, :) = tmp_signal;
				end
			end
		end
	end

end
