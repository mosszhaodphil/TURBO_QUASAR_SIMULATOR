% This function plot a YY curve (two y axis) of QUASAR ASL Sequence over sampling time
% Input argument:
% signal_matrix: concatenated matrix of ASL signal vectors
% signal_matrix(1): first column is QUASAR ASL signal
% signal_matrix(2): second column is Crushed ASL signal
% signal_matrix(3): third column is Noncrushed ASL signal
% t: sampling time

function figure_handle = plot_signal_yy(signal_matrix, t)

	figure('visible','off'); % not display the figure during drawing

	[h_ax, quasar_curve, signal_curve] = plotyy(t, signal_matrix(:, 1), t, signal_matrix(:, 2:3)); % plot yy graph

	% Left Y axis represents QUASAR ASL data
	ylabel(h_ax(1), 'QUASAR ASL Signal'); % add left y axis label
	set(h_ax(1), 'YLim', [0 0.0025]); % set left y axis range
	set(h_ax(1), 'YTick', [0 : 0.0005 : 0.0025]); % set left y axis tick. Same interval with right y axis
	set(h_ax(1), 'ycolor', 'k'); % set left y axis color to be black

	% Right Y axis represents Crushed and Noncrushed ASL data
	ylabel(h_ax(2), 'Crushed / Noncrushed ASL Signal'); % add right y axis label
	set(h_ax(2), 'YLim', [0 1]); % set right y axis range
	set(h_ax(2), 'YTick', [0 : 0.2 : 1]); % set right y axis tick. Same interval with left y axis
	set(h_ax(2), 'ycolor', 'k'); % set right y axis color to be black

	xlabel('t(sec)'); % add x axis label

	legend([quasar_curve; signal_curve], 'QUASAR ASL Curve', 'Crushed ASL Curve', 'Noncrushed ASL Curve'); % add legend
	title('QUASAR ASL Sequence'); % add title
	figure_handle = gcf; % return the figure handle
	
end
