% This function resets the GUI to its initial state
% Clear all plots
% Assign default values to parameters

function [] = reset_gui(handles)

	% Clear all plots
	cla(handles.axes1, 'reset');
	cla(handles.axes2, 'reset');
	cla(handles.axes3, 'reset');
	cla(handles.axes4, 'reset');

	% Set default parameters
	set_param_default(handles);


end

