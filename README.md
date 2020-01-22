# DosefindingPeriodicEff
A Bayesian design for a phase I-II clinical trial to find an optimal dose based on periodic and continuous monitoring of disease status and the times to tox and death.  The R package implements posterior computation of the model in the paper, "A Phase I-II Design Based On Periodic and Continuous Monitoring of Disease Status and the Times to Toxicity and Death" by Lee, Thall and Msaouel (2020+).  We also post examples of fixed hyperparameter values, clinical outcome data collected for statistical inferences and initial values of the random parameters.  


### ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) R package: DosefindingPeriodicEff_1.0.tar.gz
STEP 1: download R package file: DosefindingPeriodicEff_1.0.tar.gz

STEP 2: install the package

STEP 3: load the package into your R workspace

> install.packages("DosefindingPeriodicEff_1.0.tar.gz", repos = NULL, type="source")

> library("DosefindingPeriodicEff")'


The package has a function which performs posterior simulations and provides the following.
1. Posterior expected utilities for doses
2. Acceptability binary indicator for each dose (1: Acceptable, 0: Not acceptable).
3. The last sample of the random parameters

> output <- MCMC_Dose_Finding_Periodic_Eff(hpara, current_data, J, K, L, M, zeta_bar, p_star, dose, accp_chk, follow_up, utility, ini_sam, n_sam, n_burn)

The function, MCMC_Dose_Finding_Periodic_Eff, takes inputs
1. hpara: a list of the fixed hyperparameter values. An example of hpara is included as a separate .RData file (hyper-parameters.RData).
2. current data: the most updated clinical outcomes data An example of current_data is included as a separate .RData file (current_data.RData).
3. J: the number of outcomes, in our example trial, we have outcomes, PD, Toxicity and Death, so J=3
4. K: the number of categories of disease status, in our example trial, we have four categories, PD, SD, PR, CR, so K=4
5. L: the number of scheduled times for disease status, in our example trial, we have two scheduled monitoring of disease status by imaging, so L=2
6. M: the number of doses, in our example trial, we have four doses considered, so M=4
7. zeta_bar: the elicited upper limit on the probability of an outcome occurrence for the acceptability check.  Since we have three outcomes, it is a 3-dim vector
8. p_star: fixed cut-off probability for the acceptability check
9. dose: a M-dim vector of standardized doses
10. accp_chk: binary indictor for acceptability check.  If accp_chk=0, do not conduct the acceptability check and let all doses acceptable. If accp_chk=1, conduct the acceptability check.
11. follow_up: a J-dim vector of the lengths of the follow-up period for the outcomes. in our example trial, we have (84, 84, 84).
12. utility: a vectorized utility.  An example is given in Table 1 of the paper. 
13. ini_sam: the initial values of the random parameters to run MCMC. An example of ini_sam is included as a separate .RData file (ini_sam.RData).
14. n_sam: the number of samples that will be used for the inference such as expected utility computation and acceptability checking
15. n_burn: the number of samples that will be discarded.  So in total, we draw N_sam + N_burn samples of the random parameters from the posterior distribution.

** An example of the trial parameters such as J, K, L etc is included in a separate .R file (Trial-parameters.R)

The function returns
1. $Tab_Safety: a M-dim binary indicator vector (1: Acceptable, 0: Not acceptable)
2. $Exp_Ut: a M-dim vector of posterior expected utility estimates
3. $cur_sam: the last MCMC sample of the random parameters.


### ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) hyper-parameters.RData: an example of fixed hyperparameters to fit the model
The elicited fixed hyperparameter values that used for the simulations in the paper are included as .RData for your use.  You may modify for your own trial.

### ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) current_data.RData: an example of current data to make posterior inferences
It illusrates an example of the current data to fit the model with function, MCMC_Dose_Finding_Periodic_Eff. 
1. N_t: the number of patients who recieved a treatment at trial time t.
2. dose: a N_t-dim vector of the doses that the patients were treated at.
3. t_star: a N_t*2 matrix of t_star (scheduled times for imaging)
4. Y_obs: times to events, N_t*3 matrix of continuous times, where time to death in column 1, time to severe toxicity in column 2, and times to continous PD in column 3.
5. delta: N_t*3 matrix of binary censoring indicators. Similar to Y_obs, time to death in column 1, time to severe toxicity in column 2, and times to continous PD in column 3.
6. Z_obs: N_t*2 matrix of disease status categories from imaging, where each element takes 0 (PD), 1 (SD), 2 (PR), 3 (CR), and -100 (no imaging is done).
7. ind_PD: a N_t-dim binary indicator vector, where PD is observed from continuous monitoring by signs and symptoms.  


### ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) ini_sam.RData: an example of initial values of the random parameters
It illusrates an example of initial values of the random parameters to fit the model with function, MCMC_Dose_Finding_Periodic_Eff. 

### ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) trial-parameters.R: includes trial parameters such as J, K, M etc, that are needed to run a trial.


### ![#f03c15](https://placehold.it/15/f03c15/000000?text=+)  To execute an example of the posterior inference, 

Step 1: load all .RData files into your R workspace, 

> load("current_data.RData"); load("hyper-parameters.RData"); load("ini_sam.RData")

Step 2: load all trial parameters, 

> source("Trial-parameters.R")

Step 3: specify MCMC parameters, n_sam and n_burn, e.g.;

> n_sam <- 3000; n_burn <- 3000

Step 4: call the function, MCMC_Dose_Finding_Periodic_Eff  

> output <- MCMC_Dose_Finding_Periodic_Eff(hpara, current_data, J, K, L, M, zeta_bar, p_star, dose, accp_chk, follow_up, utility, ini_sam, n_sam, n_burn)
