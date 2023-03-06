mutable struct Sng

    n_sim::Int64
    n_items::Int64

end

mutable struct Free

    alpha::Float64
    gamma::Float64
    sigma::Float64
    delta::Float64

end

mutable struct Mat

    gradient::Array{Float64,2}
    activation::Array{Float64,1}
    r::Array{Float64,1}
    score::Array{Float64,1}

end