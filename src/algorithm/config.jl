abstract type BranchingRule end
struct MostInfeasible <: BranchingRule end
struct PseudocostBranching <: BranchingRule end

const DEFAULT_LP_SOLVER_FACTORY = state -> Gurobi.Optimizer(state.gurobi_env)
const DEFAULT_BRANCHING_RULE = MostInfeasible()
const DEFAULT_NODE_LIMIT = 1_000
const DEFAULT_GAP_TOL = 1e-4
const DEFAULT_INTEGRALITY_TOL = 1e-8

mutable struct AlgorithmConfig
    lp_solver_factory::Function
    branching_rule::BranchingRule
    node_limit::Int
    gap_tol::Float64
    int_tol::Float64

    function AlgorithmConfig(;
        lp_solver_factory::Function=DEFAULT_LP_SOLVER_FACTORY,
        branching_rule::BranchingRule=DEFAULT_BRANCHING_RULE,
        node_limit::Real=DEFAULT_NODE_LIMIT,
        gap_tol::Real=DEFAULT_GAP_TOL,
        int_tol::Real=DEFAULT_INTEGRALITY_TOL,
    )
        @assert node_limit >= 0
        @assert isinteger(node_limit)
        @assert gap_tol >= 0
        @assert int_tol >= 0
        return new(
            lp_solver_factory,
            branching_rule,
            node_limit,
            gap_tol,
            int_tol
        )
    end
end

