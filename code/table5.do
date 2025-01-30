* Do file to be used with table5.dta from ''. The following code recreates Table 5 in the paper.
* Necessary dependencies are: xtreg.
* A brief description of variables is given in the readme.md. Variables with the 'i' prefix include values that
* were interpolated, please see Chapter '' in the paper.

* Load the table5 file
use "table5.dta", replace

mata: mata clear  // Clears Mata at the beginning
estimates clear   // Clears any stored estimates

* Table 5
** Dependent variable: land_gini **
*** Column (1) - OLS Regression including mot_ceil ***
reg land_gini mot_ceil ln_gdp_pc ln_i_stock ln_i_fert ln_i_tract i_perarr if population_gr ~=., robust
estimates store OLS1

*** Column (2) - Including additional controls ***
reg land_gini mot_ceil ln_gdp_pc ln_i_stock ln_i_fert ln_i_tract i_perarr rule_of_law eduatt population_gr, robust
estimates store OLS2

*** Column (3) - OLS Regression including propoor ***
reg land_gini propoor ln_gdp_pc ln_i_stock ln_i_fert ln_i_tract i_perarr if population_gr ~=., robust
estimates store OLS3

*** Column (4) - Including additional controls ***
reg land_gini propoor ln_gdp_pc ln_i_stock ln_i_fert ln_i_tract i_perarr rule_of_law eduatt population_gr, robust
estimates store OLS4

esttab OLS1 OLS2 OLS3 OLS4, ///
    se starlevels(* 0.10 ** 0.05 *** 0.01) ///
    label ///
    order(mot_ceil propoor ln_gdp_pc ln_i_stock ln_i_fert ln_i_tract i_perarr rule_of_law eduatt population_gr) ///
    nonumbers
