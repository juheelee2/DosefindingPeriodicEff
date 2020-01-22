N_max <- 60 ##  max # of patients
J <- 3   ## # of outcomes  -- Death, Tox and PD
K <- 4   ## # of disease status categories -- PD, SD, PR and CR
L <- 2   ## # of prescheduled imaging

### lengths of the followup period in days
follow_up <- c(84, 84, 84)

## raw doses and standardized doses
raw_dose <- c(60, 80, 120, 150)
dose <- scale(raw_dose)[,1]
M <- length(std_dose) ## # of doses

### utility table
utility <- array(NA, dim=c(11, 3))
utility[,1] <- c(20, 35, 45, 50, 70, 45, 60, 80, 35, 35, 85) ### first 11 for Tox in (0, 42] (column 1)
utility[,2] <- c(30, 40, 50, 55, 75, 50, 65, 85, 40, 40, 90) ###  next 11 for Tox in (42, 84] (column 2)
utility[,3] <- c(45, 50, 60, 65, 85, 60, 75, 95, 50, 50, 100) ### last 11 for Tox > 84 (colum 3)

### for acceptability check
#P( prob of death > zeta_bar ) < p_star
zeta_bar <- c(0.30, 0.40, 0.70) ## death, tox & PD
p_star <- rep(0.80, M)

