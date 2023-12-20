xtset Subject Trial

**Behavioral logistic reg
ttest Victoiret , by (cooperation)

**Behavioral logistic reg
xtlogit  Switch  Victoiret1 Victoiret2 Victoiret3  Switcht1 Switcht2 Switcht3   WsLsaa WsLsaat2 WsLsaat3, vce(cluster Subject)
margins, dydx(*)
marginsplot

**Switch and PE t-1
xtlogit Switch  c.PE_t1##subj_comp  , vce(cluster Subject )
margins, over(subj_comp ) at(c.PE_t1=(-1(0.1)1))
marginsplot
margins, dydx(c.PE_t1) over(rb0.subj_comp)

** Switch explained by controller valence
xtlogit  Switch  c.PE_t1##i.subj_comp , vce(cluster Subject)
margins, dydx(*)
margins rb1.subj_comp, dydx(c.PE_t1)

** but not by the real interaction mode
xtlogit  Switch  c.PE_t1##i.cooperation , vce(cluster Subject)
margins, dydx(*)
margins rb1.cooperation, dydx(c.PE_t1)

** Reliability difference regression
xtreg  controller  Victoiret1 Victoiret2 Victoiret3  Switcht1 Switcht2 Switcht3   WsLsaa WsLsaat2 WsLsaat3, vce(cluster Subject)
margins, dydx(*)
marginsplot


