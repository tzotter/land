* Do file to be used with table1.dta from ''. The following code recreates Table 1 in the paper and includes additional robustness checks.
* The Appendix of the paper includes Fixed-Effects and Random-Effects OLS models, all of which are included here.
* Necessary dependencies are: xtserial, xtqptest, xtgls and xtreg.
* A brief description of variables is given in the readme.md. Variables with the 'i' prefix include values that
* were interpolated, please see Chapter '' in the paper.

* Load the table1 file
use "table1.dta", replace

* Declare panel structure
xtset id year

* Verify panel structure
xtdescribe

mata: mata clear  // Clears Mata at the beginning
estimates clear   // Clears any stored estimates

* Table 1
** Dependent variable: ln_agout **
*** Column (1) - GLS with AR(1), heteroscedasticity in the error structure and an indicator variable for time ***
xtserial ln_agout cum_lr ln_i_lstock ln_i_fert ln_i_tract // Testing for autocorrelation (Wooldridge-Drukker test)
xtqptest ln_agout cum_lr ln_i_lstock ln_i_fert ln_i_tract, force // Testing for autocorrelation (Born-Breitung test)

xtgls ln_agout L4.cum_lr ln_i_lstock ln_i_fert ln_i_tract i.year if plqi~=. & i_rdensity ~=. & gov_consumption ~=. & rule_of_law ~=., panels(hetero) corr(ar1)
estimates store AGLS1

*** Column (2) - Column (1) excluding interpolated values ***
xtserial ln_agout cum_lr ln_lstock ln_fert ln_tract // Testing for autocorrelation (Wooldridge-Drukker test)
xtqptest ln_agout cum_lr ln_i_lstock ln_i_fert ln_i_tract, force // Testing for autocorrelation (Born-Breitung test)

xtgls ln_agout L4.cum_lr ln_lstock ln_fert ln_tract i.year if plqi~=. & i_rdensity ~=. & gov_consumption ~=. & rule_of_law ~=., force panels(hetero) corr(ar1)
estimates store AGLS2

*** Column (3) - Includes different motives as well as additional controls ***
xtserial ln_agout mot_ceil mot_cons mot_priv mot_ten ln_lstock ln_fert ln_tract i_perarr i_rdensity // Testing for autocorrelation (Wooldridge-Drukker test)
xtqptest ln_agout mot_ceil mot_cons mot_priv mot_ten ln_i_lstock ln_i_fert ln_i_tract i_perarr i_rdensity, force // Testing for autocorrelation (Born-Breitung test)

xtgls ln_agout L4.mot_ceil L4.mot_cons L4.mot_priv L4.mot_ten L4.ln_lstock ln_fert L4.ln_tract i_perarr plqi i_rdensity i.year if gov_consumption ~=. & rule_of_law ~=., force panels(hetero) corr(ar1)
estimates store AGLS3

*** Column (4) - Includes additional controls from Barro (2003) ***
xtserial ln_agout mot_ceil mot_cons mot_priv mot_ten ln_lstock ln_fert ln_tract i_perarr plqi i_rdensity inv_life_expectancy ln_tfr ///
gov_consumption rule_of_law // Testing for autocorrelation (Wooldridge-Drukker test)
xtqptest ln_agout mot_ceil mot_cons mot_priv mot_ten ln_i_lstock ln_i_fert ln_i_tract i_perarr i_rdensity inv_life_expectancy ln_tfr ///
gov_consumption rule_of_law, force // Testing for autocorrelation (Born-Breitung test)

xtgls ln_agout L4.mot_ceil L4.mot_cons L4.mot_priv L4.mot_ten L4.ln_lstock ln_fert L4.ln_tract i_perarr plqi i_rdensity inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law i.year, force panels(hetero) corr(ar1)
estimates store AGLS4
	
** Dependent variable: ln_cereal_yield **
*** Column (5) - GLS with AR(1), heteroscedasticity in the error structure and an indicator variable for time ***
xtserial ln_cereal_yield cum_lr ln_lstock ln_fert ln_tract // Testing for autocorrelation (Wooldridge-Drukker test)
xtqptest ln_cereal_yield cum_lr ln_i_lstock ln_i_fert ln_i_tract, force // Testing for autocorrelation (Born-Breitung test)

xtgls ln_cereal_yield L4.cum_lr ln_lstock ln_fert ln_tract i.year if plqi~=. & i_rdensity ~=. & gov_consumption ~=. & rule_of_law ~=., force panels(hetero) corr(ar1)
estimates store CGLS2

*** Column (6) - Includes different motives as well as additional controls ***
xtserial ln_cereal_yield mot_ceil mot_cons mot_priv mot_ten ln_lstock ln_fert ln_tract i_perarr plqi i_rdensity // Testing for autocorrelation (Wooldridge-Drukker test)
xtqptest ln_cereal_yield mot_ceil mot_cons mot_priv mot_ten ln_i_lstock ln_i_fert ln_i_tract i_perarr, force // Testing for autocorrelation (Born-Breitung test)

xtgls ln_cereal_yield L4.mot_ceil L4.mot_cons L4.mot_priv L4.mot_ten L4.ln_lstock ln_fert L4.ln_tract i_perarr plqi i_rdensity i.year if gov_consumption ~=. & rule_of_law ~=., force panels(hetero) corr(ar1)
estimates store CGLS3

*** Column (7) - Includes additional controls from Barro (2003) ***
xtserial ln_cereal_yield mot_ceil mot_cons mot_priv mot_ten ln_lstock ln_fert ln_tract i_perarr plqi i_rdensity inv_life_expectancy ln_tfr ///
gov_consumption rule_of_law // Testing for autocorrelation (Wooldridge-Drukker test)
xtqptest ln_cereal_yield mot_ceil mot_cons mot_priv mot_ten ln_i_lstock ln_i_fert ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
gov_consumption rule_of_law, force // Testing for autocorrelation (Born-Breitung test)

xtgls ln_cereal_yield L4.mot_ceil L4.mot_cons L4.mot_priv L4.mot_ten L4.ln_lstock ln_fert L4.ln_tract i_perarr plqi i_rdensity inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law i.year, force panels(hetero) corr(ar1)
estimates store CGLS4

** Dependent variable: tfp **
*** Column (8) - GLS with AR(1), heteroscedasticity in the error structure and an indicator variable for time ***
xtserial tfp cum_lr ln_lstock ln_fert ln_tract // Testing for autocorrelation (Wooldridge-Drukker test)
xtqptest tfp cum_lr ln_i_lstock ln_i_fert ln_i_tract, force // Testing for autocorrelation (Born-Breitung test)

xtgls tfp L4.cum_lr ln_lstock ln_fert ln_tract i.year if plqi~=. & i_rdensity ~=. & gov_consumption ~=. & rule_of_law ~=., force panels(hetero) corr(ar1)
estimates store TGLS2

*** Column (9) - Includes different motives as well as additional controls ***
xtserial tfp mot_ceil mot_cons mot_priv mot_ten ln_lstock ln_fert ln_tract i_perarr plqi i_rdensity // Testing for autocorrelation (Wooldridge-Drukker test)
xtqptest tfp mot_ceil mot_cons mot_priv mot_ten ln_i_lstock ln_i_fert ln_i_tract i_perarr, force // Testing for autocorrelation (Born-Breitung test)

xtgls tfp L4.mot_ceil L4.mot_cons L4.mot_priv L4.mot_ten L4.ln_lstock ln_fert L4.ln_tract i_perarr plqi i_rdensity i.year if gov_consumption ~=. & rule_of_law ~=., force panels(hetero) corr(ar1)
estimates store TGLS3

*** Column (10) - Includes additional controls from Barro (2003) ***
xtserial tfp mot_ceil mot_cons mot_priv mot_ten ln_lstock ln_fert ln_tract i_perarr plqi i_rdensity inv_life_expectancy ln_tfr ///
gov_consumption rule_of_law // Testing for autocorrelation (Wooldridge-Drukker test)
xtqptest tfp mot_ceil mot_cons mot_priv mot_ten ln_i_lstock ln_i_fert ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
gov_consumption rule_of_law, force // Testing for autocorrelation (Born-Breitung test)

xtgls tfp L4.mot_ceil L4.mot_cons L4.mot_priv L4.mot_ten L4.ln_lstock ln_fert L4.ln_tract i_perarr plqi i_rdensity inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law i.year, force panels(hetero) corr(ar1)
estimates store TGLS4


* Appendix, Table 1 *
** Dependent variable: ln_agout **
*** Column (1) - Fixed-Effects (FE) OLS with clustered sandwich estimator ***
xtreg ln_agout L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract i.year if i_rdensity ~=. & gov_consumption ~=. & rule_of_law ~=., fe vce(cluster id)
estimates store AFE1

*** Column (2) - Column (1) excluding interpolated values ***
xtreg ln_agout L4.cum_lr L4.ln_lstock ln_fert L4.ln_tract i.year if i_rdensity ~=. & gov_consumption ~=. & rule_of_law ~=., fe vce(cluster id)
estimates store AFE2

*** Column (3) - Includes different motives as well as additional controls ***
xtreg ln_agout L4.mot_ceil L4.mot_cons L4.mot_priv L4.mot_ten L4.ln_lstock ln_fert L4.ln_tract i_perarr i_rdensity i.year if gov_consumption ~=. & rule_of_law ~=., fe vce(cluster id)
estimates store AFE3

*** Column (4) - Includes additional controls from Barro (2003) ***
xtreg ln_agout L4.mot_ceil L4.mot_cons L4.mot_priv L4.mot_ten L4.ln_lstock ln_fert L4.ln_tract i_perarr i_rdensity inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law i.year, fe vce(cluster id)
estimates store AFE4

** Dependent variable: ln_cereal_yield **
*** Column (5) - Fixed-Effects (FE) OLS with clustered sandwich estimator ***
xtreg ln_cereal_yield L4.cum_lr L4.ln_lstock ln_fert L4.ln_tract i.year if i_rdensity ~=. & gov_consumption ~=. & rule_of_law ~=., fe vce(cluster id)
estimates store CFE2

*** Column (6) - Includes different motives as well as additional controls ***
xtreg ln_cereal_yield L4.mot_ceil L4.mot_cons L4.mot_priv L4.mot_ten L4.ln_lstock ln_fert L4.ln_tract i_perarr i_rdensity i.year if gov_consumption ~=. & rule_of_law ~=., fe vce(cluster id)
estimates store CFE3

*** Column (7) - Includes additional controls from Barro (2003) ***
xtreg ln_cereal_yield L4.mot_ceil L4.mot_cons L4.mot_priv L4.mot_ten L4.ln_lstock ln_fert L4.ln_tract i_perarr i_rdensity inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law i.year, fe vce(cluster id)
estimates store CFE4

** Dependent variable: tfp **
*** Column (8) - Fixed-Effects (FE) OLS with clustered sandwich estimator ***
xtreg tfp L4.cum_lr L4.ln_lstock ln_fert L4.ln_tract i.year if i_rdensity ~=. & gov_consumption ~=. & rule_of_law ~=., fe vce(cluster id)
estimates store TFE2

*** Column (9) - Includes different motives as well as additional controls ***
xtreg tfp L4.mot_ceil L4.mot_cons L4.mot_priv L4.mot_ten L4.ln_lstock ln_fert L4.ln_tract i_perarr i_rdensity i.year if gov_consumption ~=. & rule_of_law ~=., fe vce(cluster id)
estimates store TFE3

*** Column (10) - Includes additional controls from Barro (2003) ***
xtreg tfp L4.mot_ceil L4.mot_cons L4.mot_priv L4.mot_ten L4.ln_lstock ln_fert L4.ln_tract i_perarr i_rdensity inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law i.year, fe vce(cluster id)
estimates store TFE4


* Robustness checks *
** Appendix, Table 1: Column (4) - Excluding vce(cluster id) ***
xtreg ln_agout L4.mot_ceil L4.mot_cons L4.mot_priv L4.mot_ten L4.ln_lstock ln_fert L4.ln_tract i_perarr i_rdensity inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law i.year, fe
estimates store AAFE4

xtreg ln_agout L4.mot_ceil L4.mot_cons L4.mot_priv L4.mot_ten L4.ln_lstock ln_fert L4.ln_tract i_perarr i_rdensity inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law i.year, re
estimates store AARE4

hausman AAFE4 AARE4 // Hausman test

** Appendix, Table 1: Column (7) - Excluding vce(cluster id) **
xtreg ln_cereal_yield L4.mot_ceil L4.mot_cons L4.mot_priv L4.mot_ten L4.ln_lstock ln_fert L4.ln_tract i_perarr i_rdensity inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law i.year, fe
estimates store AAFE7

xtreg ln_cereal_yield L4.mot_ceil L4.mot_cons L4.mot_priv L4.mot_ten L4.ln_lstock ln_fert L4.ln_tract i_perarr i_rdensity inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law i.year, re
estimates store AARE7

hausman AAFE7 AARE7 // Hausman test

** Appendix, Table 1: Column (10) - Excluding vce(cluster id) **
xtreg tfp L4.mot_ceil L4.mot_cons L4.mot_priv L4.mot_ten L4.ln_lstock ln_fert L4.ln_tract i_perarr i_rdensity inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law i.year, fe
estimates store AAFE10

xtreg tfp L4.mot_ceil L4.mot_cons L4.mot_priv L4.mot_ten L4.ln_lstock ln_fert L4.ln_tract i_perarr i_rdensity inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law i.year, re
estimates store AARE10

hausman AAFE10 AARE10 // Hausman test
