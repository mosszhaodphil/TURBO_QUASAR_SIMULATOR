% This function checks if the input string from GUI is a valid number

function result = check_gui_params_number(input_object)

	input_string = get(input_object, 'String');
	if(isnan(str2double(input_string)))
		result = 0; % Input is NOT a valid number
		msgbox('Input paramter must be a number.');
	else
		result = 1; % Input is a valid number
	end

end