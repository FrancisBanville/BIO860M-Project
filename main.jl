# Activate project environment
import Pkg; Pkg.activate(".")

Pkg.instantiate()

# Load required packages
using CSV
using DataFrames
using Plots
using RCall
using Statistics

using BioEnergeticFoodWebs
using EcologicalNetworks
using Mangal

# Load R package (for path analysis)
# Install OpenMx from R using source('https://vipbg.vcu.edu/vipbg/OpenMx2/software/getOpenMx.R')
R"library(dplyr)"
R"library(lavaan)"
R"library(MuMIn)"
R"library(semPlot)"

# Load scripts
include("src/1-get_foodwebs_id.jl")
include("src/2-compute_structure_and_function.jl")
include("src/3-path_analysis.jl")
include("src/4-make_figures.jl")
