**Behavioral logistic reg
xtlogit  Switch  Victoiret1 Victoiret2 Victoiret3  Switcht1 Switcht2 Switcht3   WsLsaa WsLsaat2 WsLsaat3, vce(cluster Subject)
margins, dydx(*)
marginsplot

**Switch and PE t-1
xtlogit Switch  c.PE_t1##subj_comp  , vce(cluster Subject )
margins, over(subj_comp ) at(c.PE_t1=(-1(0.1)1))
marginsplot
margins, dydx(c.PE_t1) over(rb0.subj_comp)


** Reliability difference regression
xtreg  controller  Victoiret1 Victoiret2 Victoiret3  Switcht1 Switcht2 Switcht3   WsLsaa WsLsaat2 WsLsaat3, vce(cluster Subject)
margins, dydx(*)
marginsplot


