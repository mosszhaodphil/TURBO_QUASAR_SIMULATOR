close all
clear

% This code is the implementation the following papers
% MA Chappell (2012) doi: 10.1002/mrm.24372 (MACQ)
% MA Chappell (2012) doi: 10.1002/mrm.24260 (MACD)
% ET Petersen (2006) doi: 10.1002/mrm.20784 (ETP)

% Variables
% MRI scan variables
n_slices    = 4; % total number of slices (ETP)
n_scans     = 40; % 40 control/label scan pairs (ETP)
n_acq       = 18; % number of acquisition time points (ETP)
slide_gap   = 2; % slide gap of 2mm (ETP)
m           = 64; % dimension of matrix 64x64 (ETP)
fov         = 240; % field of view 240mm (ETP)
flip_angle  = 2 * pi / 360 * 30; % flip angle of 30 degrees (ETP)
tr          = 4; % repitition time 4000ms (ETP)
te          = 0.023; % echo time 23ms (ETP)
ti1         = 0.05; % TI1 or labeling delay of 50ms, figre 2 (ETP)
delta_ti    = 0.2; % interval between excitation pulses, figure 2 (ETP)
tau_b       = 1.05; % bolus duration time (ETP)
tau_s       = 2.25; % bolus saturation duration time (ETP)
gap         = 30; % slice inversion gap (ETP)
width_in_sl = 150; % inversion slab width (ETP)
v_enc       = [3]; % velocity of bipolar gradients at 3cm/s (ETP)
lamda       = 0.9; % blood tissue partition coefficient (ETP)

% save the these variables in a file
filename = 'param_basis.mat';
save(filename);