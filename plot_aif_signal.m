% This function plot time series of QUASAR AIF (c(t)) Sequence over sampling time

function figure_handle = plot_aif_signal(aif_asl_signal, t, varargin)

	figure('visible','off');

	% Condition where the plot is displayed on GUI
	if(length(varargin) > 0)
		current_handles = varargin{1};
		axes(current_handles.axes1);

	end

	ts = timeseries(aif_asl_signal, t);
	plot(ts, 'Color', 'c'); % plot the curve in cyan
	xlabel('Time(sec)');
	ylabel('AIF ASL Signal');
	title('AIF ASL');
	grid on;
	figure_handle = gcf;
end