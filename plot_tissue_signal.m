% This function plot time series of QUASAR ASL Sequence over sampling time

function figure_handle = plot_quasar_signal(tissue_asl_signal, t, varargin)

	figure('visible','off');

	% Condition where the plot is displayed on GUI
	if(length(varargin) > 0)
		current_handles = varargin{1};
		axes(current_handles.axes1);

	end

	ts = timeseries(tissue_asl_signal, t);
	plot(ts, 'Color', 'b'); % plot the curve in blue
	xlabel('Time(sec)');
	ylabel('Tissue ASL Signal');
	title('Tissue ASL');
	grid on;
	figure_handle = gcf;
end