


function correct_asl_control()

	file_handle = load_nii('aslcontrol_dynamic_1.nii.gz');

	data_matrix = file_handle.img;

	[x, y, z, t] = size(data_matrix);

	for i = 1 : x
		for j = 1 : y
			for k = 1 : z
				for m = 1 : t

					if(mod(m, 11) == 6)

						average = (data_matrix(i, j, k, m - 1) + data_matrix(i, j, k, m + 1)) / 2;

						data_matrix(i, j, k, m) = average;

					end


				end
			end
		end
	end

	file_handle.img = data_matrix;
	save_nii(file_handle, 'aslcontrol_dynamic_1_corr.nii.gz');

end

