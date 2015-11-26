


function plot_saturation_recovey_curve()

	A   = 1.05629;
	g   = 0.767163;
	M0t = 96663.2;
	T1t = 1.84352;

	TI1                = 0.04;
	slice_difference   = 0.035
	z_coord            = 7;
	delta_ti           = 0.60;
	slice_shift_factor = 1;
	actual_TI1         = TI1 + z_coord * slice_difference;
	sampling_rate      = delta_ti / slice_shift_factor;
	ti                 = actual_TI1 : sampling_rate : 6.64;

	FA_norm = degtorad(35);
	delta_g = 0.023;


	FA  = (g + delta_g) * FA_norm;
	T1p = 1 / ( (1 / T1t) - (log( cos(FA) ) / delta_ti));
	M0tp = M0t * (1 - exp(-delta_ti / T1t)) / (1 - cos(FA) * exp(-delta_ti/T1t));

	n_ti = length(ti);

	M0z = zeros(n_ti, 1);

	for i = 1 : n_ti
		%ti
		M0z(i) = M0tp * (1 - A * ( exp(-ti(i) / T1p) ) );
	end



	M0z
	figure;
	plot(M0z);

	hold on;

end

