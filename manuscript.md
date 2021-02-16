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

I measured $\alpha$-diversity by the number of nodes (species) $S$ in each network. Food-web structure was also described by their connectance and nestedness. Connectance represents the proportion of realized links in ecological networks ($C=L/S^2$, where $L$ is the number of interactions), and has been associated with many other properties of network structure [@Poisot2014WheEco], including nestedness. The nestedness of an ecological network represents the extent to which species interacting with specialists are a subset of species interacting with generalists. Nestedness was estimated by the spectral radius (i.e. the largest eigenvalue) of the adjacency matrix [@Staniczenko2013GhoNesa]. Because of its tight association with network modularity [@Fortuna2010NesModa], computing the nestedness of a network is comparable to estimating its modularity (i.e. network compartmentalization). However, nestedness is perhaps orders of magnitude easier and faster to measure than modularity.

Moreover, ecosystem functioning was simulated using the model of @Yodzis1992BodSiz of biomass flows in food webs, implemented in Julia v0.7.0 or newer [@Delmas2021SimBio]. Indeed, to the best of my knowledge, no extensive dataset of species interactions and ecosystem functioning were available. In this context, I had to rely on first-order simulations to conduct my analysis. All model parameters (e.g. carrying capacities, body-mass ratios, growth rates, coefficients of interspecific competition, *etc.*) were kept to their default values [@Delmas2017SimBio; @Delmas2021SimBio]. In the absence of empirical data on species biomass, the initial biomass of every species in the model were sampled from a uniform distribution $U(0,1)$. This ensured that no further biases regarding initial values were introduced arbitrarily in the simulation process. Simulations of biomass flows were performed for 500 timesteps, and repeated 50 times for each food web. Because 13 food webs could not be simulated appropriately, I ended up with 221 simulated webs whose total biomass and population stability were measured and averaged over the last 10 timesteps. Total biomass was estimated as the sum of all species biomass at the end of simulation, whereas population stability was measured as the mean of the negative coefficient of variation of species biomass [@Delmas2017SimBio]. I identified the median of both simulated measures for each web, as well as their 95% percentile intervals (2.5% and 97.5% quantiles).

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

## Model selection

The most saturated model (model 6) was the best fit model for both the prediction of total biomass and population stability (@tbl:AIC). However, model 5 was also a really good fit to the data, with a $\Delta$ AIC of 4.1 for the two predicted variables. In both cases, model 6 had an Akaike weight of 88.7% and model 5 had the remaining 11.3%. Model 6 only differed from model 5 by the imposed relationship between species richness and nestedness. Therefore, using an ensemble model did not seem necessary to me. Model 6 was thus selected as the unique best structural equation model.

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

## Path analysis

All direct and indirect relationships between measures of ecosystem functioning, biodiversity and food-web structure were analyzed using model 6. Regression coefficients between pairs of variables are listed in @tbl:path_biomass for the prediction of total biomass and in @tbl:path_stability for the prediction of population stability.

The total biomass of the community after simulation was positively associated with the total number of species and the nestedness of food webs at the beginning of the simulation, but negatively associated with connectance (@tbl:path_biomass). However, since both measures of food-web structure were associated with species richness, species richness also shaped total biomass through these indirect pathways.

| Coefficient  | estimate | z-value | p-value     |
|:------------:|:--------:|:-------:|:-----------:|
| $\beta_{YS}$ |     0.12 |     9.5 |  < 0.001*** |
| $\beta_{YC}$ |    -36.3 |    -6.0 |  < 0.001*** |
| $\beta_{YN}$ |    24.8  |     6.2 |  < 0.001*** |  
| $\beta_{NS}$ |    0.001 |     2.5 |       0.01* |   
| $\beta_{NC}$ |      1.2 |    20.4 |   < 0.001***|   
| $\beta_{CS}$ |   -0.002 |    -8.7 |  < 0.001*** |    

Table: **Results of the path analysis for the prediction of total biomass using model 6.** All regression coefficients were signifiant at the significance level of $\alpha$ = 0.05 ($Y$ = total biomass, $S$ = species richness, $C$ = connectance, $N$ = nestedness). Model 6 was selected according to the information criterion. {#tbl:path_biomass}

These relationships were weaker when model 6 was used to predict population stability (@tbl:path_stability). Population stability was not significantly associated with either measure of network structure, but was only weakly associated with species richness.

| Coefficient  | estimate | z-value | p-value     |
|:------------:|:--------:|:-------:|:-----------:|
| $\beta_{YS}$ |    0.002 |     2.8 |     0.005** |
| $\beta_{YC}$ |    0.587 |     1.8 |       0.067 |
| $\beta_{YN}$ |   -0.082 |    -0.4 |       0.700 |
| $\beta_{NS}$ |    0.001 |     2.5 |       0.01* |   
| $\beta_{NC}$ |      1.2 |    20.4 |  < 0.001*** |   
| $\beta_{CS}$ |   -0.002 |    -8.7 |  < 0.001*** |

Table: **Results of the path analysis for the prediction of population stability using model 6.** All regression coefficients were signifiant at the significance level of $\alpha$ = 0.05, except for $\beta_{YC}$ and $\beta_{YN}$ ($Y$ = population stability, $S$ = species richness, $C$ = connectance, $N$ = nestedness). Model 6 was selected according to the information criterion. {#tbl:path_stability}

Bivariate relationships between measures of ecosystem functioning and measures of biodiversity and food-web structure were plotted in @fig:bivariate. We can identify the positive relationship between total biomass and species richness, and its negative relationship with connectance. However, the confidence intervals around the point estimates of total biomass were wider for food webs with more species and narrower for networks with high connectance. On the other hand, the weak relationship between population stability and species richness is not easily observable in @fig:bivariate.

![**Bivariate relationships between food-web measures.** (a-b) Relationship between total biomass and (a) species richness and (b) connectance. The total biomass of a community represents the sum of biomass for all species averaged over the last 10 timesteps of the simulations. (c-d) Relationship between population stability and (c) species richness and (d) connectance. The temporal stability of population biomass was estimated using the negative coefficient of variation of biomass across populations averaged over the last 10 timesteps of the simulations. Species richness and connectance were measured before simulating. All simulations (n=221 webs) were run over 500 timesteps and were repeated 50 times for every food web archived on `mangal.io` (except for the largest web and 13 webs where simulation failed). In each panel, error bars indicate the 95% percentile intervals of total biomass and population stability, respectively.](figures/bivariate_relationships.png){#fig:bivariate}

# Discussion

## Biodiversity and ecosystem functioning: direct pathways

My study suggests that biodiversity remains an important driver of ecosystem functioning, independently of food-web structure. First, the total biomass of a biological community at the end of my simulations increased with the total number of species. The positive relationship between biomass productivity and species richness uncovered in my study was previously observed in various systems and taxa [@Mittelbach2001WhaObs] and at different spatial scales [@Gonzalez2020ScaBio]. More diverse systems might indeed use resources and nutrients more efficiently than homogeneous communities because of niche complementarities [@Tilman1996ProSus].

Moreover, I found that the temporal stability of species biomass also increased with species richness. This is in agreement with the work of @Ives2000StaSpe and @Gross2014SpeRic. Species typically have different levels of tolerance to the variation of environmental conditions and to the variation of other species' abundances. A decrease of biomass from a given species might be compensated by an increase of biomass from another species in the community. A high number of species might promote ecosystem stability because of a higher probability of finding complementary species. However, the positive relationship between population stability and species richness uncovered in this study seems to be in disagreement with the work of @May1972WilLar, @Allesina2012StaCrib, and @MacDonald2020RevLin, who found that the probability of a network to be stable decreases with species richness. This might however be due to differences in the definitions and measures used to describe ecosystem stability (biomass stability vs food-web stability).

The relationship between other measures of biodiversity, such as species evenness and measures of $\beta$-diversity, and ecosystem functioning should also be investigated alongside measures of network structure. This might unveil intriguing aspects of the BEF relationship in the light of food-web structure.

## Biodiversity and ecosystem functioning: indirect pathways

Species richness also drove food-web functioning through indirect pathways. For example, species richness was negatively associated with food-web connectance, which was positively associated with total biomass. This was however in contrast with the relationship between species richness and population stability, which did not have any indirect pathways through food-web structure.

The bioenergetic model of biomass flows of @Yodzis1992BodSiz and @Delmas2017SimBio allowed me to simulate ecosystem functioning of many published food webs. This model was useful to make first order predictions of total biomass and population stability. However, many parameter values were set to their default values or sampled from a non-biased distribution (i.e. a uniform distribution), although they were probably system specific. To the best of my knowledge, no empirical data was available to validate this choice of parameter values in a broad range of food webs. When collecting data on species interactions, ecologists should estimate as much as possible the biomass of individual species. This would enable the conduction of more extensive studies on biodiversity and ecosystem functioning. Overall, my results nevertheless highlight the importance of considering network structure when describing the biodiversity-ecosystem functioning (BEF) relationship, especially with regards to biomass production.

# References
