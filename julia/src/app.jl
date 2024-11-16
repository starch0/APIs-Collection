using Oxygen
using HTTP
include("Database.jl")
include("routes.jl")

using .Database
@get "/" function(req::HTTP.Request)
    return "dale"
end


serve(port=8080)