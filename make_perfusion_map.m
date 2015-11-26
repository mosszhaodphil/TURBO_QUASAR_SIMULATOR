
function make_perfusion_map(value)

	handle = load_nii('perfusion.nii.gz');
	haha = handle.img;

	[x, y, z] = size(haha);

	for i = 1 : x
		for j = 1 : y
			for k = 1 : z
				if haha(i, j, k) > 0

					haha(i, j, k) = value;

				end
			end
		end
	end

	handle.img = haha;
	save_nii(handle, strcat('perfusion_gm_', num2str(value),'.nii.gz'));

end

