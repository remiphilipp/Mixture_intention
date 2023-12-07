** Proportion of stay in 320 simulated dataset for Influence Competitive and Cooperative
xtlogit Stay if mode == 7 , vce(cluster Subject)
margins, dydx(*)
xtlogit Stay if mode == 8, vce(cluster Subject)
margins, dydx(*)

**Behavioral logistic reg for the 320 simulated dataset with Influence Competitive (mode = 7), Cooperative (mode = 8) and mixed-intention (mode = 9)
xtlogit Stay wslsaa_Simulated wslsaa_Simulated_t2 wslsaa_Simulated_t3 Simulated_victory_t1 Simulated_victory_t2 Simulated_victory_t3 Stay_t1 Stay_t2 Stay_t3 if mode==7, vce(cluster Subject)
margins, dydx(*)
marginsplot

xtlogit Stay wslsaa_Simulated wslsaa_Simulated_t2 wslsaa_Simulated_t3 Simulated_victory_t1 Simulated_victory_t2 Simulated_victory_t3 Stay_t1 Stay_t2 Stay_t3 if mode==7, vce(cluster Subject)
margins, dydx(*)
marginsplot

xtlogit Stay wslsaa_Simulated wslsaa_Simulated_t2 wslsaa_Simulated_t3 Simulated_victory_t1 Simulated_victory_t2 Simulated_victory_t3 Stay_t1 Stay_t2 Stay_t3 if mode==7, vce(cluster Subject)
margins, dydx(*)
marginsplot
