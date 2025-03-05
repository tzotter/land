* Do file to be used with reforms.dta from 'Land Reform Revisited: Productivity Gains Amid Inequality Pains'.
* The following code recreates Table [A2] in the paper and includes additional robustness checks.
* Necessary dependencies are: xtdcce2, xthst, and xtnumfac as well as moremata, available from https://github.com/JanDitzen (Last accessed: 24.01.2025).
* A brief description of variables is given in the readme.md. Variables with the 'i' prefix include values that
* were interpolated, please see Chapter 3.2 in the paper.

* Load in reforms.dta
use reforms.dta, clear

xtset id year

xtdescribe
	
mata: mata clear  // Clears mata at the beginning
estimates clear   // Clears any stored estimates
eststo clear  // Clears any stored estimates

* Table [A2]
*** Column (1) -  CCE-MG Estimator using pooled L4.cum_lr ***
eststo col1: xtdcce2 ln_agout L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract, reportc ///
    crosssectional(ln_agout L4.ln_i_lstock ln_i_fert L4.ln_i_tract) pooled(L4.cum_lr)
	
*** Column (2) -  CCE-MG Estimator using pooled L4.mot_cons L4.mot_ten L4.mot_priv ***
eststo col2: xtdcce2 ln_agout L4.mot_cons L4.mot_ten L4.mot_priv L4.ln_i_lstock ln_i_fert L4.ln_i_tract, reportc ///
    crosssectional(ln_agout L4.ln_i_lstock ln_i_fert L4.ln_i_tract) pooled(L4.mot_cons L4.mot_ten L4.mot_priv)
	
*** Column (3) -  Column (1) including additional controls $e_{i,t} + f_{i,t}$ ***
eststo col3: xtdcce2 ln_agout L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr ln_tfr inv_life_expectancy ///
	L4.rule_of_law L4.gov_consumption L4.i_rdensity, reportc ///
	crosssectional(ln_agout L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr ln_tfr inv_life_expectancy L4.rule_of_law L4.gov_consumption L4.i_rdensity) pooled(L4.cum_lr)

*** Column (4) -  Column (2) including additional controls $e_{i,t} + f_{i,t}$ ***
eststo col4: xtdcce2 ln_agout L4.mot_cons L4.mot_ten L4.mot_priv L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr ln_tfr inv_life_expectancy ///
	L4.rule_of_law L4.gov_consumption L4.i_rdensity, reportc ///
	crosssectional(ln_agout L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr ln_tfr inv_life_expectancy L4.rule_of_law L4.gov_consumption L4.i_rdensity) ///
	pooled( L4.mot_cons L4.mot_ten L4.mot_priv)

*** Column (5) -  Column (1) using ln_cereal_yield as a dependent variable ***
eststo col5: xtdcce2 ln_cereal_yield L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract, reportc ///
    crosssectional(ln_cereal_yield L4.ln_i_lstock ln_i_fert L4.ln_i_tract) pooled(L4.cum_lr)

*** Column (6) -  Column (2) using ln_cereal_yield as a dependent variable ***
eststo col6: xtdcce2 ln_cereal_yield L4.mot_cons L4.mot_ten L4.mot_priv L4.ln_i_lstock ln_i_fert L4.ln_i_tract, reportc ///
    crosssectional(ln_cereal_yield L4.ln_i_lstock ln_i_fert L4.ln_i_tract) pooled(L4.mot_cons L4.mot_ten L4.mot_priv)
	
*** Column (7) -  Column (5) including additional controls $e_{i,t} + f_{i,t}$ ***
eststo col7: xtdcce2 ln_cereal_yield L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr ln_tfr inv_life_expectancy ///
	L4.rule_of_law L4.gov_consumption L4.i_rdensity, reportc ///
	crosssectional(ln_cereal_yield L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr ln_tfr inv_life_expectancy L4.rule_of_law L4.gov_consumption L4.i_rdensity) pooled(L4.cum_lr)
	
*** Column (8) -  Column (6) including additional controls $e_{i,t} + f_{i,t}$ ***
eststo col8: xtdcce2 ln_cereal_yield L4.mot_cons L4.mot_ten L4.mot_priv L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr ln_tfr inv_life_expectancy ///
	L4.rule_of_law L4.gov_consumption L4.i_rdensity, reportc ///
	crosssectional(ln_cereal_yield L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr ln_tfr inv_life_expectancy L4.rule_of_law L4.gov_consumption L4.i_rdensity) ///
	pooled(L4.mot_cons L4.mot_ten L4.mot_priv)

**** Column (9) - Column (1) using a regularized CCE ****
// Uses ER Criterion from Ahn and Horenstein (2013) per default
eststo col9: xtdcce2 ln_agout L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract, reportc ///
    crosssectional(ln_agout L4.ln_i_lstock ln_i_fert L4.ln_i_tract, rcce) pooled(L4.cum_lr)
	
*** Column (10) -  Column (2) using a regularized CCE ***
eststo col10: xtdcce2 ln_agout L4.mot_cons L4.mot_ten L4.mot_priv L4.ln_i_lstock ln_i_fert L4.ln_i_tract, reportc ///
    crosssectional(ln_agout L4.ln_i_lstock ln_i_fert L4.ln_i_tract, rcce) pooled(L4.mot_cons L4.mot_ten L4.mot_priv)
	
*** Column (11) -  Column (9) including additional controls $e_{i,t} + f_{i,t}$ ***
eststo col11: xtdcce2 ln_agout L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr ln_tfr inv_life_expectancy ///
	L4.rule_of_law L4.gov_consumption L4.i_rdensity, reportc ///
	crosssectional(ln_agout L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr ln_tfr inv_life_expectancy L4.rule_of_law L4.gov_consumption L4.i_rdensity, rcce) pooled(L4.cum_lr)

*** Column (12) -  Column (10) including additional controls $e_{i,t} + f_{i,t}$ ***
eststo col12: xtdcce2 ln_agout L4.mot_cons L4.mot_ten L4.mot_priv L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr ln_tfr inv_life_expectancy ///
	L4.rule_of_law L4.gov_consumption L4.i_rdensity, reportc ///
	crosssectional(ln_agout L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr ln_tfr inv_life_expectancy L4.rule_of_law L4.gov_consumption L4.i_rdensity, rcce) ///
	pooled(L4.mot_cons L4.mot_ten L4.mot_priv)

*** Column (13) -  Column (9) using ln_cereal_yield as a dependent variable ***
eststo col13: xtdcce2 ln_cereal_yield L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract, reportc ///
    crosssectional(ln_cereal_yield L4.ln_i_lstock ln_i_fert L4.ln_i_tract, rcce) pooled(L4.cum_lr)

*** Column (14) -  Column (10) using ln_cereal_yield as a dependent variable ***
eststo col14: xtdcce2 ln_cereal_yield L4.mot_cons L4.mot_ten L4.mot_priv L4.ln_i_lstock ln_i_fert L4.ln_i_tract, reportc ///
    crosssectional(ln_cereal_yield L4.ln_i_lstock ln_i_fert L4.ln_i_tract, rcce) pooled(L4.mot_cons L4.mot_ten L4.mot_priv)
	
*** Column (15) -  Column (13) including additional controls $e_{i,t} + f_{i,t}$ ***
eststo col15: xtdcce2 ln_cereal_yield L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr ln_tfr inv_life_expectancy ///
	L4.rule_of_law L4.gov_consumption L4.i_rdensity, reportc ///
	crosssectional(ln_cereal_yield L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr ln_tfr inv_life_expectancy L4.rule_of_law L4.gov_consumption L4.i_rdensity, rcce) pooled(L4.cum_lr)
	
*** Column (16) -  Column (14) including additional controls $e_{i,t} + f_{i,t}$ *** 
eststo col16: xtdcce2 ln_cereal_yield L4.mot_cons L4.mot_ten L4.mot_priv L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr ln_tfr inv_life_expectancy ///
	L4.rule_of_law L4.gov_consumption L4.i_rdensity, reportc ///
	crosssectional(ln_cereal_yield L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr ln_tfr inv_life_expectancy L4.rule_of_law L4.gov_consumption L4.i_rdensity, rcce) ///
	pooled(L4.mot_cons L4.mot_ten L4.mot_priv)
	
* Export to LaTeX *
esttab col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12 col13 col14 col15 col16 ///
    using "rtable8.tex", replace tex ///
    title("Dependent variable: ln_agout & ln_cereal_yield") ///
    se star(* 0.10 ** 0.05 *** 0.01)
