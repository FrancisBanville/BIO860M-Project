# In this script, we evaluate graphically the relationship between different food-web measures

## Read the measures computed for all food webs archived on Mangal

foodweb_measures = CSV.read(joinpath("data", "foodweb_measures.csv"), DataFrame)


## Bivariate plots

# Error terms for total biomass and population stability
biomass_bottom = foodweb_measures.biomass_50 .- foodweb_measures.biomass_025
biomass_top = foodweb_measures.biomass_975 .- foodweb_measures.biomass_50

stab_bottom = foodweb_measures.stab_50 .- foodweb_measures.stab_025
stab_top = foodweb_measures.stab_975 .- foodweb_measures.stab_50

# Total biomass as a function of species richness
biomass_S = scatter(foodweb_measures.S, foodweb_measures.biomass_50,
        yerror=(biomass_bottom, biomass_top), markerstrokewidth=0.5,
        markercolor=RGB(204/255,121/255,167/255), markersize=6, alpha=0.7,
        legend=nothing, framestyle=:box)
xaxis!("Number of species")
yaxis!("Total biomass")

# Total biomass as a function of connectance
biomass_co = scatter(foodweb_measures.co, foodweb_measures.biomass_50,
        yerror=(biomass_bottom, biomass_top), markerstrokewidth=0.5,
        markercolor=RGB(204/255,121/255,167/255), markersize=6, alpha=0.7,
        legend=nothing, framestyle=:box)
xaxis!("Connectance")
yaxis!("Total biomass")

# Population stability as a function of species richness
stab_S = scatter(foodweb_measures.S, foodweb_measures.stab_50,
        yerror=(stab_bottom, stab_top), markerstrokewidth=0.5,
        markercolor=RGB(204/255,121/255,167/255), markersize=6, alpha=0.7,
        legend=nothing, framestyle=:box)
xaxis!("Number of species")
yaxis!("Population stability")

# Population stability as a function of connectance
stab_co = scatter(foodweb_measures.co, foodweb_measures.stab_50,
        yerror=(stab_bottom, stab_top), markerstrokewidth=0.5,
        markercolor=RGB(204/255,121/255,167/255), markersize=6, alpha=0.7,
        legend=nothing, framestyle=:box)
xaxis!("Connectance")
yaxis!("Population stability")


# Put all plots together
plot(biomass_S, biomass_co, stab_S, stab_co,
    layout=(2,2), size=(700,700),  margin=5Plots.mm, dpi=200,
    title=["(a)" "(b)" "(c)" "(d)"], titleloc=:left, titlefont = font(8))
savefig(joinpath("figures", "bivariate_relationships"))
