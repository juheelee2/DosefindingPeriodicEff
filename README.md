# DosefindingPeriodicEff
A Bayesian design for a phase I-II clinical trial to find an optimal dose based on periodic and continuous monitoring of disease status and the times to tox and death.


STEP 1: download R package file: DosefindingPeriodicEff_1.0.tar.gz
STEP 2: the package is installed, do not need to install again.
install.packages("DosefindingPeriodicEff_1.0.tar.gz", repos = NULL, type="source")
library("DosefindingPeriodicEff")

The package has a function which performs posterior simulations and provides the following.
1. Posterior expected utilities for doses
2. Acceptability binary indicator for each dose (1: Acceptable, 0: Not acceptable).
3. The last sample of the random parameters

output <- MCMC_Dose_Finding_Periodic_Eff(hpara, current_data, J, K, L, M, zeta_bar, p_star, dose, accp_chk, follow_up, utility, ini_sam, n_sam, n_burn)

The function, MCMC_Dose_Finding_Periodic_Eff, takes inputs
1. hpara: a list of the fixed hyperparameter values
2. current data: the most updated clinical outcomes data
3. J: the number of outcomes, in our example trial, we have outcomes, PD, Toxicity and Death, so J=3
4. K: the number of categories of disease status, in our example trial, we have four categories, PD, SD, PR, CR, so K=4
5. L: the number of scheduled times for disease status, in our example trial, we have two scheduled monitoring of disease status by imaging, so L=2
6. M: the number of doses, in our example trial, we have four doses considered, so M=4
7. zeta_bar: the elicited upper limit on the probability of an outcome occurrence for the acceptability check.  Since we have three outcomes, it is a 3-dim vector
8. p_star: fixed cut-off probability for the acceptability check
9. dose: a M-dim vector of standardized doses
10. accp_chk: binary indictor for acceptability check.  If accp_chk=0, do not conduct the acceptability check and let all doses acceptable. If accp_chk=1, conduct the acceptability check.
11. follow_up: a J-dim vector of the lengths of the follow-up period for the outcomes. in our example trial, we have (84, 84, 84).
12. utility: a vectorized utility.  An example is given in Table 1 of the paper
13. ini_sam: the initial values of the random parameters to run MCMC
14. n_sam: the number of samples that will be used for the inference such as expected utility computation and acceptability checking
15. n_burn: the number of samples that will be discarded.  So in total, we draw N_sam + N_burn samples of the random parameters from the posterior distribution.

The function returns
1. $Tab_Safety: a M-dim binary indicator vector (1: Acceptable, 0: Not acceptable)
2. $Exp_Ut: a M-dim vector of posterior expected utility estimates
3. $cur_sam: the last MCMC sample of the random parameters.


