---
bibliography: [references.bib]
---
# Introduction

## Biodiversity and ecosystem functioning

## Network structure and ecosystem functioning

## Aim of this study

# Methods

## Data

All food webs used in this study were queried from [`mangal.io`](https://mangal.io/#/), an extensive database of published ecological networks worldwide [@Poisot2016ManMak]. Networks archived on Mangal are multilayer networks, i.e. different types of interactions can be found in the same network. I considered as food webs all networks whose interactions were mainly of trophic type (i.e. predation and herbivory interactions). When writing these lines, 235 networks correspond to that definition. I removed the largest food web ($S$ = 714 species) from my dataset since it significantly increased total simulation time. My final dataset thus contained a total of 234 food webs whose number of species ranged between 5 and 106 ($\bar{S}$ = 32.6, $s$ = 19.1).

## Food-web measures and biomass flows

I measured α-diversity by the number of nodes (species) $S$ in each network. Food-web structure was also described by their connectance and nestedness. Connectance represents the proportion of realized links in ecological networks ($C=L/S^2$, where $L$ is the number of interactions), and has been associated with many other properties of network structure [@Poisot2014WheEco], including nestedness. The nestedness of an ecological network represents the extent to which species interacting with specialists are a subset of species interacting with generalists. Nestedness was estimated by the spectral radius (i.e. the largest eigenvalue) of the adjacency matrix [@Staniczenko2013GhoNesa]. Because of its tight association with network modularity [@Fortuna2010NesModa], computing the nestedness of a network is comparable to estimating its modularity (i.e. network compartmentalization). However, nestedness is perhaps orders of magnitude easier and faster to measure than modularity.

Moreover, ecosystem functioning was simulated using the model of @Yodzis1992BodSiz of biomass flows in food webs, implemented in Julia v0.7.0 or newer by @Delmas2017SimBio. Indeed, to the best of my knowledge, no extensive dataset of species interactions and ecosystem functioning were available. In this context, I had to rely on first-order simulations to conduct my analysis. All model parameters (e.g. carrying capacities, body-mass ratios, growth rates, coefficients of interspecific competition, *etc.*) were kept to their default values. In the absence of empirical data on species biomass, the initial biomass of every species were sampled from a uniform distribution $U(0,1)$. This ensured that no further biases regarding initial values were introduced arbitrarily in the simulation process. Simulations of biomass flows were performed in 500 timesteps, and repeated 50 times for each food web. Because 13 food webs could not be simulated appropriately, I ended up with 221 simulated webs whose total biomass and population stability were measured and averaged over the last 10 timesteps. Total biomass was estimated as the sum of all species biomass, whereas population stability was measured as the mean of the negative coefficient of variation of species biomass [@Delmas2017SimBio]. I identified the median of both simulated measures for each web, as well as their 95% percentile intervals (2.5% and 97.5% quantiles).

## Structural equation models

To identify which emerging ecosystem properties drove the functioning of food webs, I evaluated the fit of seven structural equation models (SEMs) against my measured and simulated data. The most saturated model (model 6) is represented by @eq:mod6.

$$Y = \beta_0 + \beta_{YS}S + \beta_{YC}C + \beta_{YN}N$$
$$ N = \beta_1 + \beta_{NS}S + \beta_{NC}C$$
$$ C = \beta_2 + \beta_{CS}S, $$ {#eq:mod6}

where $Y$ is the predicted variable (i.e. either total biomass or population stability), $S$ is species richness, $C$ the connectance, and $N$ the nestedness of all food webs. The subscripts ${ij}$ of the parameters indicate the hypothesized causal relationship between the corresponding variables $i$ and $j$ (i.e. $j \rightarrow i$). The parameters $\beta_0$, $\beta_1$, and $\beta_2$ are the model intercepts. All parameters were estimated in model 6 using the `lavaan` package v.0.6-7 in R. I imposed further structure on the other six models (see @tbl:models).

| Model  | $\beta_0$ | $\beta_{YS}$ | $\beta_{YC}$ | $\beta_{YN}$ | $\beta_1$ | $\beta_{NS}$ | $\beta_{NC}$ | $\beta_2$ |$\beta_{CS}$ |
|:-------:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
| model 0 |  1 |  0 |  0 |  0 |  0 |  0 |  0 |  0 |  0 |
| model 1 |  1 |  1 |  0 |  0 |  0 |  0 |  0 |  0 |  0 |
| model 2 |  1 |  0 |  1 |  0 |  0 |  0 |  0 |  0 |  0 |
| model 3 |  1 |  1 |  1 |  0 |  0 |  0 |  0 |  1 |  1 |  
| model 4 |  1 |  0 |  1 |  1 |  1 |  0 |  1 |  0 |  0 |  
| model 5 |  1 |  1 |  1 |  1 |  1 |  0 |  1 |  1 |  1 |  
| model 6 |  1 |  1 |  1 |  1 |  1 |  1 |  1 |  1 |  1 |  

Table: **Model sets.** Every parameter was either estimated (value=1) or not (value=0) in each of the seven structural equation models. The subscripts ${ij}$ of the parameters indicate the hypothesized causal relationship between the corresponding variables $i$ and $j$ (i.e. $j \rightarrow i$). $Y$ is the predicted variable (either total biomass or population stability), $S$ the number of species, $C$ the connectance, and $N$ the nestedness of a food web. The parameters $\beta_0$, $\beta_1$, and $\beta_2$ are the intercepts of $Y$, $N$, and $C$, respectively. {#tbl:models}

These seven structural equation models were fit against both $Y$ variables (i.e. total biomass and population stability) independently. I performed model selection using the Akaike information criterion (AIC) for both variables.  

## Data and code availability

All code and data to reproduce this project are available on GitHub (https://github.com/FrancisBanville/BIO860M-Project). Simulations and analyses were all performed in Julia v.1.5.3, except the structural equation modeling which was performed in R v.3.6.1.

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
