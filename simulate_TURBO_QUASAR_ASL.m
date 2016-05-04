% This program simulate tissue ASL data from a set of user parameters in param_user.m
% The output is a saved in the folder output_yyyymmdd_HHMMSS under the same directory

close all;
%clear all;

clear variables;

% Program begins

% Set parameters
set_param_basis();
set_param_user();

% Load parameters
load('param_basis.mat');
load('param_user.mat');

date_time_format = 'yyyymmdd_HHMMSS'; % date and time format
date_time_now    = clock; % get vector of current time
date_time        = datestr(date_time_now, date_time_format); % convert current time vector to string
dir_name         = strcat('output_', date_time); % Default directory name

file_name_tissue_gm                   = 'tissue_gm'; % file name to save Tissue ASL signal
file_name_tissue_gm_noise             = 'tissue_gm_noise';
file_name_tissue_wm                   = 'tissue_wm'; % file name to save Tissue ASL signal
file_name_tissue_wm_noise             = 'tissue_wm_noise';
file_name_tissue_pv                   = 'tissue_pv';
file_name_tissue_pv_noise             = 'tissue_pv_noise';
file_name_blood                       = 'arterial_blood'; % file name to save Blood ASL signal
file_name_blood_noise                 = 'arterial_blood_noise';
file_name_aif_gm                      = 'aif_gm';
file_name_aif_wm                      = 'aif_wm';
file_name_aif_pv                      = 'aif_pv';
file_name_aif_pv_noise                = 'aif_pv_noise';
file_name_residue_gm                  = 'residue_gm';
file_name_residue_wm                  = 'residue_wm';
file_name_residue_pv                  = 'residue_pv';
file_name_residue_pv_noise            = 'residue_pv_noise';
file_name_relaxation_gm               = 'relaxation_gm';
file_name_relaxation_wm               = 'relaxation_wm';
file_name_relaxation_pv               = 'relaxation_pv';
file_name_relaxation_pv_noise         = 'relaxation_pv_noise';
file_name_relaxation_product_gm       = 'relaxation_product_gm';
file_name_relaxation_product_wm       = 'relaxation_product_wm';
file_name_relaxation_product_pv       = 'relaxation_product_pv';
file_name_relaxation_product_pv_noise = 'relaxation_product_pv_noise';
file_name_tc_gm                       = 'tc_gm'; % file name to save raw ASl (Tag minus control tc) signal
file_name_tc_wm                       = 'tc_wm'; % file name to save raw ASl (Tag minus control tc) signal
file_name_tc_pv                       = 'tc_pv'; % file name to save raw ASl (Tag minus control tc) signal
file_name_tc_pv_noise                 = 'tc_pv_noise'; % file name to save raw ASl (Tag minus control tc) signal with noise
file_type_txt                         = '.txt'; % text file extension
file_type_nifty                       = '.nii.gz'; % nifty file extension

% Mask and partial volume files
mask = param_user_str.mask;
pvgm = param_user_str.pvgm;
pvwm = param_user_str.pvwm;
abv_mask = param_user_str.abv_mask;


% Three compartment model: arterial blood, GM tissue, and WM tisue.

% 1 Arterial blood compartment
% Simulate Blood ASL signal and save it to file
blood_asl_signal        = zeros(length(param_user_str.t), 1); % construct a vector to store Blood ASL signals at different sampling points specified by variable t
blood_asl_signal        = calculate_delta_M_blood(param_user_str.t); % calculate Blood ASL signal
blood_asl_matrix        = make_4D_matrix(blood_asl_signal, mask); % make 4D matrix to save Blood ASL signal
blood_nifty_file_handle = make_nifty_file(blood_asl_matrix); % make nifty file from Blood ASL signal
blood_asl_figure_handle = plot_blood_signal(blood_asl_signal, param_user_str.t); % plot the signal over time


% 2 GM Tissue Compartment
param_user_str.f     = param_user_str.f_gm;
param_user_str.tau_t = param_user_str.tau_t_gm;
param_user_str.t1_t  = param_user_str.t1_t_gm;
save('param_user.mat', 'param_user_str');


% Simulate GM Tisue ASL signal and save it to file
tissue_gm_asl_signal        = zeros(length(param_user_str.t), 1); % construct a vector to store Tissue ASL signals at different sampling points specified by variable t
tissue_gm_asl_signal        = calculate_delta_M_tissue(param_user_str.t); % calculate Tissue ASL signal
tissue_gm_asl_matrix        = make_4D_matrix(tissue_gm_asl_signal, mask); % make 4D matrix to save Tissue ASL signal
tissue_gm_nifty_file_handle = make_nifty_file(tissue_gm_asl_matrix); % make nifty file from Tissue ASL signal
tissue_gm_asl_figure_handle = plot_tissue_signal(tissue_gm_asl_signal, param_user_str.t); % plot the signal over time


% Simulate GM AIF ASL signal and save it to file
aif_gm_asl_signal        = zeros(length(param_user_str.t), 1); % construct a vector to store AIF signals at different sampling points specified by variable t
aif_gm_asl_signal        = calculate_delivery_tissue_Buxton(param_user_str.t); % calculate AIF signal
aif_gm_asl_matrix        = make_4D_matrix(aif_gm_asl_signal, mask); % make 4D matrix to save AIF ASL signal
aif_gm_nifty_file_handle = make_nifty_file(aif_gm_asl_matrix); % make nifty file from AIF signal
aif_gm_asl_figure_handle = plot_aif_signal(aif_gm_asl_signal, param_user_str.t); % plot the signal over time

% Simulate GM Residue (r(t)) signals and save it to file
residue_gm_asl_signal        = zeros(length(param_user_str.t), 1); % construct a vector to store residue signals at different sampling points specified by variable t
residue_gm_asl_signal        = calculate_residue_r_Buxton(param_user_str.t); % calculate residue signal
residue_gm_asl_matrix        = make_4D_matrix(residue_gm_asl_signal, mask); % make 4D matrix to save residue ASL signal
residue_gm_nifty_file_handle = make_nifty_file(residue_gm_asl_matrix); % make nifty file from residue signal
residue_gm_asl_figure_handle = plot_aif_signal(residue_gm_asl_signal, param_user_str.t); % plot the signal over time

% Simulate GM relaxation (m(t)) signals and save it to file
relaxation_gm_asl_signal        = zeros(length(param_user_str.t), 1); % construct a vector to store relaxation signals at different sampling points specified by variable t
relaxation_gm_asl_signal        = calculate_relaxation_m(param_user_str.t); % calculate relaxation signal
relaxation_gm_asl_matrix        = make_4D_matrix(relaxation_gm_asl_signal, mask); % make 4D matrix to save relaxation ASL signal
relaxation_gm_nifty_file_handle = make_nifty_file(relaxation_gm_asl_matrix); % make nifty file from relaxation signal
relaxation_gm_asl_figure_handle = plot_aif_signal(relaxation_gm_asl_signal, param_user_str.t); % plot the signal over time


% Calculate GM Relaxation product (r(t) * m(t))
relaxation_product_gm_asl_signal        = calculate_relaxation_product(residue_gm_asl_signal, relaxation_gm_asl_signal);
relaxation_product_gm_asl_matrix        = make_4D_matrix(relaxation_product_gm_asl_signal, mask); % make 4D matrix to save relaxation product ASL signal
relaxation_product_gm_nifty_file_handle = make_nifty_file(relaxation_product_gm_asl_matrix); % make nifty file from relaxation product signal
relaxation_product_gm_asl_figure_handle = plot_aif_signal(relaxation_product_gm_asl_signal, param_user_str.t); % plot the signal over time


% Make a raw ASL matrix from crushed and noncrushed signals
% This is equivelant to Label(Tag) minus Control (tc) of raw ASL signal
tc_gm_asl_matrix        = make_raw_QUASAR_matrix(tissue_gm_asl_matrix, blood_asl_matrix, abv_mask);
tc_gm_nifty_file_handle = make_nifty_file(tc_gm_asl_matrix);  % Save raw ASL matrix in nifty file


% 3 WM Tissue Compartment
param_user_str.f     = param_user_str.f_wm;
param_user_str.tau_t = param_user_str.tau_t_wm;
param_user_str.t1_t  = param_user_str.t1_t_wm;
save('param_user.mat', 'param_user_str');

% Simulate WM Tisue ASL signal and save it to file
tissue_wm_asl_signal        = zeros(length(param_user_str.t), 1); % construct a vector to store Tissue ASL signals at different sampling points specified by variable t
tissue_wm_asl_signal        = calculate_delta_M_tissue(param_user_str.t); % calculate Tissue ASL signal
tissue_wm_asl_matrix        = make_4D_matrix(tissue_wm_asl_signal, mask); % make 4D matrix to save Tissue ASL signal
tissue_wm_nifty_file_handle = make_nifty_file(tissue_wm_asl_matrix); % make nifty file from Tissue ASL signal
tissue_wm_asl_figure_handle = plot_tissue_signal(tissue_wm_asl_signal, param_user_str.t); % plot the signal over time

% Simulate WM AIF ASL signal and save it to file
aif_wm_asl_signal        = zeros(length(param_user_str.t), 1); % construct a vector to store AIF signals at different sampling points specified by variable t
aif_wm_asl_signal        = calculate_delivery_tissue_Buxton(param_user_str.t); % calculate AIF signal
aif_wm_asl_matrix        = make_4D_matrix(aif_wm_asl_signal, mask); % make 4D matrix to save AIF ASL signal
aif_wm_nifty_file_handle = make_nifty_file(aif_wm_asl_matrix); % make nifty file from AIF signal
aif_wm_asl_figure_handle = plot_aif_signal(aif_wm_asl_signal, param_user_str.t); % plot the signal over time

% Simulate WM Residue (r(t)) signals and save it to file
residue_wm_asl_signal        = zeros(length(param_user_str.t), 1); % construct a vector to store residue signals at different sampling points specified by variable t
residue_wm_asl_signal        = calculate_residue_r_Buxton(param_user_str.t); % calculate residue signal
residue_wm_asl_matrix        = make_4D_matrix(residue_wm_asl_signal, mask); % make 4D matrix to save residue ASL signal
residue_wm_nifty_file_handle = make_nifty_file(residue_wm_asl_matrix); % make nifty file from residue signal
residue_wm_asl_figure_handle = plot_aif_signal(residue_wm_asl_signal, param_user_str.t); % plot the signal over time

% Simulate WM relaxation (m(t)) signals and save it to file
relaxation_wm_asl_signal        = zeros(length(param_user_str.t), 1); % construct a vector to store relaxation signals at different sampling points specified by variable t
relaxation_wm_asl_signal        = calculate_relaxation_m(param_user_str.t); % calculate relaxation signal
relaxation_wm_asl_matrix        = make_4D_matrix(relaxation_wm_asl_signal, mask); % make 4D matrix to save relaxation ASL signal
relaxation_wm_nifty_file_handle = make_nifty_file(relaxation_wm_asl_matrix); % make nifty file from relaxation signal
relaxation_wm_asl_figure_handle = plot_aif_signal(relaxation_wm_asl_signal, param_user_str.t); % plot the signal over time

% Calculate WM Relaxation product (r(t) * m(t))
relaxation_product_wm_asl_signal        = calculate_relaxation_product(residue_wm_asl_signal, relaxation_wm_asl_signal);
relaxation_product_wm_asl_matrix        = make_4D_matrix(relaxation_product_wm_asl_signal, mask); % make 4D matrix to save relaxation product ASL signal
relaxation_product_wm_nifty_file_handle = make_nifty_file(relaxation_product_wm_asl_matrix); % make nifty file from relaxation product signal
relaxation_product_wm_asl_figure_handle = plot_aif_signal(relaxation_product_wm_asl_signal, param_user_str.t); % plot the signal over time


% Make a raw ASL matrix from crushed and noncrushed signals
% This is equivelant to Label(Tag) minus Control (tc) of raw ASL signal
tc_wm_asl_matrix        = make_raw_QUASAR_matrix(tissue_wm_asl_matrix, blood_asl_matrix, abv_mask);
tc_wm_nifty_file_handle = make_nifty_file(tc_wm_asl_matrix);  % Save raw ASL matrix in nifty file


% Add Partial volume maps to GM and WM tissue signal
tissue_pv_asl_matrix        = add_partial_volume(tissue_gm_asl_matrix, tissue_wm_asl_matrix, pvgm, pvwm);
tissue_pv_nifty_file_handle = make_nifty_file(tissue_pv_asl_matrix);

aif_pv_asl_matrix        = add_partial_volume(aif_gm_asl_matrix, aif_wm_asl_matrix, pvgm, pvwm);
aif_pv_nifty_file_handle = make_nifty_file(aif_pv_asl_matrix);

residue_pv_asl_matrix        = add_partial_volume(residue_gm_asl_matrix, residue_wm_asl_matrix, pvgm, pvwm);
residue_pv_nifty_file_handle = make_nifty_file(residue_pv_asl_matrix);

relaxation_pv_asl_matrix        = add_partial_volume(relaxation_gm_asl_matrix, relaxation_wm_asl_matrix, pvgm, pvwm);
relaxation_pv_nifty_file_handle = make_nifty_file(relaxation_pv_asl_matrix);

relaxation_product_pv_asl_matrix        = add_partial_volume(relaxation_product_gm_asl_matrix, relaxation_product_wm_asl_matrix, pvgm, pvwm);
relaxation_product_pv_nifty_file_handle = make_nifty_file(relaxation_product_pv_asl_matrix);

tc_pv_asl_matrix        = make_raw_QUASAR_matrix(tissue_pv_asl_matrix, blood_asl_matrix, abv_mask);
tc_pv_nifty_file_handle = make_nifty_file(tc_pv_asl_matrix);  % Save raw ASL matrix in nifty file

% Add some noise
snr = param_user_str.snr;
sd  = param_user_str.sd;
blood_asl_noise_matrix        = add_white_noise(blood_asl_matrix, snr, sd);
blood_noise_nifty_file_handle = make_nifty_file(apply_mask(blood_asl_noise_matrix, mask));

aif_pv_asl_noise_matrix        = add_white_noise(aif_pv_asl_matrix, snr, sd);
aif_pv_noise_nifty_file_handle = make_nifty_file(apply_mask(aif_pv_asl_noise_matrix, mask));

tc_pv_asl_noise_matrix        = add_white_noise(tc_pv_asl_matrix, snr, sd);
tc_pv_noise_nifty_file_handle = make_nifty_file(apply_mask(tc_pv_asl_noise_matrix, mask));

tissue_gm_asl_noise_matrix        = add_white_noise(tissue_gm_asl_matrix, snr, sd);
tissue_gm_noise_nifty_file_handle = make_nifty_file(apply_mask(tissue_gm_asl_noise_matrix, mask));

tissue_wm_asl_noise_matrix        = add_white_noise(tissue_wm_asl_matrix, snr, sd);
tissue_wm_noise_nifty_file_handle = make_nifty_file(apply_mask(tissue_wm_asl_noise_matrix, mask));

tissue_pv_asl_noise_matrix        = add_white_noise(tissue_pv_asl_matrix, snr, sd);
tissue_pv_noise_nifty_file_handle = make_nifty_file(apply_mask(tissue_pv_asl_noise_matrix, mask));

residue_pv_asl_noise_matrix = add_white_noise(residue_pv_asl_matrix, snr, sd);
residue_pv_noise_nifty_file_handle = make_nifty_file(apply_mask(residue_pv_asl_noise_matrix, mask));

relaxation_pv_asl_noise_matrix = add_white_noise(relaxation_pv_asl_matrix, snr, sd);
relaxation_pv_noise_nifty_file_handle = make_nifty_file(apply_mask(relaxation_pv_asl_noise_matrix, mask));

relaxation_product_pv_asl_noise_matrix = add_white_noise(relaxation_product_pv_asl_matrix, snr, sd);
relaxation_product_pv_noise_nifty_file_handle = make_nifty_file(apply_mask(relaxation_product_pv_asl_noise_matrix, mask));




% Plot summary curve (4x4) of four signals
%summary_figure_handle = subplot_signal([tissue_asl_signal blood_asl_signal crushed_asl_signal noncrushed_asl_signal], param_user_str.t);





% save parameters of current simulation to parameters.txt file
save_parameters();

% Save simulated ASL data file in the new directory
mkdir(dir_name);
cd(dir_name);


% Arterial blood compartment
dlmwrite(strcat(file_name_blood, file_type_txt), blood_asl_signal); % save blood ASL data to a text file
save_nii(blood_nifty_file_handle, strcat(file_name_blood, file_type_nifty)); % save blood ASL nifty file
save_nii(blood_noise_nifty_file_handle, strcat(file_name_blood_noise, file_type_nifty));
%print(blood_asl_figure_handle, '-dpng', file_name_blood, '-r300'); % save blood ASL signal time series figure


% GM tissue compartment
dlmwrite(strcat(file_name_aif_gm, file_type_txt), aif_gm_asl_signal); % save GM AIF ASL data to a text file
dlmwrite(strcat(file_name_tissue_gm, file_type_txt), tissue_gm_asl_signal); % save GM tissue ASL data to a text file
dlmwrite(strcat(file_name_residue_gm, file_type_txt), residue_gm_asl_signal);
dlmwrite(strcat(file_name_relaxation_gm, file_type_txt), relaxation_gm_asl_signal);
dlmwrite(strcat(file_name_relaxation_product_gm, file_type_txt), relaxation_product_gm_asl_signal);
save_nii(tissue_gm_nifty_file_handle, strcat(file_name_tissue_gm, file_type_nifty)); % save GM tissue ASL nifty file
save_nii(tissue_gm_noise_nifty_file_handle, strcat(file_name_tissue_gm_noise, file_type_nifty)); % save GM tissue noise ASL nifty file
save_nii(aif_gm_nifty_file_handle, strcat(file_name_aif_gm, file_type_nifty)); % save GM AIF ASL nifty file
save_nii(residue_gm_nifty_file_handle, strcat(file_name_residue_gm, file_type_nifty));
save_nii(relaxation_gm_nifty_file_handle, strcat(file_name_relaxation_gm, file_type_nifty));
save_nii(relaxation_product_gm_nifty_file_handle, strcat(file_name_relaxation_product_gm, file_type_nifty));
save_nii(tc_gm_nifty_file_handle, strcat(file_name_tc_gm, file_type_nifty));
%print(tissue_gm_asl_figure_handle, '-dpng', file_name_tissue_gm, '-r300'); % save tissue ASL signal time series figure



% WM tissue compartment
dlmwrite(strcat(file_name_aif_wm, file_type_txt), aif_wm_asl_signal); % save WM AIF ASL data to a text file
dlmwrite(strcat(file_name_tissue_wm, file_type_txt), tissue_wm_asl_signal); % save WM tissue ASL data to a text file
dlmwrite(strcat(file_name_residue_wm, file_type_txt), residue_wm_asl_signal);
dlmwrite(strcat(file_name_relaxation_wm, file_type_txt), relaxation_wm_asl_signal);
dlmwrite(strcat(file_name_relaxation_product_wm, file_type_txt), relaxation_product_wm_asl_signal);
save_nii(tissue_wm_nifty_file_handle, strcat(file_name_tissue_wm, file_type_nifty)); % save WM tissue ASL nifty file
save_nii(tissue_wm_noise_nifty_file_handle, strcat(file_name_tissue_wm_noise, file_type_nifty)); % save GM tissue noise ASL nifty file
save_nii(aif_wm_nifty_file_handle, strcat(file_name_aif_wm, file_type_nifty)); % save WM AIF ASL nifty file
save_nii(residue_wm_nifty_file_handle, strcat(file_name_residue_wm, file_type_nifty));
save_nii(relaxation_wm_nifty_file_handle, strcat(file_name_relaxation_wm, file_type_nifty));
save_nii(relaxation_product_wm_nifty_file_handle, strcat(file_name_relaxation_product_wm, file_type_nifty));
save_nii(tc_wm_nifty_file_handle, strcat(file_name_tc_wm, file_type_nifty));
%print(tissue_gm_asl_figure_handle, '-dpng', file_name_tissue_gm, '-r300'); % save tissue ASL signal time series figure


% PV ASL Signal
save_nii(tissue_pv_nifty_file_handle, strcat(file_name_tissue_pv, file_type_nifty));
save_nii(aif_pv_nifty_file_handle, strcat(file_name_aif_pv, file_type_nifty));
save_nii(residue_pv_nifty_file_handle, strcat(file_name_residue_pv, file_type_nifty));
save_nii(relaxation_pv_nifty_file_handle, strcat(file_name_relaxation_pv, file_type_nifty));
save_nii(relaxation_product_pv_nifty_file_handle, strcat(file_name_relaxation_product_pv, file_type_nifty));
save_nii(tc_pv_nifty_file_handle, strcat(file_name_tc_pv, file_type_nifty));


% Noisy ASL signal
save_nii(tissue_pv_noise_nifty_file_handle, strcat(file_name_tissue_pv_noise, file_type_nifty));
save_nii(aif_pv_noise_nifty_file_handle, strcat(file_name_aif_pv_noise, file_type_nifty));
save_nii(residue_pv_noise_nifty_file_handle, strcat(file_name_residue_pv_noise, file_type_nifty));
save_nii(relaxation_pv_noise_nifty_file_handle, strcat(file_name_relaxation_pv_noise, file_type_nifty));
save_nii(relaxation_product_pv_noise_nifty_file_handle, strcat(file_name_relaxation_pv_noise, file_type_nifty));
save_nii(tc_pv_noise_nifty_file_handle, strcat(file_name_tc_pv_noise, file_type_nifty));

%print(summary_figure_handle, '-dpng', 'summary_plot', '-r300'); % save ASL signal time series figure


% Copy the default files to result directory
%copyfile('../g.nii.gz', '.'); % Copy g file for flip angle correction
%copyfile('../T1t.nii.gz', '.'); % Copy T1 tissue file
%copyfile('../options.txt', '.'); % Copy parameters options file for model based analysis
copyfile(strcat('../', mask, file_type_nifty), '.');
copyfile(strcat('../', pvgm, file_type_nifty), '.');
copyfile(strcat('../', pvwm, file_type_nifty), '.');
copyfile(strcat('../', abv_mask, file_type_nifty), '.');

% Move parameter file to result directory
movefile('../parameters.txt', '.');
% Move TI file to result directory
movefile('../TIs.txt', '.');

% go back to working directory
cd('../');

% delete the binary files
delete('param_basis.mat');
delete('param_user.mat');

% quit matlab program (some machines require this step)
% quit;


