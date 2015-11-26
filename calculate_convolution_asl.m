% This code is the implementation the following papers
% MA Chappell (2012) doi: 10.1002/mrm.24372 (MACQ)
% MA Chappell (2012) doi: 10.1002/mrm.24260 (MACD)
% ET Petersen (2006) doi: 10.1002/mrm.20784 (ETP)
% RB Buxton (1998) doi: 10.1002/mrm.1910400308 (RBB)
% L Ostergaard (1996) doi: 10.1002/mrm.1910360510 (LO)

% This function calculate the numerical convolution of two vectors
% The dimension (m) of the vectors must be the same
% The function returns the first m elements of the convolution (calculated by MATLAB library functionconv) result
% This method is the same with algebraic approach to calculate convolution, eq [11] of (LO).

function result_vector = calculate_convolution_asl(vector_1, vector_2)
	full_result = conv(vector_1, vector_2);

	result_vector = full_result(1 : length(vector_1));

end

