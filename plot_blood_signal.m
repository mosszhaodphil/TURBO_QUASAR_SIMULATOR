% This function plot time series of Blood ASL Sequence over sampling time

function figure_handle = plot_blood_signal(blood_asl_signal, t, varargin)

	figure('visible','off');

	% Condition where the plot is displayed on GUI
	if(length(varargin) > 0)
		current_handles = varargin{1};
		axes(current_handles.axes2);

	end

	ts = timeseries(blood_asl_signal, t);
	plot(ts, 'Color', 'm'); % plot the curve in magenta
	xlabel('Time(sec)');
	ylabel('Blood ASL Signal');
	title('Blood ASL');
	grid on;
	figure_handle = gcf;
end