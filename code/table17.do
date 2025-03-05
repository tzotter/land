* Do file to be used with inequality.dta from 'Land Reform Revisited: Productivity Gains Amid Inequality Pains'.
* The following code recreates Table [17] in the paper and includes additional robustness checks.
* A brief description of variables is given in the readme.md. Variables with the 'i' prefix include values that
* were interpolated, please see Chapter 3.2 in the paper.

* Load in inequality.dta
use inequality.dta, clear

xtset id year

xtdescribe
	
mata: mata clear  // Clears mata at the beginning
estimates clear   // Clears any stored estimates
eststo clear  // Clears any stored estimates

* Table [17]
** Dependent variable: land_gini **
*** Column (1) - OLS Regression with controls $d_{i,t} + g_{i,t}$ and controls for colonial origin $h_{i,t}$ ***
eststo col1: reg land_gini any_lr ln_i_lstock ln_i_fert ln_i_tract i_perarr ln_gdp_pc rule_of_law eduatt population_gr co_british co_french co_portuguese co_spanish, robust

*** Column (2) - Column (1) for mot_cons mot_ten ***
eststo col2: reg land_gini propoor proefficiency ln_i_lstock ln_i_fert ln_i_tract i_perarr ln_gdp_pc rule_of_law eduatt population_gr co_british co_french co_portuguese co_spanish, robust

*** Column (3) - Column (1) for class_lr ***
eststo col3: reg land_gini class_lr ln_i_lstock ln_i_fert ln_i_tract i_perarr ln_gdp_pc rule_of_law eduatt population_gr co_british co_french co_portuguese co_spanish, robust

*** Column (4) - Column (1) for mot_ceil ***
eststo col4: reg land_gini mot_ceil ln_i_lstock ln_i_fert ln_i_tract i_perarr ln_gdp_pc rule_of_law eduatt population_gr co_british co_french co_portuguese co_spanish, robust

** Dependent variable: agpop **
*** Column (5) - OLS Regression with controls $d_{i,t} + g_{i,t}$ and controls for colonial origin $h_{i,t}$ ***
eststo col5: reg agpop any_lr ln_i_lstock ln_i_fert ln_i_tract i_perarr ln_gdp_pc rule_of_law eduatt population_gr co_british co_french co_portuguese co_spanish, robust

*** Column (6) - Column (5) for mot_cons mot_ten ***
eststo col6: reg agpop propoor proefficiency ln_i_lstock ln_i_fert ln_i_tract i_perarr ln_gdp_pc rule_of_law eduatt population_gr co_british co_french co_portuguese co_spanish, robust

*** Column (7) - Column (5) for class_lr ***
eststo col7: reg agpop class_lr ln_i_lstock ln_i_fert ln_i_tract i_perarr ln_gdp_pc rule_of_law eduatt population_gr co_british co_french co_portuguese co_spanish, robust

*** Column (8) - Column (5) for mot_ceil ***
eststo col8: reg agpop mot_ceil ln_i_lstock ln_i_fert ln_i_tract i_perarr ln_gdp_pc rule_of_law eduatt population_gr co_british co_french co_portuguese co_spanish, robust

* Export to LaTeX *
esttab col1 col2 col3 col4 col5 col6 col7 col8 ///
    using "rtable14.tex", replace tex ///
    title("Dependent variable: land_gini & agpop") ///
    se star(* 0.10 ** 0.05 *** 0.01) ///
    stats(N r2 F p, labels("Observations" "R-squared" "F-statistic" "Prob > F"))
