using Revise 
using ADCME 
using LinearAlgebra
using LineSearches
using JLD2 
using PyPlot 
include("../optimizers.jl")


using Random; Random.seed!(233)

x = LinRange(0, 1, 500)|>Array
y = sin.(10π*x)
θ = Variable(ae_init([1,20,20,20,1]))
z = squeeze(fc(x, [20, 20, 20, 1], θ))

loss = sum((z-y)^2)
sess = Session(); init(sess)
losses = Optimize!(sess, loss; optimizer = LBFGSOptimizer(), max_num_iter=2000, m = 50)


close("all")
plot(x, run(sess, z), label = "Adam")
plot(x, y, "--", label = "Reference")
xlabel("x"); ylabel("y")
legend()
savefig("data/bfgs.png")


@save "data/lbfgs.jld2" losses 


