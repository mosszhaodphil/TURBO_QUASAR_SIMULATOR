% This function plot time series of Crushed ASL Sequence over sampling time

function figure_handle = plot_crushed_signal(crushed_asl_signal, t, varargin)

	figure('visible','off');

	% Condition where the plot is displayed on GUI
	if(length(varargin) > 0)
		current_handles = varargin{1};
		axes(current_handles.axes3);

	end

	ts = timeseries(crushed_asl_signal, t);
	plot(ts, 'Color', 'r'); %plot the curve in red
	xlabel('Time(sec)');
	ylabel('Crushed ASL Signal');
	title('Crushed ASL');
	grid on;
	figure_handle = gcf;
end