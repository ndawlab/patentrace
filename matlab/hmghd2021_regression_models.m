% load data
load("hmghd2021_data.mat")

% these aren't yet zscored in saved file
ds1.lsasZ = zscore(ds1.lsasZ)
ds2.lsasZ = zscore(ds2.lsasZ)

% SI table 1 compares strategy usage to that of previous findings and Nash eq. baseline

% SI 2 is summary statistics for the parameters in prmerged

% SI table 3a (EWA, Expt 1, N = 412, DOF = 409)
 
tbl2a_beta_glm = fitglm(pr1_phirho,'beta ~ 1 + lsasZ + iqZ ');
tbl2a_beta_ci = coefCI(tbl2a_beta_glm);
 
tbl2a_alpha_glm = fitglm(pr1_phirho,'alpha ~ 1 + lsasZ + iqZ ');
tbl2a_alpha_ci = coefCI(tbl2a_alpha_glm);
 
tbl2a_w_glm = fitglm(pr1_phirho,'w ~ 1 + lsasZ + iqZ ');
tbl2a_w_ci = coefCI(tbl2a_w_glm);
 

% SI table 3b (EWA, Expt 2, N = 331, DOF = 328)
 
tbl2b_beta_glm = fitglm(pr2_phirho,'beta ~ 1 + lsasZ + iqZ ');
tbl2b_beta_ci = coefCI(tbl2b_beta_glm);
 
tbl2b_alpha_glm = fitglm(pr2_phirho,'alpha ~ 1 + lsasZ + iqZ ');
tbl2b_alpha_ci = coefCI(tbl2b_alpha_glm);
 
tbl2b_w_glm = fitglm(pr2_phirho,'w ~ 1 + lsasZ + iqZ ');
tbl2b_w_ci = coefCI(tbl2b_w_glm);
 
% SI table 4: comparing effect by experiment

exptcomp = fitglm(prmerged,'w ~ (1 + lsasZ + iqZ) * exp ')
exptcompCI = coefCI(expcomp)

% SI table 5: these data frames are not included yet

% SI table 5a (one-back EWA, Expt 1, N = 412, DOF = 409)

%tbl3a_w_hat_glm = fitglm(pr1_1back,'w_hat ~ 1 + lsasZ + iqZ');
%tbl3a_w_hat_ci = coefCI(tbl3a_w_hat_glm);
 
% SI table 5b (one-back EWA, Expt 2, N = 331, DOF = 328)

%tbl3b_w_hat_glm = fitglm(pr2_1back,'w_hat ~ 1 + lsasZ + iqZ');
%tbl3b_w_hat_ci = coefCI(tbl3b_w_hat_glm);
 
% SI table 5c (one-back EWA, Expts 1 & 2, N = 743, DOF = 740)

%tbl3c_w_hat_glm = fitglm(prmerged_1back,'w_hat ~ 1 + lsasZ + iqZ');
%tbl3c_w_hat_ci = coefCI(tbl3c_w_hat_glm);


% SI table 6a  (valenced EWA, Expt 1, N = 412, DOF = 409)
 
tbl4a_beta_bi_glm = fitglm(pr1_phirho,'beta_bi ~ 1 + lsasZ + iqZ ');
tbl4a_beta_bi_ci = coefCI(tbl4a_beta_bi_glm);
 
tbl4a_alpha_bi_glm = fitglm(pr1_phirho,'alpha_bi ~ 1 + lsasZ + iqZ ');
tbl4a_alpha_bi_ci = coefCI(tbl4a_alpha_bi_glm);
 
tbl4a_wplus_glm = fitglm(pr1_phirho,'wplus ~ 1 + lsasZ + iqZ ');
tbl4a_wplus_ci = coefCI(tbl4a_wplus_glm);
 
tbl4a_wminus_glm = fitglm(pr1_phirho,'wminus ~ 1 + lsasZ + iqZ ');
tbl4a_wminus_ci = coefCI(tbl4a_wminus_glm);
 
% SI table 6b  (valenced EWA, Expt 2, N = 331, DOF = 328)
 
tbl4b_beta_bi_glm = fitglm(pr2_phirho,'beta_bi ~ 1 + lsasZ + iqZ ');
tbl4b_beta_bi_ci = coefCI(tbl4b_beta_bi_glm);
 
tbl4b_alpha_bi_glm = fitglm(pr2_phirho,'alpha_bi ~ 1 + lsasZ + iqZ ');
tbl4b_alpha_bi_ci = coefCI(tbl4b_alpha_bi_glm);
 
tbl4b_wplus_glm = fitglm(pr2_phirho,'wplus ~ 1 + lsasZ + iqZ ');
tbl4b_wplus_ci = coefCI(tbl4b_wplus_glm);
 
tbl4b_wminus_glm = fitglm(pr2_phirho,'wminus ~ 1 + lsasZ + iqZ ');
tbl4b_wminus_ci = coefCI(tbl4b_wminus_glm);
 
% SI table 7 w+ vs w-

% mixed-effects models - 'val' is dummy var coding w+ vs. w- 

% note: 
%       - matlab's default calculation of DOF is consistently wrong (red flag: DOF > number of observations/subjects!)  
%       - submit fitlme.m output to fixedEffects.m, anova.m, or coefCI.m specifying satterhwaite method ('DFMethod', 'satterhwaite') to estimate DOF properly 


% pr1, (lsasZ:valence, Expt 1, N = 412)
pr1_val_lsasZ_lme = fitlme(ds1,'dubs ~ 1 + val + lsasZ + iqZ + val:lsasZ + val:iqZ  + (1 + val + val:lsasZ + val:iqZ|sub)');
[~,~,pr1_val_lsasZ_stats] = fixedEffects(pr1_val_lsasZ_lme,'alpha',0.05,'DFMethod','satterthwaite');


% pr2, (lsasZ:valence, Expt 2, N = 331) 
pr2_val_lsasZ_lme = fitlme(ds2,'dubs ~ 1 + val + lsasZ + iqZ + val:lsasZ + val:iqZ  + (1 + val + val:lsasZ + val:iqZ|sub)');
[~,~,pr2_val_lsasZ_stats] = fixedEffects(pr2_val_lsasZ_lme,'alpha',0.05,'DFMethod','satterthwaite');


 % SI table 8 (valenced EWA, Expt 2, N = 331, DOF = 326)
 
tbl5_beta_bi_glm = fitglm(pr2_phirho,'beta_bi ~ 1 + f1 + f2 + f3 + iqZ ');
tbl5_beta_bi_ci = coefCI(tbl5_beta_bi_glm);
 
tbl5_alpha_bi_glm = fitglm(pr2_phirho,'alpha_bi ~ 1 + f1 + f2 + f3 + iqZ ');
tbl5_alpha_bi_ci = coefCI(tbl5_alpha_bi_glm);
 
tbl5_wplus_glm = fitglm(pr2_phirho,'wplus ~ 1 + f1 + f2 + f3 + iqZ ');
tbl5_wplus_ci = coefCI(tbl5_wplus_glm);
 
tbl5_wminus_glm = fitglm(pr2_phirho,'wminus ~ 1 + f1 + f2 + f3 + iqZ ');
tbl5_wminus_ci = coefCI(tbl5_wminus_glm);

% SI table 9 (w+ vs w- by factors)
% pr2, (factor3:valence, Expt 2, N = 331, DOF(satterthwaite) = ) 

pr2_val_f3_lme = fitlme(ds2,'dubs ~ 1 + val + f1 + f2 + f3 + iqZ + val:f1 + val:f2 + val:f3+ val:iqZ  + (1 + val + val:f1 + val:f2 + val:f3 + val:iqZ|sub)');
[~,~,pr2_val_f3_stats] = fixedEffects(pr2_val_f3_lme,'alpha',0.05,'DFMethod','satterthwaite');
)
