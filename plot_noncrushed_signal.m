% This function plot time series of Noncrushed ASL Sequence over sampling time

function figure_handle = plot_noncrushed_signal(noncrushed_asl_signal, t, varargin)

	figure('visible','off');

	% Condition where the plot is displayed on GUI
	if(length(varargin) > 0)
		current_handles = varargin{1};
		axes(current_handles.axes4);

	end

	ts = timeseries(noncrushed_asl_signal, t);
	plot(ts, 'Color', 'g'); % plot the curve in green
	xlabel('Time(sec)');
	ylabel('Noncrushed ASL Signal');
	title('Noncrushed ASL');
	grid on;
	figure_handle = gcf;
end