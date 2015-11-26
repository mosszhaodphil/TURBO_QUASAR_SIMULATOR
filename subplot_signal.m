% This function plot a YY curve (two y axis) of QUASAR ASL Sequence over sampling time
% Input argument:
% signal_matrix: concatenated matrix of ASL signal vectors
% signal_matrix(1): first column is QUASAR ASL signal
% signal_matrix(2): second column is Crushed ASL signal
% signal_matrix(3): third column is Noncrushed ASL signal
% t: sampling time

function figure_handle = subplot_signal(signal_matrix, t)

	figure('visible','off'); % not display the figure during drawing
	y_axis_range = [0 0.006]; % Y axis range of plots

	% Plot QUASAR (Tissue) Curve
	subplot(2, 2, 1);
	quasar_curve = plot(t, signal_matrix(:, 1), 'Color', 'b');
	ylim(y_axis_range);
	xlabel('Time(sec)');
	ylabel('Signal');
	title('Tissue signal');
	grid on;
	hold on;

	% Plot Blood Curve
	subplot(2, 2, 2);
	noncrushed_curve = plot(t, signal_matrix(:, 2), 'Color', 'm');
	ylim(y_axis_range);
	xlabel('Time(sec)');
	ylabel('Signal');
	title('Blood signal');
	grid on;
	hold on;

	% Plot Crushed ASL Curve
	subplot(2, 2, 3);
	crushed_curve = plot(t, signal_matrix(:, 3), 'Color', 'r');
	ylim(y_axis_range);
	xlabel('Time(sec)');
	ylabel('Signal');
	title('Crushed ASL signal');
	grid on;
	hold on;

	% Plot Noncrushed ASL Curve
	subplot(2, 2, 4);
	noncrushed_curve = plot(t, signal_matrix(:, 4), 'Color', 'g');
	ylim(y_axis_range);
	xlabel('Time(sec)');
	ylabel('Signal');
	title('Noncrushed ASL signal');
	grid on;
	hold on;

	figure_handle = gcf; % return the figure handle
	
end
