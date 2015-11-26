#!/bin/bash
datafile=$1

# Use basil to do model fitting
basil -i $datafile -m pvmask_z3 -o output --pgm pvgm_z3 --pwm pvwm_z3 --fast -@ basil_pv_simulation_options.txt 

# Rescale and mask GM CBF
fslmaths pvgm_z3 -bin gm_mask
fslmaths ./output/step1/mean_ftiss -mul 6000 -div 0.91 -mas gm_mask estimated_cbf_gm
#fslmaths estimated_cbf_gm -mas gm_mask estimated_cbf_gm

# Rescale and mask WM CBF
fslmaths pvwm_z3 -bin wm_mask
fslmaths ./output/step1/mean_fwm -mul 6000 -div 0.91 -mas wm_mask estimated_cbf_wm
#fslmaths estimated_cbf_wm -mas wm_mask estimated_cbf_wm

echo 'Finish'