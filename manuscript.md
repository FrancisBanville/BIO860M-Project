---
bibliography: [references.bib]
---
# Introduction

# Methods

# Results

![**Bivariate relationships between food-web measures.** (a-b) Relationship between total biomass and (a) species richness and (b) connectance. The total biomass of a community represents the sum of biomass for all species averaged over the last 10 timesteps of the simulations. (c-d) Relationship between population stability and (c) species richness and (d) connectance. The temporal stability of population biomass was estimated using the negative coefficient of variation of biomass across populations averaged over the last 10 timesteps of the simulations. Species richness and connectance were measured before simulating. All simulations (n=221 webs) were run over 500 timesteps and were repeated 50 times for every food web archived on `mangal.io` (except for 14 webs where simulation failed). In each panel, error bars indicate the 95% percentile intervals of total biomass and population stability, respectively.](figures/bivariate_relationships.png){#fig:bivariate}

| Model | df | $\Delta$ AIC$_{biomass}$ | $\Delta$ AIC$_{stability}$ |
|:-----:|:--:|:------------------------:|:--------------------------:|
|     6 | 12 |                        0 |                          0 |
|     5 | 11 |                      4.1 |                        4.1 |
|     4 |  7 |                    718.2 |                      650.3 |
|     3 |  7 |                    722.5 |                      687.3 |   
|     2 |  3 |                   1441.3 |                     1333.3 |   
|     1 |  3 |                   1363.2 |                     1332.2 |   
|     0 |  2 |                   1475.8 |                     1333.1 |   

Table: **Model selection.** The difference of AIC scores between each model and the best model were computed for the two sets of models (i.e. the predictive models of total biomass and of population stability). Model 6 was the best model for both sets according to the information criterion. {#tbl:AIC}


| Coefficient  | estimate | z-value | p-value     |
|:------------:|:--------:|:-------:|:-----------:|
| $\beta_{YS}$ |     0.12 |     9.5 |  < 0.001*** |
| $\beta_{YC}$ |    -36.3 |    -6.0 |  < 0.001*** |
| $\beta_{YN}$ |    24.8  |     6.2 |  < 0.001*** |
| $\beta_{CS}$ |   -0.002 |    -8.7 |  < 0.001*** |   
| $\beta_{NS}$ |    0.001 |     2.5 |       0.01* |   
| $\beta_{NC}$ |      1.2 |    20.4 |   < 0.001***|   

Table: **Results of the path analysis for the prediction of total biomass using model 6.** All regression coefficients were signifiant at the significance level of $\alpha$ = 0.05 ($Y$ = total biomass, $S$ = species richness, $C$ = connectance, $N$ = nestedness). Model 6 was selected according to the information criterion. {#tbl:path_biomass}


| Coefficient  | estimate | z-value | p-value     |
|:------------:|:--------:|:-------:|:-----------:|
| $\beta_{YS}$ |    0.002 |     2.8 |     0.005** |
| $\beta_{YC}$ |    0.587 |     1.8 |       0.067 |
| $\beta_{YN}$ |   -0.082 |    -0.4 |       0.700 |
| $\beta_{CS}$ |   -0.002 |    -8.7 |  < 0.001*** |   
| $\beta_{NS}$ |    0.001 |     2.5 |       0.01* |   
| $\beta_{NC}$ |      1.2 |    20.4 |  < 0.001*** |   

Table: **Results of the path analysis for the prediction of population stability using model 6.** All regression coefficients were signifiant at the significance level of $\alpha$ = 0.05, except for $\beta_{YC}$ and $\beta_{YN}$ ($Y$ = population stability, $S$ = species richness, $C$ = connectance, $N$ = nestedness). Model 6 was selected according to the information criterion. {#tbl:path_stability}


# Discussion

# References
