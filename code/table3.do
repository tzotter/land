* Do file to be used with table3_.dta from ''. The following code recreates Table 3 in the paper and includes additional robustness checks.
* Necessary dependencies are: xtdcce2, xthst, xtnumfac and moremata available from https://github.com/JanDitzen (Last accessed: 24.01.2025).
* A brief description of variables is given in the readme.md. Variables with the 'i' prefix include values that
* were interpolated, please see Chapter '' in the paper.

mata: mata clear  // Clears Mata at the beginning
estimates clear   // Clears any stored estimates

* Table 3

* ------------------------------------------------------------------------------

** Table 3_a
use "table3_a.dta", replace

** Dependent variable: ln_agout **
*** Column (1) - Common Correlated Effects (Mean Group) Estimator from Pesaran (2006) ***
xtcd2 ln_agout L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract, pesaran // Testing for weak cross-sectional dependence only using the CD-Test by Pesaran (2015)
xtcd2 ln_agout L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract // Testing for weak cross-sectional dependence
xtcse2 ln_agout L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract, nocd // Estimating the $\alpha$ exponent without running a CD-Test
xthst ln_agout L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract, cr(ln_agout L4.ln_i_lstock ln_i_fert L4.ln_i_tract) hac // Testing for slope homogeneity using Blomquist & Westerlund (2013)

xtdcce2 ln_agout L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract, reportc ///
cr(ln_agout L4.ln_i_lstock ln_i_fert L4.ln_i_tract)
estimates store ACCEMG1

xtcd2 // Re-run tests for weak cross-section dependence

xtnumfac ln_agout L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract, stand(5) // Calculating number of common factors

xtdcce2 ln_agout L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract, reportc ///
cr(ln_agout L4.ln_i_lstock ln_i_fert L4.ln_i_tract, rcce(npc(1))) // Using regularized CCE-MG Estimator with cross-section averages and ER = 1 = GR from Ahn & Horenstein (2013)
estimates store RACCEMG1

xtdcce2 ln_agout L4.cum_lr ln_i_lstock ln_i_fert ln_i_tract, ///
cr(ln_agout L4.cum_lr ln_i_lstock ln_i_fert ln_i_tract, rccl) // Reporting Rank Condition Classifier from De Vos et al. (2024)

*** Column (2) - Includes additional controls ***
xtcd2 ln_agout L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, pesaran // Testing for weak cross-sectional dependence only using the CD-Test by Pesaran (2015)

xtcd2 ln_agout L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law // Testing for weak cross-sectional dependence

xtcse2 ln_agout L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, nocd // Estimating the $\alpha$ exponent without running a CD-Test

xthst ln_agout L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, ///
cr(ln_agout L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr L4.gov_consumption L4.rule_of_law) hac // Testing for slope homogeneity using Blomquist & Westerlund (2013)

xtdcce2 ln_agout L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, fast2 ///
cr(ln_agout L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr L4.gov_consumption L4.rule_of_law)
estimates store ACCEMG2

xtcd2 // Re-run tests for weak cross-section dependence

xtnumfac ln_agout L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, stand(5) // Calculating number of common factors

xtdcce2 ln_agout L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, fast2 ///
cr(ln_agout L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr L4.gov_consumption L4.rule_of_law, rcce(npc(1))) // Using regularized CCE-MG Estimator with cross-section averages and ER = 1 = GR from Ahn & Horenstein (2013)
estimates store RACCEMG2

xtdcce2 ln_agout L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, ///
cr(ln_agout L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, rccl) // Reporting Rank Condition Classifier from De Vos et al. (2024)

** Dependent variable: ln_cereal_yield **
*** Column (3) -  Common Correlated Effects (Mean Group) Estimator from Pesaran (2006) ***
xtcd2 ln_cereal_yield L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract, pesaran // Testing for weak cross-sectional dependence only using the CD-Test by Pesaran (2015)
xtcd2 ln_cereal_yield L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract // Testing for weak cross-sectional dependence
xtcse2 ln_cereal_yield L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract, nocd // Estimating the $\alpha$ exponent without running a CD-Test
xthst ln_cereal_yield L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract, cr(ln_cereal_yield L4.ln_i_lstock ln_i_fert L4.ln_i_tract) hac // Testing for slope homogeneity using Blomquist & Westerlund (2013)

xtdcce2 ln_cereal_yield L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract, reportc ///
cr(ln_cereal_yield L4.ln_i_lstock ln_i_fert L4.ln_i_tract)
estimates store ACCEMG3

xtcd2 // Re-run tests for weak cross-section dependence

xtnumfac ln_cereal_yield L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract, stand(5) // Calculating number of common factors

xtdcce2 ln_cereal_yield L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract, reportc ///
cr(ln_cereal_yield L4.ln_i_lstock ln_i_fert L4.ln_i_tract, rcce(npc(3))) // Using regularized CCE-MG Estimator with cross-section averages and ER = 3 from Ahn & Horenstein (2013)
estimates store RACCEMG3

xtdcce2 ln_cereal_yield L4.cum_lr ln_i_lstock ln_i_fert ln_i_tract, ///
cr(ln_cereal_yield L4.cum_lr ln_i_lstock ln_i_fert ln_i_tract, rccl) // Reporting Rank Condition Classifier from De Vos et al. (2024)

*** Column (4) - Includes additional controls ***
xtcd2 ln_cereal_yield L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, pesaran // Testing for weak cross-sectional dependence only using the CD-Test by Pesaran (2015)

xtcd2 ln_cereal_yield L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law // Testing for weak cross-sectional dependence

xtcse2 ln_cereal_yield L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, nocd // Estimating the $\alpha$ exponent without running a CD-Test

xthst ln_cereal_yield L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, ///
cr(ln_cereal_yield L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr L4.gov_consumption L4.rule_of_law) hac // Testing for slope homogeneity using Blomquist & Westerlund (2013)

xtdcce2 ln_cereal_yield L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, fast2 ///
cr(ln_cereal_yield L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr L4.gov_consumption L4.rule_of_law)
estimates store ACCEMG4

xtcd2 // Re-run tests for weak cross-section dependence

xtnumfac ln_cereal_yield L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, stand(5) // Calculating number of common factors

xtdcce2 ln_cereal_yield L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, fast2 ///
cr(ln_cereal_yield L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr L4.gov_consumption L4.rule_of_law, rcce(npc(2))) // Using regularized CCE-MG Estimator with cross-section averages and ER = 2 = GR from Ahn & Horenstein (2013)
estimates store RACCEMG4

xtdcce2 ln_cereal_yield L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, ///
cr(ln_cereal_yield L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, rccl) // Reporting Rank Condition Classifier from De Vos et al. (2024)

** Dependent variable: tfp **
*** Column (5) -  Common Correlated Effects (Mean Group) Estimator from Pesaran (2006) ***
xtcd2 tfp L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract, pesaran // Testing for weak cross-sectional dependence only using the CD-Test by Pesaran (2015)
xtcd2 tfp L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract // Testing for weak cross-sectional dependence
xtcse2 tfp L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract, nocd // Estimating the $\alpha$ exponent without running a CD-Test
xthst tfp L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract, cr(ln_cereal_yield L4.ln_i_lstock ln_i_fert L4.ln_i_tract) hac // Testing for slope homogeneity using Blomquist & Westerlund (2013)

xtdcce2 tfp L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract, reportc ///
cr(tfp L4.ln_i_lstock ln_i_fert L4.ln_i_tract)
estimates store ACCEMG5

xtcd2 // Re-run tests for weak cross-section dependence

xtnumfac tfp L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract, stand(5) // Calculating number of common factors

xtdcce2 tfp L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract, reportc ///
cr(tfp L4.ln_i_lstock ln_i_fert L4.ln_i_tract, rcce(npc(3))) // Using regularized CCE-MG Estimator with cross-section averages and ER = 3 from Ahn & Horenstein (2013)
estimates store RACCEMG5

xtdcce2 tfp L4.cum_lr ln_i_lstock ln_i_fert ln_i_tract, ///
cr(tfp L4.cum_lr ln_i_lstock ln_i_fert ln_i_tract, rccl) // Reporting Rank Condition Classifier from De Vos et al. (2024)

*** Column (6) - Includes additional controls ***
xtcd2 tfp L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, pesaran // Testing for weak cross-sectional dependence only using the CD-Test by Pesaran (2015)

xtcd2 tfp L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law // Testing for weak cross-sectional dependence

xtcse2 tfp L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, nocd // Estimating the $\alpha$ exponent without running a CD-Test

xthst tfp L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, ///
cr(tfp L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr L4.gov_consumption L4.rule_of_law) hac // Testing for slope homogeneity using Blomquist & Westerlund (2013)

xtdcce2 tfp L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, fast2 ///
cr(tfp L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr L4.gov_consumption L4.rule_of_law)
estimates store ACCEMG6

xtcd2 // Re-run tests for weak cross-section dependence

xtnumfac tfp L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, stand(5) // Calculating number of common factors

xtdcce2 tfp L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, fast2 ///
cr(tfp L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr L4.gov_consumption L4.rule_of_law, rcce(npc(2))) // Using regularized CCE-MG Estimator with cross-section averages and ER = 2 from Ahn & Horenstein (2013)
estimates store RACCEMG6

xtdcce2 tfp L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, ///
cr(tfp L4.cum_lr L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, rccl) // Reporting Rank Condition Classifier from De Vos et al. (2024)

* ------------------------------------------------------------------------------

** Table 3_b
use "table3_b.dta", replace

** Dependent variable: ln_agout **
*** Column (1) - Common Correlated Effects (Mean Group) Estimator from Pesaran (2006) ***
xtcd2 ln_agout L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract, pesaran // Testing for weak cross-sectional dependence only using the CD-Test by Pesaran (2015)
xtcd2 ln_agout L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract // Testing for weak cross-sectional dependence
xtcse2 ln_agout L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract, nocd // Estimating the $\alpha$ exponent without running a CD-Test
xthst ln_agout L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract, cr(ln_agout L4.ln_i_lstock ln_i_fert L4.ln_i_tract) hac // Testing for slope homogeneity using Blomquist & Westerlund (2013)

xtdcce2 ln_agout L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract, fast2 ///
cr(ln_agout L4.ln_i_lstock ln_i_fert L4.ln_i_tract)
estimates store BCCEMG1

xtcd2 // Re-run tests for weak cross-section dependence

xtnumfac ln_agout L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract, stand(5) // Calculating number of common factors

xtdcce2 ln_agout L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract, reportc ///
cr(ln_agout L4.ln_i_lstock ln_i_fert L4.ln_i_tract, rcce(npc(1))) // Using regularized CCE-MG Estimator with cross-section averages and ER = 1 from Ahn & Horenstein (2013)
estimates store RBCCEMG1

xtdcce2 ln_agout L4.mot_ceil ln_i_lstock ln_i_fert ln_i_tract, ///
cr(ln_agout L4.mot_ceil ln_i_lstock ln_i_fert ln_i_tract, rccl) // Reporting Rank Condition Classifier from De Vos et al. (2024)

*** Column (2) - Includes additional controls ***
xtcd2 ln_agout L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, pesaran // Testing for weak cross-sectional dependence only using the CD-Test by Pesaran (2015)

xtcd2 ln_agout L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law // Testing for weak cross-sectional dependence

xtcse2 ln_agout L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, nocd // Estimating the $\alpha$ exponent without running a CD-Test

xthst ln_agout L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, ///
cr(ln_agout L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr L4.gov_consumption L4.rule_of_law) hac // Testing for slope homogeneity using Blomquist & Westerlund (2013)

xtdcce2 ln_agout L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, fast2 ///
cr(ln_agout L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr L4.gov_consumption L4.rule_of_law)
estimates store BCCEMG2

xtcd2 // Re-run tests for weak cross-section dependence

xtnumfac ln_agout L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, stand(5) // Calculating number of common factors

xtdcce2 ln_agout L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, fast2 ///
cr(ln_agout L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr L4.gov_consumption L4.rule_of_law, rcce(npc(1))) // Using regularized CCE-MG Estimator with cross-section averages and ER = 1 = GR from Ahn & Horenstein (2013)
estimates store RBCCEMG2

xtdcce2 ln_agout L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, ///
cr(ln_agout L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, rccl) // Reporting Rank Condition Classifier from De Vos et al. (2024)

** Dependent variable: ln_cereal_yield **
*** Column (3) -  Common Correlated Effects (Mean Group) Estimator from Pesaran (2006) ***
xtcd2 ln_cereal_yield L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract, pesaran // Testing for weak cross-sectional dependence only using the CD-Test by Pesaran (2015)
xtcd2 ln_cereal_yield L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract // Testing for weak cross-sectional dependence
xtcse2 ln_cereal_yield L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract, nocd // Estimating the $\alpha$ exponent without running a CD-Test
xthst ln_cereal_yield L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract, cr(ln_cereal_yield L4.ln_i_lstock ln_i_fert L4.ln_i_tract) hac // Testing for slope homogeneity using Blomquist & Westerlund (2013)

xtdcce2 ln_cereal_yield L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract, fast2 ///
cr(ln_cereal_yield L4.ln_i_lstock ln_i_fert L4.ln_i_tract)
estimates store BCCEMG3

xtcd2 // Re-run tests for weak cross-section dependence

xtnumfac ln_cereal_yield L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract, stand(5) // Calculating number of common factors

xtdcce2 ln_cereal_yield L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract, reportc ///
cr(ln_cereal_yield L4.ln_i_lstock ln_i_fert L4.ln_i_tract, rcce(npc(3))) // Using regularized CCE-MG Estimator with cross-section averages and ER = 3 = GR from Ahn & Horenstein (2013)
estimates store RBCCEMG3

xtdcce2 ln_cereal_yield L4.mot_ceil ln_i_lstock ln_i_fert ln_i_tract, ///
cr(ln_cereal_yield L4.mot_ceil ln_i_lstock ln_i_fert ln_i_tract, rccl) // Reporting Rank Condition Classifier from De Vos et al. (2024)

*** Column (4) - Includes additional controls ***
xtcd2 ln_cereal_yield L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, pesaran // Testing for weak cross-sectional dependence only using the CD-Test by Pesaran (2015)

xtcd2 ln_cereal_yield L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law // Testing for weak cross-sectional dependence

xtcse2 ln_cereal_yield L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, nocd // Estimating the $\alpha$ exponent without running a CD-Test

xthst ln_cereal_yield L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, ///
cr(ln_cereal_yield L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr L4.gov_consumption L4.rule_of_law) hac // Testing for slope homogeneity using Blomquist & Westerlund (2013)

xtdcce2 ln_cereal_yield L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, fast2 ///
cr(ln_cereal_yield L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr L4.gov_consumption L4.rule_of_law)
estimates store BCCEMG4

xtcd2 // Re-run tests for weak cross-section dependence

xtnumfac ln_cereal_yield L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, stand(5) // Calculating number of common factors

xtdcce2 ln_cereal_yield L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, fast2 ///
cr(ln_cereal_yield L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr L4.gov_consumption L4.rule_of_law, rcce(npc(2))) // Using regularized CCE-MG Estimator with cross-section averages and ER = 2 from Ahn & Horenstein (2013)
estimates store RBCCEMG4

xtdcce2 ln_cereal_yield L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, ///
cr(ln_cereal_yield L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, rccl) // Reporting Rank Condition Classifier from De Vos et al. (2024)

** Dependent variable: tfp **
*** Column (5) -  Common Correlated Effects (Mean Group) Estimator from Pesaran (2006) ***
xtcd2 tfp L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract, pesaran // Testing for weak cross-sectional dependence only using the CD-Test by Pesaran (2015)
xtcd2 tfp L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract // Testing for weak cross-sectional dependence
xtcse2 tfp L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract, nocd // Estimating the $\alpha$ exponent without running a CD-Test
xthst tfp L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract, cr(ln_cereal_yield L4.ln_i_lstock ln_i_fert L4.ln_i_tract) hac // Testing for slope homogeneity using Blomquist & Westerlund (2013)

xtdcce2 tfp L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract, fast2 ///
cr(tfp L4.ln_i_lstock ln_i_fert L4.ln_i_tract)
estimates store BCCEMG5

xtcd2 // Re-run tests for weak cross-section dependence

xtnumfac tfp L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract, stand(5) // Calculating number of common factors

xtdcce2 tfp L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract, reportc ///
cr(tfp L4.ln_i_lstock ln_i_fert L4.ln_i_tract, rcce(npc(2))) // Using regularized CCE-MG Estimator with cross-section averages and ER = 2 = GR from Ahn & Horenstein (2013)
estimates store RBCCEMG5

xtdcce2 tfp L4.mot_ceil ln_i_lstock ln_i_fert ln_i_tract, ///
cr(tfp L4.mot_ceil ln_i_lstock ln_i_fert ln_i_tract, rccl) // Reporting Rank Condition Classifier from De Vos et al. (2024)

*** Column (6) - Includes additional controls ***
xtcd2 tfp L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, pesaran // Testing for weak cross-sectional dependence only using the CD-Test by Pesaran (2015)

xtcd2 tfp L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law // Testing for weak cross-sectional dependence

xtcse2 tfp L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, nocd // Estimating the $\alpha$ exponent without running a CD-Test

xthst tfp L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, ///
cr(tfp L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr L4.gov_consumption L4.rule_of_law) hac // Testing for slope homogeneity using Blomquist & Westerlund (2013)

xtdcce2 tfp L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, fast2 ///
cr(tfp L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr L4.gov_consumption L4.rule_of_law)
estimates store BCCEMG6

xtcd2 // Re-run tests for weak cross-section dependence

xtnumfac tfp L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, stand(5) // Calculating number of common factors

xtdcce2 tfp L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, fast2 ///
cr(tfp L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr L4.gov_consumption L4.rule_of_law, rcce(npc(2))) // Using regularized CCE-MG Estimator with cross-section averages and ER = 2 from Ahn & Horenstein (2013)
estimates store RBCCEMG6

xtdcce2 tfp L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, ///
cr(tfp L4.mot_ceil L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, rccl) // Reporting Rank Condition Classifier from De Vos et al. (2024)

* ------------------------------------------------------------------------------

* Table 3_c
use "table3_c.dta", replace

** Dependent variable: ln_agout **
*** Column (1) - Common Correlated Effects (Mean Group) Estimator from Pesaran (2006) ***
xtcd2 ln_agout L4.mot_ten L4.ln_i_lstock ln_i_fert L4.ln_i_tract, pesaran // Testing for weak cross-sectional dependence only using the CD-Test by Pesaran (2015)
xtcd2 ln_agout L4.mot_ten L4.ln_i_lstock ln_i_fert L4.ln_i_tract // Testing for weak cross-sectional dependence
xtcse2 ln_agout L4.mot_ten L4.ln_i_lstock ln_i_fert L4.ln_i_tract, nocd // Estimating the $\alpha$ exponent without running a CD-Test
xthst ln_agout L4.mot_ten L4.ln_i_lstock ln_i_fert L4.ln_i_tract, cr(ln_agout L4.ln_i_lstock ln_i_fert L4.ln_i_tract) hac // Testing for slope homogeneity using Blomquist & Westerlund (2013)

xtdcce2 ln_agout L4.mot_ten L4.ln_i_lstock ln_i_fert L4.ln_i_tract, fast2 ///
cr(ln_agout L4.ln_i_lstock ln_i_fert L4.ln_i_tract)
estimates store CCCEMG1

xtcd2 // Re-run tests for weak cross-section dependence

xtnumfac ln_agout L4.mot_ten L4.ln_i_lstock ln_i_fert L4.ln_i_tract, stand(5) // Calculating number of common factors

xtdcce2 ln_agout L4.mot_ten L4.ln_i_lstock ln_i_fert L4.ln_i_tract, reportc ///
cr(ln_agout L4.ln_i_lstock ln_i_fert L4.ln_i_tract, rcce(npc(1))) // Using regularized CCE-MG Estimator with cross-section averages and ER = 1 = GR from Ahn & Horenstein (2013)
estimates store RCCCEMG1

xtdcce2 ln_agout L4.mot_ten ln_i_lstock ln_i_fert ln_i_tract, ///
cr(ln_agout L4.mot_ten ln_i_lstock ln_i_fert ln_i_tract, rccl) // Reporting Rank Condition Classifier from De Vos et al. (2024)

*** Column (2) - Includes additional controls ***
xtcd2 ln_agout L4.mot_ten L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, pesaran // Testing for weak cross-sectional dependence only using the CD-Test by Pesaran (2015)

xtcd2 ln_agout L4.mot_ten L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law // Testing for weak cross-sectional dependence

xtcse2 ln_agout L4.mot_ten L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, nocd // Estimating the $\alpha$ exponent without running a CD-Test

xthst ln_agout L4.mot_ten L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, ///
cr(ln_agout L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr L4.gov_consumption L4.rule_of_law) hac // Testing for slope homogeneity using Blomquist & Westerlund (2013)

xtdcce2 ln_agout L4.mot_ten L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, fast2 ///
cr(ln_agout L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr L4.gov_consumption L4.rule_of_law)
estimates store CCCEMG2

xtcd2 // Re-run tests for weak cross-section dependence

xtnumfac ln_agout L4.mot_ten L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, stand(5) // Calculating number of common factors

xtdcce2 ln_agout L4.mot_ten L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, fast2 ///
cr(ln_agout L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr L4.gov_consumption L4.rule_of_law, rcce(npc(1))) // Using regularized CCE-MG Estimator with cross-section averages and ER = 1 = GR from Ahn & Horenstein (2013)
estimates store RCCCEMG2

xtdcce2 ln_agout L4.mot_ten L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, ///
cr(ln_agout L4.mot_ten L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, rccl) // Reporting Rank Condition Classifier from De Vos et al. (2024)

** Dependent variable: ln_cereal_yield **
*** Column (3) -  Common Correlated Effects (Mean Group) Estimator from Pesaran (2006) ***
xtcd2 ln_cereal_yield L4.mot_ten L4.ln_i_lstock ln_i_fert L4.ln_i_tract, pesaran // Testing for weak cross-sectional dependence only using the CD-Test by Pesaran (2015)
xtcd2 ln_cereal_yield L4.mot_ten L4.ln_i_lstock ln_i_fert L4.ln_i_tract // Testing for weak cross-sectional dependence
xtcse2 ln_cereal_yield L4.mot_ten L4.ln_i_lstock ln_i_fert L4.ln_i_tract, nocd // Estimating the $\alpha$ exponent without running a CD-Test
xthst ln_cereal_yield L4.mot_ten L4.ln_i_lstock ln_i_fert L4.ln_i_tract, cr(ln_cereal_yield L4.ln_i_lstock ln_i_fert L4.ln_i_tract) hac // Testing for slope homogeneity using Blomquist & Westerlund (2013)

xtdcce2 ln_cereal_yield L4.mot_ten L4.ln_i_lstock ln_i_fert L4.ln_i_tract, fast2 ///
cr(ln_cereal_yield L4.ln_i_lstock ln_i_fert L4.ln_i_tract)
estimates store CCCEMG3

xtcd2 // Re-run tests for weak cross-section dependence

xtnumfac ln_cereal_yield L4.mot_ten L4.ln_i_lstock ln_i_fert L4.ln_i_tract, stand(5) // Calculating number of common factors

xtdcce2 ln_cereal_yield L4.mot_ten L4.ln_i_lstock ln_i_fert L4.ln_i_tract, reportc ///
cr(ln_cereal_yield L4.ln_i_lstock ln_i_fert L4.ln_i_tract, rcce(npc(3))) // Using regularized CCE-MG Estimator with cross-section averages and ER = 3 = GR from Ahn & Horenstein (2013)
estimates store RCCCEMG3

xtdcce2 ln_cereal_yield L4.mot_ten ln_i_lstock ln_i_fert ln_i_tract, ///
cr(ln_cereal_yield L4.mot_ten ln_i_lstock ln_i_fert ln_i_tract, rccl) // Reporting Rank Condition Classifier from De Vos et al. (2024)

*** Column (4) - Includes additional controls ***
xtcd2 ln_cereal_yield L4.mot_ten L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, pesaran // Testing for weak cross-sectional dependence only using the CD-Test by Pesaran (2015)

xtcd2 ln_cereal_yield L4.mot_ten L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law // Testing for weak cross-sectional dependence

xtcse2 ln_cereal_yield L4.mot_ten L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, nocd // Estimating the $\alpha$ exponent without running a CD-Test

xthst ln_cereal_yield L4.mot_ten L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, ///
cr(ln_cereal_yield L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr L4.gov_consumption L4.rule_of_law) hac // Testing for slope homogeneity using Blomquist & Westerlund (2013)

xtdcce2 ln_cereal_yield L4.mot_ten L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, fast2 ///
cr(ln_cereal_yield L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr L4.gov_consumption L4.rule_of_law)
estimates store CCCEMG4

xtcd2 // Re-run tests for weak cross-section dependence

xtnumfac ln_cereal_yield L4.mot_ten L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, stand(5) // Calculating number of common factors

xtdcce2 ln_cereal_yield L4.mot_ten L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, fast2 ///
cr(ln_cereal_yield L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr L4.gov_consumption L4.rule_of_law, rcce(npc(2))) // Using regularized CCE-MG Estimator with cross-section averages and ER = 2 = GR from Ahn & Horenstein (2013)
estimates store RCCCEMG4

xtdcce2 ln_cereal_yield L4.mot_ten L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, ///
cr(ln_cereal_yield L4.mot_ten L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, rccl) // Reporting Rank Condition Classifier from De Vos et al. (2024)

** Dependent variable: tfp **
*** Column (5) -  Common Correlated Effects (Mean Group) Estimator from Pesaran (2006) ***
xtcd2 tfp L4.mot_ten L4.ln_i_lstock ln_i_fert L4.ln_i_tract, pesaran // Testing for weak cross-sectional dependence only using the CD-Test by Pesaran (2015)
xtcd2 tfp L4.mot_ten L4.ln_i_lstock ln_i_fert L4.ln_i_tract // Testing for weak cross-sectional dependence
xtcse2 tfp L4.mot_ten L4.ln_i_lstock ln_i_fert L4.ln_i_tract, nocd // Estimating the $\alpha$ exponent without running a CD-Test
xthst tfp L4.mot_ten L4.ln_i_lstock ln_i_fert L4.ln_i_tract, cr(ln_cereal_yield L4.ln_i_lstock ln_i_fert L4.ln_i_tract) hac // Testing for slope homogeneity using Blomquist & Westerlund (2013)

xtdcce2 tfp L4.mot_ten L4.ln_i_lstock ln_i_fert L4.ln_i_tract, fast2 ///
cr(tfp L4.ln_i_lstock ln_i_fert L4.ln_i_tract)
estimates store CCCEMG5

xtcd2 // Re-run tests for weak cross-section dependence

xtnumfac tfp L4.mot_ten L4.ln_i_lstock ln_i_fert L4.ln_i_tract, stand(5) // Calculating number of common factors

xtdcce2 tfp L4.mot_ten L4.ln_i_lstock ln_i_fert L4.ln_i_tract, reportc ///
cr(tfp L4.ln_i_lstock ln_i_fert L4.ln_i_tract, rcce(npc(3))) // Using regularized CCE-MG Estimator with cross-section averages and ER = 3 = GR from Ahn & Horenstein (2013)
estimates store RCCCEMG5

xtdcce2 tfp L4.mot_ten ln_i_lstock ln_i_fert ln_i_tract, ///
cr(tfp L4.mot_ceil ln_i_lstock ln_i_fert ln_i_tract, rccl) // Reporting Rank Condition Classifier from De Vos et al. (2024)

*** Column (6) - Includes additional controls ***
xtcd2 tfp L4.mot_ten L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, pesaran // Testing for weak cross-sectional dependence only using the CD-Test by Pesaran (2015)

xtcd2 tfp L4.mot_ten L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law // Testing for weak cross-sectional dependence

xtcse2 tfp L4.mot_ten L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, nocd // Estimating the $\alpha$ exponent without running a CD-Test

xthst tfp L4.mot_ten L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, ///
cr(tfp L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr L4.gov_consumption L4.rule_of_law) hac // Testing for slope homogeneity using Blomquist & Westerlund (2013)

xtdcce2 tfp L4.mot_ten L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, fast2 ///
cr(tfp L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr L4.gov_consumption L4.rule_of_law)
estimates store CCCEMG6

xtcd2 // Re-run tests for weak cross-section dependence

xtnumfac tfp L4.mot_ten L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, stand(5) // Calculating number of common factors

xtdcce2 tfp L4.mot_ten L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, fast2 ///
cr(tfp L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr L4.gov_consumption L4.rule_of_law, rcce(npc(2))) // Using regularized CCE-MG Estimator with cross-section averages and ER = 2 from Ahn & Horenstein (2013)
estimates store RCCCEMG6

xtdcce2 tfp L4.mot_ten L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, ///
cr(tfp L4.mot_ten L4.ln_i_lstock ln_i_fert L4.ln_i_tract i_perarr inv_life_expectancy ln_tfr ///
L4.gov_consumption L4.rule_of_law, rccl) // Reporting Rank Condition Classifier from De Vos et al. (2024)
