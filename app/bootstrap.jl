cd(@__DIR__)
import Pkg
Pkg.pkg"activate ."

ROOT_PATH = pwd()
push!(LOAD_PATH, ROOT_PATH, "src")

include(joinpath("src", "HelloWorldServer.jl"))
include("server.jl")

