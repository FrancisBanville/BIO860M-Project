# In this script, we execute and compare different path analysis models
# We predict total biomass and population stability separately
# We call R functions and packages because path analysis is more developed in R

# Load food-web measures
foodweb_measures = CSV.read(joinpath("data", "foodweb_measures.csv"), DataFrame)

# Transfer data frame to R environment
@rput foodweb_measures


## Definining the models

# Predictive models of total biomass
biomass_model0 = "biomass_50 ~ 1"

biomass_model1 = "biomass_50 ~ S"

biomass_model2 = "biomass_50 ~ co"

biomass_model3 = "biomass_50 ~ S + co
                  co ~ S"

biomass_model4 = "biomass_50 ~ co + nested
                  nested ~ co"

biomass_model5 = "biomass_50 ~ S + co + nested
                  co ~ S
                  nested ~ co"

biomass_model6 = "biomass_50 ~ S + co + nested
                  co ~ S
                  nested ~ S + co"


# Predictive models of population stability
stab_model0 = "stab_50 ~ 1"

stab_model1 = "stab_50 ~ S"

stab_model2 = "stab_50 ~ co"

stab_model3 = "stab_50 ~ S + co
               co ~ S"

stab_model4 = "stab_50 ~ co + nested
              nested ~ co"

stab_model5 = "stab_50 ~ S + co + nested
               co ~ S
               nested ~ co"

stab_model6 = "stab_50 ~ S + co + nested
               co ~ S
               nested ~ S + co"


# Transfer models to R
@rput biomass_model0 biomass_model1 biomass_model2 biomass_model3 biomass_model4 biomass_model5 biomass_model6
@rput stab_model0 stab_model1 stab_model2 stab_model3 stab_model4 stab_model5 stab_model6


## Fitting the models

# Predictive models of total biomass
R"biomass_fit0 <- sem(biomass_model0, meanstructure=TRUE, data=foodweb_measures)"
R"biomass_fit1 <- sem(biomass_model1, meanstructure=TRUE, data=foodweb_measures)"
R"biomass_fit2 <- sem(biomass_model2, meanstructure=TRUE, data=foodweb_measures)"
R"biomass_fit3 <- sem(biomass_model3, meanstructure=TRUE, data=foodweb_measures)"
R"biomass_fit4 <- sem(biomass_model4, meanstructure=TRUE, data=foodweb_measures)"
R"biomass_fit5 <- sem(biomass_model5, meanstructure=TRUE, data=foodweb_measures)"
R"biomass_fit6 <- sem(biomass_model6, meanstructure=TRUE, data=foodweb_measures)"


# Predictive models of population stability
R"stab_fit0 <- sem(stab_model0, meanstructure=TRUE, data=foodweb_measures)"
R"stab_fit1 <- sem(stab_model1, meanstructure=TRUE, data=foodweb_measures)"
R"stab_fit2 <- sem(stab_model2, meanstructure=TRUE, data=foodweb_measures)"
R"stab_fit3 <- sem(stab_model3, meanstructure=TRUE, data=foodweb_measures)"
R"stab_fit4 <- sem(stab_model4, meanstructure=TRUE, data=foodweb_measures)"
R"stab_fit5 <- sem(stab_model5, meanstructure=TRUE, data=foodweb_measures)"
R"stab_fit6 <- sem(stab_model6, meanstructure=TRUE, data=foodweb_measures)"


## Model comparison

# Predictive models of total biomass
R"biomass_AIC <- AIC(biomass_fit0, biomass_fit1, biomass_fit2, biomass_fit3, biomass_fit4, biomass_fit5, biomass_fit6)"
R"Weights(biomass_AIC)"

# Predictive models of population stability
R"stab_AIC <- AIC(stab_fit0, stab_fit1, stab_fit2, stab_fit3, stab_fit4, stab_fit5, stab_fit6)"
R"Weights(stab_AIC)"


## Visualization of the best models

# Predictive model of total biomass
R"summary(biomass_fit6)"

# Print a tidy table (total biomass)
begin
  R"
    parameterEstimates(biomass_fit6) %>%
      as_tibble() %>%
      filter(op=='~') %>%
      mutate(Term=paste(lhs, op, rhs)) %>%
      rename(estimate=est,
         p=pvalue) %>%
         select(Term, estimate, z, p) %>%
         pander::pander(caption='Regression parameters from `biomass_fit6`')
    "
end

# Generate graph (total biomass)
begin
  R"
    semPlot::semPaths(biomass_fit6, 'std',
        sizeMan=10, sizeInt=10, sizeLat=10,
        style='lisrel',
        layout='circle',
        edge.label.cex=0.9,
        curvePivot=TRUE,
        fade=FALSE,
        intercepts=FALSE,
        ThreshAtSide=TRUE,
        nodeLabels=c('biomass', 'Co', 'nestedness', 'S'),
        filename='figures/biomass_sem',
        filetype='png')
  "
end

# Predictive model of population stability
R"summary(stab_fit6)"

# Print a tidy table (population stability)
begin
  R"
    parameterEstimates(stab_fit6) %>%
      as_tibble() %>%
      filter(op=='~') %>%
      mutate(Term=paste(lhs, op, rhs)) %>%
      rename(estimate=est,
         p=pvalue) %>%
         select(Term, estimate, z, p) %>%
         pander::pander(caption='Regression parameters from `stab_fit6`')
    "
end

# Generate graph (population stability)
begin
  R"
    semPlot::semPaths(stab_fit6, 'std',
        style='lisrel',
        layout='circle',
        sizeMan = 10, sizeInt = 10, sizeLat = 10,
        edge.label.cex=0.9,
        curvePivot=TRUE,
        fade=FALSE,
        intercepts=FALSE,
        ThreshAtSide=TRUE,
        nodeLabels=c('stability', 'Co', 'nestedness', 'S'),
        filename='figures/stab_sem',
        filetype='png')
  "
end
