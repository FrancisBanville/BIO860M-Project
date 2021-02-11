---
bibliography: [references.bib]
---
# Introduction

## Biodiversity and ecosystem functioning

## Network structure and ecosystem functioning

## Aim of this study

# Methods

## Data

## Food-web measures

## Structural equation models

I evaluated the fit of seven structural equation models against my data. The most saturated model is represented by @eq:mod6.

$$Y = \beta_0 + \beta_{YS}S + \beta_{YC}C + \beta_{YN}N$$
$$ N = \beta_1 + \beta_{NS}S + \beta_{NC}C$$
$$ C = \beta_2 + \beta_{CS}S, $$ {#eq:mod6}

where $Y$ is the predicted variable (i.e. either total biomass or population stability), $S$ is species richness, $C$ is the connectance, and $N$ the nestedness of food webs. The subscripts ${ij}$ of the parameters indicate the hypothesized causal relationship between the corresponding variables $i$ and $j$ (i.e. $j \rightarrow i$). All of these parameters were estimated in model 6. I imposed further structure on the other six models (see @tbl:models).

| Model  | $\beta_0$ | $\beta_{YS}$ | $\beta_{YC}$ | $\beta_{YN}$ | $\beta_1$ | $\beta_{NS}$ | $\beta_{NC}$ | $\beta_2$ |$\beta_{CS}$ |
|:-------:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
| model 0 |  1 |  0 |  0 |  0 |  0 |  0 |  0 |  0 |  0 |
| model 1 |  1 |  1 |  0 |  0 |  0 |  0 |  0 |  0 |  0 |
| model 2 |  1 |  0 |  1 |  0 |  0 |  0 |  0 |  1 |  0 |
| model 3 |  1 |  1 |  1 |  0 |  0 |  0 |  0 |  1 |  1 |  
| model 4 |  1 |  0 |  1 |  1 |  1 |  0 |  1 |  1 |  0 |  
| model 5 |  1 |  1 |  1 |  1 |  1 |  0 |  1 |  1 |  1 |  
| model 6 |  1 |  1 |  1 |  1 |  1 |  1 |  1 |  1 |  1 |  

Table: **Model sets.** A parameter was either estimated (1) or not (0) in each of the seven structural equation models. The subscripts ${ij}$ of the parameters indicate the hypothesized causal relationship between the corresponding variables $i$ and $j$ (i.e. $j \rightarrow i$). $Y$ is the predicted variable (either total biomass or population stability), $S$ the species richness, $C$ the connectance, and $N$ the nestedness of a food web. The parameters $\beta_0$, $\beta_1$, and $\beta_2$ are the intercepts of $Y$, $N$, and $C$, respectively. {#tbl:models}

## Data and Code Availability
All code and data to reproduce this project are available on GitHub (https://github.com/FrancisBanville/BIO860M-Project).

# Results

## Bivariate relationships

![**Bivariate relationships between food-web measures.** (a-b) Relationship between total biomass and (a) species richness and (b) connectance. The total biomass of a community represents the sum of biomass for all species averaged over the last 10 timesteps of the simulations. (c-d) Relationship between population stability and (c) species richness and (d) connectance. The temporal stability of population biomass was estimated using the negative coefficient of variation of biomass across populations averaged over the last 10 timesteps of the simulations. Species richness and connectance were measured before simulating. All simulations (n=221 webs) were run over 500 timesteps and were repeated 50 times for every food web archived on `mangal.io` (except for 14 webs where simulation failed). In each panel, error bars indicate the 95% percentile intervals of total biomass and population stability, respectively.](figures/bivariate_relationships.png){#fig:bivariate}

## Selected model

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
| $\beta_{NS}$ |    0.001 |     2.5 |       0.01* |   
| $\beta_{NC}$ |      1.2 |    20.4 |   < 0.001***|   
| $\beta_{CS}$ |   -0.002 |    -8.7 |  < 0.001*** |    

Table: **Results of the path analysis for the prediction of total biomass using model 6.** All regression coefficients were signifiant at the significance level of $\alpha$ = 0.05 ($Y$ = total biomass, $S$ = species richness, $C$ = connectance, $N$ = nestedness). Model 6 was selected according to the information criterion. {#tbl:path_biomass}


| Coefficient  | estimate | z-value | p-value     |
|:------------:|:--------:|:-------:|:-----------:|
| $\beta_{YS}$ |    0.002 |     2.8 |     0.005** |
| $\beta_{YC}$ |    0.587 |     1.8 |       0.067 |
| $\beta_{YN}$ |   -0.082 |    -0.4 |       0.700 |
| $\beta_{NS}$ |    0.001 |     2.5 |       0.01* |   
| $\beta_{NC}$ |      1.2 |    20.4 |  < 0.001*** |   
| $\beta_{CS}$ |   -0.002 |    -8.7 |  < 0.001*** |

Table: **Results of the path analysis for the prediction of population stability using model 6.** All regression coefficients were signifiant at the significance level of $\alpha$ = 0.05, except for $\beta_{YC}$ and $\beta_{YN}$ ($Y$ = population stability, $S$ = species richness, $C$ = connectance, $N$ = nestedness). Model 6 was selected according to the information criterion. {#tbl:path_stability}

# Discussion

# References
