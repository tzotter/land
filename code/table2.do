* Do file to be used with table2.dta from ''. The following code recreates Table 2 in the paper and includes additional robustness checks.
* The Appendix of the paper includes Fixed-Effects and Random-Effects OLS models, all of which are included here.
* Necessary dependencies are: xtserial, xtqptest, xtgls and xtreg.
* A brief description of variables is given in the readme.md. Variables with the 'i' prefix include values that
* were interpolated, please see Chapter '' in the paper.

* Load the table2 file
use "table2.dta", replace

* Declare panel structure
xtset id year

* Verify panel structure
xtdescribe

mata: mata clear  // Clears Mata at the beginning
estimates clear   // Clears any stored estimates

* Table 2
** Dependent variable: ln_agout **
*** Column (1) - GLS with AR(1), heteroscedasticity in the error structure and an indicator variable for time ***
xtserial ln_agout propoor proefficiency ln_lstock ln_fert ln_tract // Testing for autocorrelation (Wooldridge-Drukker test)
xtqptest ln_agout propoor proefficiency ln_i_lstock ln_i_fert ln_i_tract, force // Testing for autocorrelation (Born-Breitung test)

xtgls ln_agout L4.propoor L4.proefficiency ln_lstock ln_fert ln_tract i.year if plqi~=. & i_rdensity ~=. & gov_consumption ~=. & rule_of_law ~=., force panels(hetero) corr(ar1)
estimates store AGLS1

*** Column (2) - Includes different motives as well as additional controls ***
xtserial ln_agout propoor proefficiency ln_lstock ln_fert ln_tract i_perarr i_rdensity // Testing for autocorrelation (Wooldridge-Drukker test)
xtqptest ln_agout propoor proefficiency ln_i_lstock ln_i_fert ln_i_tract i_perarr i_rdensity, force // Testing for autocorrelation (Born-Breitung test)

xtgls ln_agout L4.propoor L4.proefficiency L4.ln_lstock ln_fert L4.ln_tract i_perarr plqi i_rdensity i.year if gov_consumption ~=. & rule_of_law ~=., force panels(hetero) corr(ar1)
estimates store AGLS2

*** Column (3) - Includes additional controls from Barro (2003) ***
xtserial ln_agout propoor proefficiency ln_lstock ln_fert ln_tract i_perarr plqi i_rdensity inv_life_expectancy ln_tfr ///
gov_consumption rule_of_law // Testing for autocorrelation (Wooldridge-Drukker test)

xtqptest ln_agout propoor proefficiency ln_i_lstock ln_i_fert ln_i_tract i_perarr i_rdensity inv_life_expectancy ln_tfr ///
gov_consumption rule_of_law, force // Testing for autocorrelation (Born-Breitung test)

xtgls ln_agout L4.propoor L4.proefficiency L4.ln_lstock ln_fert L4.ln_tract i_perarr plqi i_rdensity inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law i.year, force panels(hetero) corr(ar1)
estimates store AGLS3
	
** Dependent variable: ln_cereal_yield **
*** Column (4) - GLS with AR(1), heteroscedasticity in the error structure and an indicator variable for time ***
xtserial ln_cereal_yield propoor proefficiency ln_lstock ln_fert ln_tract // Testing for autocorrelation (Wooldridge-Drukker test)
xtqptest ln_cereal_yield propoor proefficiency ln_i_lstock ln_i_fert ln_i_tract, force // Testing for autocorrelation (Born-Breitung test)

xtgls ln_cereal_yield L4.propoor L4.proefficiency ln_lstock ln_fert ln_tract i.year if plqi~=. & i_rdensity ~=. & gov_consumption ~=. & rule_of_law ~=., force panels(hetero) corr(ar1)
estimates store CGLS1

*** Column (5) - Includes different motives as well as additional controls ***
xtserial ln_cereal_yield propoor proefficiency ln_lstock ln_fert ln_tract i_perarr i_rdensity // Testing for autocorrelation (Wooldridge-Drukker test)
xtqptest ln_cereal_yield propoor proefficiency ln_i_lstock ln_i_fert ln_i_tract i_perarr i_rdensity, force // Testing for autocorrelation (Born-Breitung test)

xtgls ln_cereal_yield L4.propoor L4.proefficiency L4.ln_lstock ln_fert L4.ln_tract i_perarr plqi i_rdensity i.year if gov_consumption ~=. & rule_of_law ~=., force panels(hetero) corr(ar1)
estimates store CGLS2

*** Column (6) - Includes additional controls from Barro (2003) ***
xtserial ln_cereal_yield propoor proefficiency ln_lstock ln_fert ln_tract i_perarr plqi i_rdensity inv_life_expectancy ln_tfr ///
gov_consumption rule_of_law // Testing for autocorrelation (Wooldridge-Drukker test)

xtqptest ln_cereal_yield propoor proefficiency ln_i_lstock ln_i_fert ln_i_tract i_perarr i_rdensity inv_life_expectancy ln_tfr ///
gov_consumption rule_of_law, force // Testing for autocorrelation (Born-Breitung test)

xtgls ln_cereal_yield L4.propoor L4.proefficiency L4.ln_lstock ln_fert L4.ln_tract i_perarr plqi i_rdensity inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law i.year, force panels(hetero) corr(ar1)
estimates store CGLS3

** Dependent variable: tfp **
*** Column (4) - GLS with AR(1), heteroscedasticity in the error structure and an indicator variable for time ***
xtserial tfp propoor proefficiency ln_lstock ln_fert ln_tract // Testing for autocorrelation (Wooldridge-Drukker test)
xtqptest tfp propoor proefficiency ln_i_lstock ln_i_fert ln_i_tract, force // Testing for autocorrelation (Born-Breitung test)

xtgls tfp L4.propoor L4.proefficiency ln_lstock ln_fert ln_tract i.year if plqi~=. & i_rdensity ~=. & gov_consumption ~=. & rule_of_law ~=., force panels(hetero) corr(ar1)
estimates store TGLS1

*** Column (5) - Includes different motives as well as additional controls ***
xtserial tfp propoor proefficiency ln_lstock ln_fert ln_tract i_perarr i_rdensity // Testing for autocorrelation (Wooldridge-Drukker test)
xtqptest tfp propoor proefficiency ln_i_lstock ln_i_fert ln_i_tract i_perarr i_rdensity, force // Testing for autocorrelation (Born-Breitung test)

xtgls tfp L4.propoor L4.proefficiency L4.ln_lstock ln_fert L4.ln_tract i_perarr plqi i_rdensity i.year if gov_consumption ~=. & rule_of_law ~=., force panels(hetero) corr(ar1)
estimates store TGLS2

*** Column (6) - Includes additional controls from Barro (2003) ***
xtserial tfp propoor proefficiency ln_lstock ln_fert ln_tract i_perarr plqi i_rdensity inv_life_expectancy ln_tfr ///
gov_consumption rule_of_law // Testing for autocorrelation (Wooldridge-Drukker test)

xtqptest tfp propoor proefficiency ln_i_lstock ln_i_fert ln_i_tract i_perarr i_rdensity inv_life_expectancy ln_tfr ///
gov_consumption rule_of_law, force // Testing for autocorrelation (Born-Breitung test)

xtgls tfp L4.propoor L4.proefficiency L4.ln_lstock ln_fert L4.ln_tract i_perarr plqi i_rdensity inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law i.year, force panels(hetero) corr(ar1)
estimates store TGLS3


* Appendix, Table 2 *
** Dependent variable: ln_agout **
*** Column (1) - Fixed-Effects (FE) OLS with clustered sandwich estimator ***
xtreg ln_agout L4.propoor L4.proefficiency L4.ln_lstock ln_fert L4.ln_tract i_perarr i_rdensity i.year if gov_consumption ~=. & rule_of_law ~=., fe vce(cluster id)
estimates store AFE1

*** Column (2) - Includes additional controls from Barro (2003) ***
xtreg ln_agout L4.propoor L4.proefficiency L4.ln_lstock ln_fert L4.ln_tract i_perarr i_rdensity inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law i.year, fe vce(cluster id)
estimates store AFE2

** Dependent variable: ln_cereal_yield **
*** Column (3) - Fixed-Effects (FE) OLS with clustered sandwich estimator ***
xtreg ln_cereal_yield L4.propoor L4.proefficiency L4.ln_lstock ln_fert L4.ln_tract i_perarr i_rdensity i.year if gov_consumption ~=. & rule_of_law ~=., fe vce(cluster id)
estimates store AFE3

*** Column (4) - Includes additional controls from Barro (2003) ***
xtreg ln_cereal_yield L4.propoor L4.proefficiency L4.ln_lstock ln_fert L4.ln_tract i_perarr i_rdensity inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law i.year, fe vce(cluster id)
estimates store AFE4

** Dependent variable: tfp **
*** Column (5) - Fixed-Effects (FE) OLS with clustered sandwich estimator ***
xtreg tfp L4.propoor L4.proefficiency L4.ln_lstock ln_fert L4.ln_tract i_perarr i_rdensity i.year if gov_consumption ~=. & rule_of_law ~=., fe vce(cluster id)
estimates store AFE5

*** Column (6) - Includes additional controls from Barro (2003) ***
xtreg tfp L4.propoor L4.proefficiency L4.ln_lstock ln_fert L4.ln_tract i_perarr i_rdensity inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law i.year, fe vce(cluster id)
estimates store AFE6


* Robustness checks *
** Appendix, Table 1: Column (2) - Excluding vce(cluster id) ***
xtreg ln_agout L4.propoor L4.proefficiency L4.ln_lstock ln_fert L4.ln_tract i_perarr i_rdensity inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law i.year, fe
estimates store AAFE2

xtreg ln_agout L4.propoor L4.proefficiency L4.ln_lstock ln_fert L4.ln_tract i_perarr i_rdensity inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law i.year, re
estimates store AARE2

hausman AAFE2 AARE2 // Hausman test

** Appendix, Table 1: Column (4) - Excluding vce(cluster id) **
xtreg ln_cereal_yield L4.propoor L4.proefficiency L4.ln_lstock ln_fert L4.ln_tract i_perarr i_rdensity inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law i.year, fe
estimates store AAFE4

xtreg ln_cereal_yield L4.propoor L4.proefficiency L4.ln_lstock ln_fert L4.ln_tract i_perarr i_rdensity inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law i.year, re
estimates store AARE4

hausman AAFE4 AARE4 // Hausman test

** Appendix, Table 1: Column (6) - Excluding vce(cluster id) **
xtreg tfp L4.propoor L4.proefficiency L4.ln_lstock ln_fert L4.ln_tract i_perarr i_rdensity inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law i.year, fe
estimates store AAFE6

xtreg tfp L4.propoor L4.proefficiency L4.ln_lstock ln_fert L4.ln_tract i_perarr i_rdensity inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law i.year, re
estimates store AARE6

hausman AAFE6 AARE6 // Hausman test
