n_phase=6
asl_file --data=tc_gm --ntis=$n_phase --ibf=tis --iaf=diff --split=asl_diff_phase_

# Get tissue component
fslmaths asl_diff_phase_000 -add asl_diff_phase_001 -add asl_diff_phase_003 -add asl_diff_phase_004 -div 4 asl_tissue
# Get arterial blood component
fslmaths asl_diff_phase_002 -add asl_diff_phase_005 -div 2 asl_blood_and_tissue
fslmaths asl_blood_and_tissue -sub asl_tissue asl_blood

# Arterial blood component
fabber --data=asl_blood --data-order=singlefile --output=full_vb_blood -@ fabber_options_dynamic_1_vb_blood.txt
# Calibration
fslmaths full_vb_blood/mean_fblood -div 0.91 full_vb_blood/ABV



# Tissue Component
# Step 1
fabber --data=asl_tissue --data-order=singlefile --output=full_vb_tissue_step1 -@ fabber_tissue_options_step_1.txt
# Update MVN
mvntool --input=full_vb_tissue_step1/finalMVN --output=full_vb_tissue_step1/finalMVN2 --mask=mask_brain --param=3 --new --val=1 --var=1
# Step 2
fabber --data=asl_tissue --data-order=singlefile --output=full_vb_tissue_step2 -@ fabber_tissue_options_step_2.txt --continue-from-mvn=full_vb_tissue_step1/finalMVN2
# Calibration
fslmaths full_vb_tissue_step2/mean_ftiss -mul 6000 -div 0.91 full_vb_tissue_step2/CBF


# Estimate in one go
#fabber --data=asl_tissue --data-order=singlefile --output=full_vb_tissue_all -@ fabber_tissue_options_all.txt
# Calibration
#fslmaths full_vb_tissue_all/mean_ftiss -mul 6000 -div 0.91 full_vb_tissue_all/CBF


# Fit all six component together in two steps
# Step 1 - only infer CBF and arrival time
fabber --data=tc_gm --data-order=singlefile --output=full_vb_blood_and_tissue_step1 -@ fabber_blood_and_tissue_options_all_step_1.txt
# Update MVN to infer tau
mvntool --input=full_vb_blood_and_tissue_step1/finalMVN --output=full_vb_blood_and_tissue_step1/finalMVN2 --mask=mask_brain --param=3 --new --val=1 --var=1
# Step 2 - only infer CBF, arrival time, and bolus duration
fabber --data=tc_gm --data-order=singlefile --output=full_vb_blood_and_tissue_step2 -@ fabber_blood_and_tissue_options_all_step_2.txt --continue-from-mvn=full_vb_blood_and_tissue_step1/finalMVN2
# Calibration
fslmaths full_vb_blood_and_tissue_step2/mean_ftiss -mul 6000 -div 0.91 full_vb_blood_and_tissue_step2/CBF

# Fit six component together in one go
fabber --data=tc_gm --data-order=singlefile --output=fabber_blood_and_tissue_options_all_100 -@ fabber_blood_and_tissue_options_all_100.txt
# Calibration
fslmaths full_vb_blood_and_tissue_100/mean_ftiss -mul 6000 -div 0.91 full_vb_blood_and_tissue_100/CBF
fslmaths full_vb_blood_and_tissue_100/mean_fblood -div 0.91 full_vb_blood_and_tissue_100/ABV




d_TI=0.6
# Rescale bolus duration due to tanh(x) function
#(d_ti * 0.5) * (tanh(tauset) + 1);
# calculate Hyperbolic function tanh(x)
# tanh(x)=(exp(2x) - 1) / (exp(2x) + 1)
# Two step method
fslmaths full_vb_tissue_step2/mean_tautiss -mul 2 -exp -sub 1 full_vb_tissue_step2/numerator
fslmaths full_vb_tissue_step2/mean_tautiss -mul 2 -exp -add 1 full_vb_tissue_step2/denominator
fslmaths full_vb_tissue_step2/numerator -div full_vb_tissue_step2/denominator full_vb_tissue_step2/tanh
fslmaths full_vb_tissue_step2/tanh -add 1 -mul $d_TI -mul 0.5 full_vb_tissue_step2/mean_tautiss_true
# One step method
#fslmaths full_vb_tissue_all/mean_tautiss -mul 2 -exp -sub 1 full_vb_tissue_all/numerator
#fslmaths full_vb_tissue_all/mean_tautiss -mul 2 -exp -add 1 full_vb_tissue_all/denominator
#fslmaths full_vb_tissue_all/numerator -div full_vb_tissue_all/denominator full_vb_tissue_all/tanh
#fslmaths full_vb_tissue_all/tanh -add 1 -mul $d_TI -mul 0.5 full_vb_tissue_all/mean_tautiss_true


# All six phases
# Two step method
fslmaths full_vb_blood_and_tissue_step2/mean_tautiss -mul 2 -exp -sub 1 full_vb_blood_and_tissue_step2/numerator
fslmaths full_vb_blood_and_tissue_step2/mean_tautiss -mul 2 -exp -add 1 full_vb_blood_and_tissue_step2/denominator
fslmaths full_vb_blood_and_tissue_step2/numerator -div full_vb_blood_and_tissue_step2/denominator full_vb_blood_and_tissue_step2/tanh
fslmaths full_vb_blood_and_tissue_step2/tanh -add 1 -mul $d_TI -mul 0.5 full_vb_blood_and_tissue_step2/mean_tautiss_true
# One step method
fslmaths full_vb_blood_and_tissue_100/mean_tautiss -mul 2 -exp -sub 1 full_vb_blood_and_tissue_100/numerator
fslmaths full_vb_blood_and_tissue_100/mean_tautiss -mul 2 -exp -add 1 full_vb_blood_and_tissue_100/denominator
fslmaths full_vb_blood_and_tissue_100/numerator -div full_vb_blood_and_tissue_100/denominator full_vb_blood_and_tissue_100/tanh
fslmaths full_vb_blood_and_tissue_100/tanh -add 1 -mul $d_TI -mul 0.5 full_vb_blood_and_tissue_100/mean_tautiss_true

