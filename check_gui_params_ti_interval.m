% This function checks if the input string from GUI is a valid TI interval

function result = check_gui_params_ti_interval(input_object)

	try
		input_string = get(input_object, 'String');
		ti = eval(input_string);
		result = 1;
	catch
		msgbox('Invalid TI');
		result = 0;
	end

end