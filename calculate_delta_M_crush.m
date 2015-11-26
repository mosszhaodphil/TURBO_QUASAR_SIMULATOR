% This code is the implementation the following papers
% MA Chappell (2012) doi: 10.1002/mrm.24372 (MACQ)
% MA Chappell (2012) doi: 10.1002/mrm.24260 (MACD)
% ET Petersen (2006) doi: 10.1002/mrm.20784 (ETP)

% This function calculates summation of ASL signal in tissue and blood when crusher gradient is on
% crush_efficienty is the percentage of ASL signal of arterial blood removed

function delta_M_crush = calculate_delta_M_crush(t)

	load('param_user.mat');
	load('param_basis.mat');

	delta_M_tissue = calculate_delta_M_tissue(t);
	delta_M_blood  = calculate_delta_M_blood(t);

	delta_M_crush = delta_M_tissue + param_user_str.crush_efficiency * delta_M_blood;

end