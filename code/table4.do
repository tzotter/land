* Do file to be used with reforms.dta from 'Land Reform Revisited: Productivity Gains Amid Inequality Pains'.
* The following code recreates Table [4] in the paper and includes additional robustness checks.
* Necessary dependencies are: xtserial, xtqptest, and xtreg.
* A brief description of variables is given in the readme.md. Variables with the 'i' prefix include values that
* were interpolated, please see Chapter 3.2 in the paper.

* Load in reforms.dta
use reforms.dta, clear

xtset id year

xtdescribe
	
mata: mata clear  // Clears mata at the beginning
estimates clear   // Clears any stored estimates
eststo clear  // Clears any stored estimates

* Testing for autocorrelation *
xtserial ln_agout cum_lr ln_i_lstock ln_i_fert ln_i_tract // Wooldridge-Drukker test
xtqptest ln_agout cum_lr ln_i_lstock ln_i_fert ln_i_tract, force // Born-Breitung test

xtserial ln_agout propoor proefficiency ln_i_lstock ln_i_fert ln_i_tract // Wooldridge-Drukker test
xtqptest ln_agout propoor proefficiency ln_i_lstock ln_i_fert ln_i_tract, force // Born-Breitung test

xtserial ln_agout cum_lr ln_i_lstock ln_i_fert ln_i_tract i_perarr i_rdensity // Wooldridge-Drukker test
xtqptest ln_agout cum_lr ln_i_lstock ln_i_fert ln_i_tract i_perarr i_rdensity, force // Born-Breitung test

xtserial ln_agout propoor proefficiency ln_i_lstock ln_i_fert ln_i_tract i_perarr i_rdensity // Wooldridge-Drukker test
xtqptest ln_agout propoor proefficiency ln_i_lstock ln_i_fert ln_i_tract i_perarr i_rdensity, force // Born-Breitung test

xtserial ln_agout cum_lr ln_i_lstock ln_i_fert ln_i_tract i_perarr i_rdensity ln_tfr inv_life_expectancy rule_of_law gov_consumption // Wooldridge-Drukker test
xtqptest ln_agout cum_lr ln_i_lstock ln_i_fert ln_i_tract i_perarr i_rdensity ln_tfr inv_life_expectancy rule_of_law gov_consumption, force // Born-Breitung test

xtserial ln_agout propoor proefficiency ln_i_lstock ln_i_fert ln_i_tract i_perarr i_rdensity ln_tfr inv_life_expectancy rule_of_law gov_consumption // Wooldridge-Drukker test
xtqptest ln_agout propoor proefficiency ln_i_lstock ln_i_fert ln_i_tract i_perarr i_rdensity ln_tfr inv_life_expectancy rule_of_law gov_consumption, force // Born-Breitung test

* Table [4]
** Dependent variable: ln_agout **
*** Column (1) - Fixed-Effects (FE) OLS with an indicator variable for time and controls $d_{i,t}$ ***
eststo col1: xtreg ln_agout L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract i.year, fe
eststo fe1

*** Column (2) - Column (1) excluding interpolated values ***
eststo col2: xtreg ln_agout L4.cum_lr L4.ln_lstock ln_fert L4.ln_tract i.year if L4.ln_lstock !=. & ln_fert !=. & L4.ln_tract !=., fe
eststo fe2

*** Column (3) - Fixed-Effects (FE) OLS with an indicator variable for time and controls $d_{i,t}$ ***
eststo col3: xtreg ln_agout L4.propoor L4.proefficiency L4.ln_i_lstock ln_i_fert L4.ln_i_tract i.year, fe
eststo fe3

*** Column (4) - Column (1) including additional controls, namely $e_{i,t} + f_{i,t}$ ***
eststo col4: xtreg ln_agout L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract ///
    i_perarr ln_tfr inv_life_expectancy L4.rule_of_law ///
    L4.gov_consumption L4.i_rdensity i.year, fe
eststo fe4

*** Column (5) - Column (2) including additional controls, namely $e_{i,t} + f_{i,t}$ ***
eststo col5: xtreg ln_agout L4.propoor L4.proefficiency L4.ln_i_lstock ln_i_fert L4.ln_i_tract ///
    i_perarr ln_tfr inv_life_expectancy L4.rule_of_law ///
    L4.gov_consumption L4.i_rdensity i.year, fe
eststo fe5

*** Column (6) - Random-Effects (RE) OLS with an indicator variable for time and controls $d_{i,t}$ ***
eststo col6: xtreg ln_agout L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract i.year, re
eststo re6

hausman fe1 re6 // Durbin-Wu-Hausman-Test

*** Column (7) - Random-Effects (RE) OLS with an indicator variable for time and controls $d_{i,t}$  ***
eststo col7: xtreg ln_agout L4.propoor L4.proefficiency L4.ln_i_lstock ln_i_fert L4.ln_i_tract i.year, re
eststo re7

hausman fe3 re7 // Hausman test

*** Column (8) - Column (6) including additional controls, namely $e_{i,t} + f_{i,t}$ ***
eststo col8: xtreg ln_agout L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract ///
    i_perarr plqi ln_tfr inv_life_expectancy L4.rule_of_law ///
    L4.gov_consumption L4.i_rdensity i.year, re
eststo re8

hausman fe4 re8 // Durbin-Wu-Hausman-Test

*** Column (9) - Including control for road density ***
eststo col9: xtreg ln_agout L4.propoor L4.proefficiency L4.ln_i_lstock ln_i_fert L4.ln_i_tract ///
    i_perarr plqi ln_tfr inv_life_expectancy L4.rule_of_law ///
    L4.gov_consumption L4.i_rdensity i.year, re
eststo re9

hausman fe5 re9 // Durbin-Wu-Hausman-Test

* Export to LaTeX *
esttab col1 col2 col3 col4 col5 col6 col7 col8 col9 ///
    using "rtable1.tex", replace tex ///
    title("Dependent variable: ln_agout") ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    drop(*year*)
