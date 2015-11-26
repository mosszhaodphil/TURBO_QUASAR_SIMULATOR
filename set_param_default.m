% This function sets default value to user parameters

function [] = set_param_default(handles)

	set(handles.et_cbf, 'String', '32'); % Cerebral Blood Flow
	set(handles.et_abv, 'String', '1.5'); % Arterial Blood Volume
	set(handles.et_tau_t, 'String', '1.2'); % Bolus arrival time of tissue voxel
	set(handles.et_tau_m, 'String', '1.0'); % Bolus arrival time to microvasculature
	set(handles.et_t1_t, 'String', '1.3'); % T1 relaxation of tissue
	set(handles.et_t1_a, 'String', '1.6'); % T1 relaxation of arterial blood
	set(handles.et_ti, 'String', '0.04 : 0.30 : 3.64'); % Inversion time (TI)

end
