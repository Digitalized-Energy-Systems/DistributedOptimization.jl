
using Documenter, DistributedResourceOptimization, Test, Logging

logger = Test.TestLogger(min_level=Info);

with_logger(logger) do
    makedocs(
        modules=[DistributedResourceOptimization],
        format=Documenter.HTML(; assets=["assets/theme_overrides.css"], prettyurls=get(ENV, "CI", nothing) == "true"),
        authors="Rico Schrage",
        sitename="DistributedResourceOptimization.jl Documentation",
        pages=Any["Home"=>"index.md",
            "Getting Started"=>"getting_started.md",
            "Algorithms" => [
                "ADMM"=>"algorithms/admm.md",
                "COHDA"=>"algorithms/cohda.md",
            ],
            "Carrier" => [
                "Simple"=>"carrier/simple.md",
                "Mango"=>"carrier/mango.md",
            ],
            "API"=>"api.md"],
        repo="https://github.com/Digitalized-Energy-Systems/DistributedResourceOptimization.jl",
    )
end

for record in logger.logs
    @info record.message
    # Check if @example blocks did not succeed -> fail then
    if record.level == Warn && occursin("failed to run `@example` block", record.message)
        throw("Some Documentation example did not work, check the logs and fix the error.")
    end
end

deploydocs(
    repo="github.com/Digitalized-Energy-Systems/DistributedResourceOptimization.jl.git",
    push_preview=true,
    devbranch="main"
)