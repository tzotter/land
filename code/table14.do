* Do file to be used with inequality.dta from 'Land Reform Revisited: Productivity Gains Amid Inequality Pains'.
* The following code recreates Table [14] in the paper and includes additional robustness checks.
* A brief description of variables is given in the readme.md. Variables with the 'i' prefix include values that
* were interpolated, please see Chapter 3.2 in the paper.

* Load in inequality.dta
use inequality.dta, clear

xtset id year

xtdescribe
	
mata: mata clear  // Clears mata at the beginning
estimates clear   // Clears any stored estimates
eststo clear  // Clears any stored estimates
	
* Table [14]
** Dependent variable: land_gini **
*** Column (1) - OLS Regression with controls $d_{i,t}$ ***
eststo col1: reg land_gini any_lr ln_i_lstock ln_i_fert ln_i_tract i_perarr, robust

*** Column (2) - OLS Regression with controls $d_{i,t}$ ***
eststo col2: reg land_gini propoor proefficiency ln_i_lstock ln_i_fert ln_i_tract i_perarr, robust

*** Column (3) - Column (1) including additional controls $g_{i,t}$ ***
eststo col3: reg land_gini any_lr ln_i_lstock ln_i_fert ln_i_tract i_perarr ln_gdp_pc rule_of_law eduatt population_gr, robust

*** Column (4) - Column (2) including additional controls $g_{i,t}$ ***
eststo col4: reg land_gini propoor proefficiency ln_i_lstock ln_i_fert ln_i_tract i_perarr ln_gdp_pc rule_of_law eduatt population_gr, robust

** Dependent variable: agpop **
*** Column (5) - OLS Regression with controls $d_{i,t}$ ***
eststo col5: reg agpop any_lr ln_i_lstock ln_i_fert ln_i_tract i_perarr, robust

*** Column (6) - OLS Regression with controls $d_{i,t}$ ***
eststo col6: reg agpop propoor proefficiency ln_i_lstock ln_i_fert ln_i_tract i_perarr, robust

*** Column (7) - Column (5) including additional controls $g_{i,t}$ ***
eststo col7: reg agpop any_lr ln_i_lstock ln_i_fert ln_i_tract i_perarr ln_gdp_pc rule_of_law eduatt population_gr, robust

*** Column (8) - Column (6) including additional controls $g_{i,t}$ ***
eststo col8: reg agpop propoor proefficiency ln_i_lstock ln_i_fert ln_i_tract i_perarr ln_gdp_pc rule_of_law eduatt population_gr, robust

* Export to LaTeX *
esttab col1 col2 col3 col4 col5 col6 col7 col8 ///
    using "rtable10.tex", replace tex ///
    title("Dependent variable: land_gini & agpop") ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2 F p, labels("Observations" "R-squared" "F-statistic" "Prob > F"))
