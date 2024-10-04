using Pkg
Pkg.activate(".")
using Revise
using GLMakie


struct Point
    x::Real
    y::Real
    z::Real
end

function Point(x, y, z_func::Function)
    z = z_func(x, y)
    Point(x, y, z)
end

struct Edge
    from::Integer
    to::Integer
end

struct Triangle
    p1::Integer
    p2::Integer
    p3::Integer
end


positions = Dict{Integer, Vector{Real}}(
    1=>[-0.5, -0.5],
    2=>[0.5, -0.5],
    3=>[0.5, 0.5],
    4=>[-0.5, 0.5],
    5=>[-0.3, -0.5],
    6=>[-0.1, -0.5],
    7=>[0.1, -0.5],
    8=>[0.3, -0.5],
    9=>[0.5, -0.3],
    10=>[0.5, -0.1],
    11=>[0.5, 0.1],
    12=>[0.5, 0.3],
    13=>[0.3, 0.5],
    14=>[0.1, 0.5],
    15=>[-0.1, 0.5],
    16=>[-0.3, 0.5],
    17=>[-0.5, 0.3],
    18=>[-0.5, 0.1],
    19=>[-0.5, -0.1],
    20=>[-0.5, -0.3],
    21=>[-0.3, -0.3],
    22=>[-0.1, -0.3],
    23=>[0.1, -0.3],
    24=>[0.3, -0.3],
    25=>[0.3, -0.1],
    26=>[0.3, 0.1],
    27=>[0.3, 0.3],
    28=>[0.1, 0.3],
    29=>[-0.1, 0.3],
    30=>[-0.3, 0.3],
    31=>[-0.3, 0.1],
    32=>[-0.3, -0.1],
    33=>[-0.1, -0.1],
    34=>[0.1, -0.1],
    35=>[0.1, 0.1],
    36=>[-0.1, 0.1],
)


height(x, y) = 500 - (x^2 + y^2) * 10
# height(x, y) = 10


points = Point[]
for i in eachindex(1:length(positions))
    push!(points, Point(positions[i][1], positions[i][2], height))
end


edges = Edge[
    Edge(1, 5),         #1
    Edge(5, 6),         #2
    Edge(6, 7),         #3
    Edge(7, 8),         #4
    Edge(8, 2),         #5
    Edge(2, 9),         #6
    Edge(9, 10),         #7
    Edge(10, 11),         #8
    Edge(11, 12),         #9
    Edge(12, 3),         #10
    Edge(3, 13),         #11
    Edge(13, 14),         #12
    Edge(14, 15),         #13
    Edge(15, 16),         #14
    Edge(16, 4),         #15
    Edge(4, 17),         #16
    Edge(17, 18),         #17
    Edge(18, 19),         #18
    Edge(19, 20),         #19
    Edge(20, 1),         #20
    Edge(20, 21),         #21
    Edge(21, 22),         #22
    Edge(22, 23),         #23
    Edge(23, 24),         #24
    Edge(24, 9),         #25
    Edge(19, 32),         #26
    Edge(32, 33),         #27
    Edge(33, 34),         #28
    Edge(34, 25),         #29
    Edge(25, 10),         #30
    Edge(18, 31),         #31
    Edge(31, 36),         #32
    Edge(36, 35),         #33
    Edge(35, 26),         #34
    Edge(26, 11),         #35
    Edge(17, 30),         #36
    Edge(30, 29),         #37
    Edge(29, 28),         #38
    Edge(28, 27),         #39
    Edge(27, 12),         #40
    Edge(5, 21),         #41
    Edge(21, 32),         #42
    Edge(32, 31),         #43
    Edge(31, 30),         #44
    Edge(30, 16),         #45
    Edge(6, 22),         #46
    Edge(22, 33),         #47
    Edge(33, 36),         #48
    Edge(36, 29),         #49
    Edge(29, 15),         #50
    Edge(7, 23),         #51
    Edge(23, 34),         #52
    Edge(34, 35),         #53
    Edge(35, 28),         #54
    Edge(28, 14),         #55
    Edge(8, 24),         #56
    Edge(24, 25),         #57
    Edge(25, 26),         #58
    Edge(26, 27),         #59
    Edge(27, 13),         #60
    Edge(1, 21),         #61
    Edge(5, 22),         #62
    Edge(6, 23),         #63
    Edge(7, 24),         #64
    Edge(8, 9),         #65
    Edge(20, 32),         #66
    Edge(21, 33),         #67
    Edge(22, 34),         #68
    Edge(23, 25),         #69
    Edge(24, 10),         #70
    Edge(19, 31),         #71
    Edge(32, 36),         #72
    Edge(33, 35),         #73
    Edge(34, 26),         #74
    Edge(25, 11),         #75
    Edge(18, 30),         #76
    Edge(31, 29),         #77
    Edge(36, 28),         #78
    Edge(35, 27),         #79
    Edge(26, 12),         #80
    Edge(17, 16),         #81
    Edge(30, 15),         #82
    Edge(29, 14),         #83
    Edge(28, 13),         #84
    Edge(27, 3),         #85
]

triangles = Triangle[
    Triangle(1,5,21),
    Triangle(5,6,22),
    Triangle(6,7,23),
    Triangle(7,8,24),
    Triangle(8,2,9),
    Triangle(1,21,20),
    Triangle(5,22,21),
    Triangle(6,23,22),
    Triangle(7,24,23),
    Triangle(8,9,24),
    Triangle(20,21,32),
    Triangle(21,22,33),
    Triangle(22,23,34),
    Triangle(23,24,25),
    Triangle(24,9,10),
    Triangle(20,32,19),
    Triangle(21,33,32),
    Triangle(22,34,33),
    Triangle(23,25,34),
    Triangle(24,10,9),
    Triangle(19,32,31),
    Triangle(32,33,36),
    Triangle(33,34,35),
    Triangle(35,25,26),
    Triangle(25,10,11),
    Triangle(19,31,18),
    Triangle(32,36,31),
    Triangle(33,35,36),
    Triangle(34,26,35),
    Triangle(25,11,26),
    Triangle(18,31,30),
    Triangle(31,36,29),
    Triangle(36,35,28),
    Triangle(35,26,27),
    Triangle(26,11,12),
    Triangle(18,30,17),
    Triangle(31,29,30),
    Triangle(36,28,29),
    Triangle(35,27,28),
    Triangle(26,12,27),
    Triangle(17,30,16),
    Triangle(30,29,15),
    Triangle(29,28,14),
    Triangle(28,27,13),
    Triangle(27,12,3),
    Triangle(17,16,4),
    Triangle(30,15,16),
    Triangle(29,14,15),
    Triangle(28,13,14),
    Triangle(27,3,13),
]

struct Surface
    points::Vector{Point}
    edges::Vector{Edge}
    triangles::Vector{Triangle}
end

s = Surface(points, edges, triangles)
zlimits = (round(minimum([p.z for p in s.points]) - 1.0), round(maximum([p.z for p in s.points]) + 1.0))


function calculate_area(t::Integer, s::Surface)
    x1 = s.points[s.triangles[t].p1].x
    y1 = s.points[s.triangles[t].p1].y
    z1 = s.points[s.triangles[t].p1].z
    x2 = s.points[s.triangles[t].p2].x
    y2 = s.points[s.triangles[t].p2].y
    z2 = s.points[s.triangles[t].p2].z
    x3 = s.points[s.triangles[t].p3].x
    y3 = s.points[s.triangles[t].p3].y
    z3 = s.points[s.triangles[t].p3].z
    u1 = x2 - x1
    u2 = y2 - y1
    u3 = z2 - z1
    v1 = x3 - x1
    v2 = y3 - y1
    v3 = z3 - z1
    0.5 * sqrt((u2*v3 - u3*v2)^2 + (u3*v1-u1*v3)^2 + (u1*v2-u2*v1)^2)
end

# areas = [calculate_area(i, surface) for i in 1:length(triangles)]

function calculate_area(s::Surface)
    area = 0.0
    for i in 1:length(s.triangles)
        area +=  calculate_area(i,s)
    end
    return area
end


function plot_surface(s::Surface; zlimits=nothing)
    with_theme(theme_latexfonts()) do
    fig = Figure(size=(800, 600))
    ax = Axis3(fig[1,1])
    surface!(ax,
        [p.x for p in s.points], 
        [p.y for p in s.points],
        [p.z for p in s.points],
        )
    if !isnothing(zlimits)
        zlims!(ax, zlimits)
    end
    fig
    end
end

function plot_surface!(s::Surface, fig::Figure; zlimits=nothing)
    with_theme(theme_latexfonts()) do
        ax = contents(fig[1, 1])[1]
        empty!(ax)
        surface!(ax,
        [p.x for p in s.points], 
        [p.y for p in s.points],
        [p.z for p in s.points],
        )
        if !isnothing(zlimits)
            zlims!(ax, zlimits)
        end
    display(fig)
    end
end

calculate_area(s)
plot_surface(s; zlimits)


using QuasiMonteCarlo
deviation = 0.01
lower_bounds = [-deviation for _ in Base.oneto(length(positions))]
upper_bounds = [deviation for _ in Base.oneto(length(positions))]
number_of_samples = 1000000
dimensions = length(positions) 

perturbations = QuasiMonteCarlo.sample(number_of_samples, lower_bounds, upper_bounds, SobolSample())


function perturb(surface::Surface, perturbation::Vector{Float64})
    new_surface = deepcopy(surface)
    if length(perturbation) == length(surface.points)
        for i in eachindex(1:length(surface.points)),
            x = surface.points[i].x
            y = surface.points[i].y
            z = surface.points[i].z + perturbation[i]
            new_surface.points[i] = Point(x, y, z)
        end 
    end
    return new_surface
end


# perturbed_surface = perturb(s, perturbations[:, 2])
# perturbed_area = calculate_area(perturbed_surface)
# plot_surface(perturbed_surface)


MC_areas = zeros(number_of_samples)
fig = with_theme(theme_latexfonts()) do
fig = Figure(size=(800, 600))
Axis3(fig[1,1])
fig
end;

using ProgressMeter

@showprogress desc="Computing..." for i in eachindex(1:number_of_samples)
    perturbed_surface = perturb(s, perturbations[:, i])
    # plot_surface!(perturbed_surface, fig; zlimits)
    MC_areas[i] = calculate_area(perturbed_surface)
    # sleep(0.00001)
end

using Statistics

MC_areas
calculate_area(s)
mean_area = mean(MC_areas)
variance = (std(MC_areas))^2