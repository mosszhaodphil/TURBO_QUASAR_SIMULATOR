% This function reoirente the incoming nifty file to standard orientation
% Input: nifty file name (without extension)
% Output: reoriented nifty file (same name)


function reoriente_nifty_file(file_name)

	file_extension = '.nii.gz';
	file_handle = load_nii(strcat(file_name, file_extension));
	file_matrix = file_handle.img;
	new_file_handle = make_nifty_file(file_matrix);
	save_nii(new_file_handle, strcat(file_name, file_extension));

end
