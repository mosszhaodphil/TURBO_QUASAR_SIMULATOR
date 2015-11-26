% This code is the implementation the following papers
% MA Chappell (2012) doi: 10.1002/mrm.24372 (MACQ)
% MA Chappell (2012) doi: 10.1002/mrm.24260 (MACD)
% ET Petersen (2006) doi: 10.1002/mrm.20784 (ETP)

% This function calculates summation of ASL signal in tissue and blood when crusher gradient is off

function delta_M_noncrush = calculate_delta_M_noncrush(t)

	load('param_user.mat');
	load('param_basis.mat');
	
	delta_M_tissue = calculate_delta_M_tissue(t);
	delta_M_blood  = calculate_delta_M_blood(t);

	delta_M_noncrush = delta_M_tissue + delta_M_blood;

end