using PrecompileTools

@setup_workload begin
    # Minimal setup - only use things that are already dependencies
    using Distributions: Normal

    @compile_workload begin
        # Precompile GenericDistribution creation with Normal
        gd = GenericDistribution(Normal(0.0, 1.0))

        # Precompile simple ExpectationProblem creation
        g(u, p) = u[1]
        exprob = ExpectationProblem(g, gd, nothing)

        # Precompile MonteCarlo solve (fast, common use case)
        sol_mc = solve(exprob, MonteCarlo(10))

        # Precompile Koopman solve (slower, but important for TTFX)
        sol_k = solve(exprob, Koopman())
    end
end
