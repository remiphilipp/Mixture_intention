** PLot the analysis of mixed intention model
twoway lfit Pcomp_expert  Pcoop_expert ||scatter Pcomp_expert Pcoop_expert , by(Subject)
twoway scatter abs_Vcomp_expert abs_Vcoop_expert
twoway lfit Comp_component  Coop_component ||scatter Comp_component Coop_component
