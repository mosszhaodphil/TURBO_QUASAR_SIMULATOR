% This function adds white noise to signal
% We add noise to each time point of the signal with same standard deviation
% The noisy data has the same snr in each time series
% Input parameters:
% input_signal: noise free signal (vector or 4D)
% snr: signal to noise ratio
% sd: standard deviation
% Output:
% noisy_signal: noisy signal (vector or 4D)

function noisy_signal = add_white_noise(input_signal, snr, sd)
	


	% Check dimension
	% Vector
	if(ndims(input_signal) == 1)
		%noisy_signal = awgn(input_signal, snr, 'measured');
		noisy_signal = input_signal + ( sd ./ snr .* randn(size(input_signal)) );

		% define mean of input signal to be the maximum signal intensity
		mu = max(input_signal);
		sd = mu ./ snr;

		% noise has zero mean and same standard deviation at each TI because it is background noise
		% The random noise must follow a normal distribution with zero mean and sd
		noisy_signal = input_signal + sd * randn(input_signal);
	end

	% 4D matrix
	if(ndims(input_signal) == 4)
		[x, y, z, t] = size(input_signal);

		noisy_signal = zeros(x, y, z, t);

		for i = 1 : x
			for j = 1 : y
				for k = 1 : z
					% Get noise free signal
					noise_free_signal = reshape(input_signal(i, j, k, :), [t, 1]);

					% Add noise
					%noise_signal = awgn(noise_free_signal, snr, 'measured');
					%noise_signal = noise_free_signal + ( snr / sd * randn(size(noise_free_signal)) );

					% define mean of input signal to be the maximum signal intensity
					mu = max(noise_free_signal);
					sd = mu ./ snr;

					% noise has zero mean and same standard deviation at each TI because it is background noise
					% The random noise must follow a normal distribution with zero mean and sd
					noise_signal = noise_free_signal + sd * randn(size(noise_free_signal));

					% Assign noisy signal to new matrix
					noisy_signal(i, j, k, :) = noise_signal;

				end
			end
		end
	end

end

