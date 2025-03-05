* Do file to be used with reforms.dta from 'Land Reform Revisited: Productivity Gains Amid Inequality Pains'.
* The following code recreates Table [9] in the paper and includes additional robustness checks.
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

** Dependent variable: ln_agout **
**** Testing for cross-sectional dependence ****
xtcd2 ln_agout L4.cum_class_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract, pesaran // Testing for weak cross-sectional dependence only using the CD-Test by Pesaran (2015)
xtcd2 ln_agout L4.cum_class_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract // Testing for weak cross-sectional dependence
xtcse2 ln_agout L4.cum_class_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract, nocd // Estimating the $\alpha$ exponent without running a CD-Test

xtcd2 ln_agout L4.cum_class_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr ln_tfr inv_life_expectancy ///
L4.rule_of_law L4.gov_consumption L4.i_rdensity, pesaran // Testing for weak cross-sectional dependence only using the CD-Test by Pesaran (2015)

xtcd2 ln_agout L4.cum_class_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr ln_tfr inv_life_expectancy ///
L4.rule_of_law L4.gov_consumption L4.i_rdensity // Testing for weak cross-sectional dependence

xtcse2 ln_agout L4.cum_class_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr ln_tfr inv_life_expectancy ///
L4.rule_of_law L4.gov_consumption L4.i_rdensity, nocd // Estimating the $\alpha$ exponent without running a CD-Testing

**** Testing for slope homogeneity using Blomquist & Westerlund (2013) ****
xthst ln_agout L4.cum_class_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract, ///
cr(ln_agout L4.ln_i_lstock ln_i_fert L4.ln_i_tract) hac

xthst ln_agout L4.cum_class_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr ln_tfr inv_life_expectancy L4.rule_of_law L4.gov_consumption L4.i_rdensity, ///
cr(ln_agout L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr ln_tfr inv_life_expectancy L4.rule_of_law L4.gov_consumption L4.i_rdensity) hac

** Dependent variable: ln_cereal_yield **
**** Testing for cross-sectional dependence ****
xtcd2 ln_cereal_yield L4.cum_class_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract, pesaran // Testing for weak cross-sectional dependence only using the CD-Test by Pesaran (2015)
xtcd2 ln_cereal_yield L4.cum_class_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract // Testing for weak cross-sectional dependence
xtcse2 ln_cereal_yield L4.cum_class_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract, nocd // Estimating the $\alpha$ exponent without running a CD-Test

xtcd2 ln_cereal_yield L4.cum_class_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr ln_tfr inv_life_expectancy ///
L4.rule_of_law L4.gov_consumption L4.i_rdensity, pesaran // Testing for weak cross-sectional dependence only using the CD-Test by Pesaran (2015)

xtcd2 ln_cereal_yield L4.cum_class_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr ln_tfr inv_life_expectancy ///
L4.rule_of_law L4.gov_consumption L4.i_rdensity // Testing for weak cross-sectional dependence

xtcse2 ln_cereal_yield L4.cum_class_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr ln_tfr inv_life_expectancy ///
L4.rule_of_law L4.gov_consumption L4.i_rdensity, nocd // Estimating the $\alpha$ exponent without running a CD-Testing

**** Testing for slope homogeneity using Blomquist & Westerlund (2013) ****
xthst ln_cereal_yield L4.cum_class_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract, ///
cr(ln_cereal_yield L4.ln_i_lstock ln_i_fert L4.ln_i_tract) hac

xthst ln_cereal_yield L4.cum_class_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr ln_tfr inv_life_expectancy L4.rule_of_law L4.gov_consumption L4.i_rdensity, ///
cr(ln_cereal_yield L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr ln_tfr inv_life_expectancy L4.rule_of_law L4.gov_consumption L4.i_rdensity) hac

* Table [9]
*** Column (1) -  CCE-MG Estimator using pooled L4.cum_class_lr ***
eststo col1: xtdcce2 ln_agout L4.cum_class_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract, reportc ///
    crosssectional(ln_agout L4.ln_i_lstock ln_i_fert L4.ln_i_tract) pooled(L4.cum_class_lr)
	
*** Column (2) -  Column (1) including additional controls $e_{i,t} + f_{i,t}$ ***
eststo col2: xtdcce2 ln_agout L4.cum_class_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr ln_tfr inv_life_expectancy ///
	L4.rule_of_law L4.gov_consumption L4.i_rdensity, reportc ///
	crosssectional(ln_agout L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr ln_tfr inv_life_expectancy L4.rule_of_law L4.gov_consumption L4.i_rdensity) pooled(L4.cum_class_lr)

*** Column (3) -  Using ln_cereal_yield as a dependent variable ***
eststo col3: xtdcce2 ln_cereal_yield L4.cum_class_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract, reportc ///
    crosssectional(ln_cereal_yield L4.ln_i_lstock ln_i_fert L4.ln_i_tract) pooled(L4.cum_class_lr)

*** Column (4) -  Column (3) including additional controls $e_{i,t} + f_{i,t}$ ***
eststo col4: xtdcce2 ln_cereal_yield L4.cum_class_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr ln_tfr inv_life_expectancy ///
	L4.rule_of_law L4.gov_consumption L4.i_rdensity, reportc ///
	crosssectional(ln_cereal_yield L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr ln_tfr inv_life_expectancy L4.rule_of_law L4.gov_consumption L4.i_rdensity) pooled(L4.cum_class_lr)

**** Column (5) - Column (1) using a regularized CCE ****
// Uses ER Criterion from Ahn and Horenstein (2013) per default 
eststo col5: xtdcce2 ln_agout L4.cum_class_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract, reportc ///
	crosssectional(ln_agout L4.ln_i_lstock ln_i_fert L4.ln_i_tract,rcce) pooled(L4.cum_class_lr)

**** Column (6) - Column (2) using a regularized CCE ****
eststo col6: xtdcce2 ln_agout L4.cum_class_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr ln_tfr inv_life_expectancy L4.rule_of_law L4.gov_consumption L4.i_rdensity, reportc ///
	crosssectional(ln_agout L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr ln_tfr inv_life_expectancy L4.rule_of_law L4.gov_consumption L4.i_rdensity, rcce) pooled(L4.cum_class_lr)

**** Column (7) - Column (3) using a regularized CCE **** 
eststo col7: xtdcce2 ln_cereal_yield L4.cum_class_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract, reportc ///
	crosssectional(ln_cereal_yield L4.ln_i_lstock ln_i_fert L4.ln_i_tract,rcce) pooled(L4.cum_class_lr)

**** Column (8) - Column (4) using a regularized CCE ****
eststo col8: xtdcce2 ln_cereal_yield L4.cum_class_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr ln_tfr inv_life_expectancy L4.rule_of_law L4.gov_consumption L4.i_rdensity, reportc ///
	crosssectional(ln_cereal_yield L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr ln_tfr inv_life_expectancy L4.rule_of_law L4.gov_consumption L4.i_rdensity, rcce) pooled(L4.cum_class_lr)
	
* Export to LaTeX *
esttab col1 col2 col3 col4 col5 col6 col7 col8 ///
    using "rtable7.tex", replace tex ///
    title("Dependent variable: ln_agout & ln_cereal_yield") ///
    se star(* 0.10 ** 0.05 *** 0.01)
