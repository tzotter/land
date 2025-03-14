* Do file to be used with reforms.dta from 'Land Reform Revisited: Productivity Gains Amid Inequality Pains'.
* The following code recreates Table [8] in the paper and includes additional robustness checks.
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

* Table [8]
** Dependent variable: ln_cereal_yield **
*** Column (1) - Fixed-Effects (FE) OLS with an indicator variable for time and controls $d_{i,t}$ ***
eststo col1: xtreg ln_cereal_yield L4.cum_class_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract i.year, fe vce(cluster id)

*** Column (2) - Including controls $e_{i,t}$ ***
eststo col2: xtreg ln_cereal_yield L4.cum_class_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr i.year, fe vce(cluster id)

*** Column (3) - Including additional controls from Barro (2003), namely $f_{i,t}$ ***
eststo col3: xtreg ln_cereal_yield L4.cum_class_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract ///
    i_perarr ln_tfr inv_life_expectancy L4.rule_of_law ///
    L4.gov_consumption i.year, fe vce(cluster id)

*** Column (4) - Including control for road density ***
eststo col4: xtreg ln_cereal_yield L4.cum_class_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract ///
    i_perarr ln_tfr inv_life_expectancy L4.rule_of_law ///
    L4.gov_consumption L4.i_rdensity i.year, fe vce(cluster id)

*** Column (5) - GLS with AR(1), heteroscedasticity in the error structure and an indicator variable for time ***
eststo col5: xtgls ln_cereal_yield L4.cum_class_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract i.year, panels(hetero) corr(ar1)

*** Column (6) - Including controls $e_{i,t}$ ***
eststo col6: xtgls ln_cereal_yield L4.cum_class_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr plqi i.year, panels(hetero) corr(ar1)

*** Column (7) - Including additional controls from Barro (2003), namely $f_{i,t}$ ***
eststo col7: xtgls ln_cereal_yield L4.cum_class_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract ///
    i_perarr plqi ln_tfr inv_life_expectancy L4.rule_of_law ///
    L4.gov_consumption i.year, panels(hetero) corr(ar1)

*** Column (8) - Including control for road density ***
eststo col8: xtgls ln_cereal_yield L4.cum_class_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract ///
    i_perarr plqi ln_tfr inv_life_expectancy L4.rule_of_law ///
    L4.gov_consumption L4.i_rdensity i.year, panels(hetero) corr(ar1)

* Export to LaTeX *
esttab col1 col2 col3 col4 col5 col6 col7 col8 ///
    using "rtable5.tex", replace tex ///
    title("Dependent variable: ln_cereal_yield") ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    drop(*year*)
