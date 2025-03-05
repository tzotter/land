* Do file to be used with reforms.dta from 'Land Reform Revisited: Productivity Gains Amid Inequality Pains'.
* The following code recreates Table [10] in the paper and includes additional robustness checks.
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

* Table [10]
** Dependent variable: ln_agout **
*** Column (1) -  rCCE-Pooled-MG Estimator using pooled L4.mot_ceil ***
eststo col1: xtdcce2 ln_agout L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract, reportc ///
    crosssectional(ln_agout L4.ln_i_lstock ln_i_fert L4.ln_i_tract, rcce) pooled(L4.mot_ceil)
	
*** Column (2) -  Column (1) including additional controls $e_{i,t} ***
eststo col2: xtdcce2 ln_agout L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr L4.i_rdensity, reportc ///
	crosssectional(ln_agout L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr L4.i_rdensity, rcce) pooled(L4.mot_ceil)
	
*** Column (3) -  Column (2) including additional controls $e_{i,t} + f_{i,t}$ ***
eststo col3: xtdcce2 ln_agout L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr ln_tfr inv_life_expectancy ///
	L4.rule_of_law L4.gov_consumption L4.i_rdensity, reportc ///
	crosssectional(ln_agout L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr ln_tfr inv_life_expectancy L4.rule_of_law L4.gov_consumption L4.i_rdensity, rcce) pooled(L4.mot_ceil)
	
** Dependent variable: ln_cereal_yield **
*** Column (4) - rCCE-Pooled-MG Estimator using pooled L4.mot_ceil ***
eststo col4: xtdcce2 ln_cereal_yield L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract, reportc ///
    crosssectional(ln_cereal_yield L4.ln_i_lstock ln_i_fert L4.ln_i_tract, rcce) pooled(L4.mot_ceil)
	
*** Column (5) -  Column (1) including additional controls $e_{i,t} ***
eststo col5: xtdcce2 ln_cereal_yield L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr L4.i_rdensity, reportc ///
	crosssectional(ln_cereal_yield L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr L4.i_rdensity, rcce) pooled(L4.mot_ceil)
	
*** Column (6) -  Column (2) including additional controls $e_{i,t} + f_{i,t}$ ***
eststo col6: xtdcce2 ln_cereal_yield L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr ln_tfr inv_life_expectancy ///
	L4.rule_of_law L4.gov_consumption L4.i_rdensity, reportc ///
	crosssectional(ln_cereal_yield L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr ln_tfr inv_life_expectancy L4.rule_of_law L4.gov_consumption L4.i_rdensity, rcce) pooled(L4.mot_ceil)

* Export to LaTeX *
esttab col1 col2 col3 col4 col5 col6 ///
    using "rtable9.tex", replace tex ///
    title("Dependent variable: ln_agout & ln_cereal_yield") ///
    se star(* 0.10 ** 0.05 *** 0.01)
