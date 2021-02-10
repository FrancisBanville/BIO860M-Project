# In this script, we import food webs using their ID numbers, measure their structure and simulate their biomass flows

## Read all food webs from mangal.io and convert them to unipartie networks
mangal_foodwebs = CSV.read(joinpath("data", "mangal_foodwebs.csv"), DataFrame)

# remove the biggest food web (outlier with 714 species)
mangal_foodwebs = mangal_foodwebs[mangal_foodwebs.S .!= maximum(mangal_foodwebs.S), :]

# read all food webs archived on mangal.io
foodwebs = network.(mangal_foodwebs.id)

# convert MangalNetworks to UnipartiteNetworks
unipartite_foodwebs = convert.(UnipartiteNetwork, foodwebs)


## Compute food-web structure

# S: species richness (number of species)
# co: connectance (S/L2)
# nested: nestedness (spectral radius of the adjacency matrix)
# biomass: total biomass after simulation
# stab: population stability (mean of the negative coefficient of variations of all species)
# numbers correspond to the quantiles associated with the 95% percentile interval (2.5th and 97.5th percentiles) along with the median (50th percentile)

number_of_foodwebs = length(unipartite_foodwebs)

foodweb_measures = DataFrame(fill(Float64, 9),
                 [:S, :co, :nested,
                 :biomass_025, :biomass_50, :biomass_975,
                 :stab_025, :stab_50, :stab_975],
                 number_of_foodwebs)

foodweb_measures.S = richness.(unipartite_foodwebs)
foodweb_measures.co = connectance.(unipartite_foodwebs)
foodweb_measures.nested = ρ.(unipartite_foodwebs)


## Simulate ecosystem functioning

# Simulate biomass flows for unipartite network objects (500 iterations)
simulate_biomass = function(unipartite_network)

    # select the network's adjacency matrix
    edges = unipartite_network.edges
    A = convert(Array{Int64,2}, Matrix(edges))

    # simulate biomass flows
    p = model_parameters(A)
    b = rand(size(A, 1))
    s = simulate(p, b, start=0, stop=500)

    return s
end

# Total biomass production and population stability of a unipartite network after n simulations
# Returns the median and the 5th and 95th percentiles
simulate_functioning = function(unipartite_network, n)
    biomass = zeros(n)
    stability = zeros(n)

    for i in 1:n
        s = simulate_biomass(unipartite_network)
        biomass[i] = total_biomass(s, last=10)
        stability[i] = population_stability(s, last=10)
    end

    filter!(!isnan, biomass)
    filter!(!isnan, stability)

    measures = DataFrame(fill(Float64, 6),
                [:biomass_025, :biomass_50, :biomass_975,
                 :stab_025, :stab_50, :stab_975], 1)

    measures[1, :biomass_025] = quantile(biomass, 0.025)
    measures[1, :biomass_50] = quantile(biomass, 0.50)
    measures[1, :biomass_975] = quantile(biomass, 0.975)
    measures[1, :stab_025] = quantile(stability, 0.025)
    measures[1, :stab_50] = quantile(stability, 0.50)
    measures[1, :stab_975] = quantile(stability, 0.975)

    return measures
end

# Simulate total biomass and population stability
for i in 1:number_of_foodwebs
    try
        measures = simulate_functioning(unipartite_foodwebs[i], 50)
        foodweb_measures[i, :biomass_025] = measures[1, :biomass_025]
        foodweb_measures[i, :biomass_50] = measures[1, :biomass_50]
        foodweb_measures[i, :biomass_975] = measures[1, :biomass_975]
        foodweb_measures[i, :stab_025] = measures[1, :stab_025]
        foodweb_measures[i, :stab_50] = measures[1, :stab_50]
        foodweb_measures[i, :stab_975] = measures[1, :stab_975]
    catch
        println("Could not simulate food web $(i)")
    end
end

# remove food webs that could not be simulated
foodweb_measures_full = foodweb_measures[foodweb_measures.biomass_50 .> 0.001, :]

# Write data frame
CSV.write(joinpath("data", "foodweb_measures.csv"), foodweb_measures_full)
