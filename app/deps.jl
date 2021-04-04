using Pkg

Pkg.update()

pkg"activate . "

cd(@__DIR__)
ROOT_PATH = pwd()
push!(LOAD_PATH, ROOT_PATH, "src")

pkg"instantiate"
pkg"precompile"

