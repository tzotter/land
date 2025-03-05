* Do file to be used with inequality.dta from 'Land Reform Revisited: Productivity Gains Amid Inequality Pains'.
* The following code recreates Table [15] in the paper and includes additional robustness checks.
* A brief description of variables is given in the readme.md. Variables with the 'i' prefix include values that
* were interpolated, please see Chapter 3.2 in the paper.

* Load in inequality.dta
use inequality.dta, clear

xtset id year

xtdescribe
	
mata: mata clear  // Clears mata at the beginning
estimates clear   // Clears any stored estimates
eststo clear  // Clears any stored estimates
	
* Table [15]
** Dependent variable: land_gini **
*** Column (1) - OLS Regression with controls $d_{i,t}$ ***
eststo col1: reg land_gini class_lr ln_i_lstock ln_i_fert ln_i_tract i_perarr, robust

*** Column (2) - Column (1) including additional controls $g_{i,t}$ ***
eststo col2: reg land_gini class_lr ln_i_lstock ln_i_fert ln_i_tract i_perarr ln_gdp_pc rule_of_law eduatt population_gr, robust

** Dependent variable: agpop **
*** Column (3) - OLS Regression with controls $d_{i,t}$ ***
eststo col3: reg agpop class_lr ln_i_lstock ln_i_fert ln_i_tract i_perarr, robust

*** Column (4) - Column (3) including additional controls $g_{i,t}$ ***
eststo col4: reg agpop class_lr ln_i_lstock ln_i_fert ln_i_tract i_perarr ln_gdp_pc rule_of_law eduatt population_gr, robust

* Export to LaTeX *
esttab col1 col2 col3 col4 ///
    using "rtable11.tex", replace tex ///
    title("Dependent variable: land_gini & agpop") ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2 F p, labels("Observations" "R-squared" "F-statistic" "Prob > F"))
