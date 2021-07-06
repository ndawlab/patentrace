# the model code

# construct the game payoff matrix

function gamematrix()
	M = zeros(5,6)

	for i = 1:5
		for j = 1:6
			if i <= j
				M[i,j] = 5 - i
			else
				M[i,j] = 5 - i + 10
			end
		end
	end

	return M
end

# likelihood function for the full (valenced EWA) model

function ewalik_valenced(params,data)
    # free parameters
	beta = params[1]
	phi = 0.5 + 0.5 * erf(params[2] / sqrt(2)) # phi 1-alpha; squashed to 0-1 
	rho = phi
	wplus = 0.5 + 0.5 * erf(params[3] / sqrt(2))
	wminus = 0.5 + 0.5 * erf(params[4] / sqrt(2))
    startq = 14 ./ (1 .+ exp.(.-params[5:9])) # squashed to 0-14

    N = 0
    lik = 0
    Q = zeros(typeof(beta),5) + startq

	s1::Array{Int64,1} = data[:,:s1] # player moves
	s2::Array{Int64,1} = data[:,:s2] # opponent moves
    
    M::Matrix{Float64} = gamematrix()

    for i = 1:length(s1)
        lik += (beta*Q[s1[i]] - logsumexp(beta*Q)) # choice likelihood: log of softmax
        Nnew = rho * N + 1
        for j = 1:5
            # learning step for each move j
            if (j==s1[i])
                Q[j] = ((phi) * N * Q[j] + M[j,s2[i]]) / Nnew
            elseif (M[j,s2[i]] > M[s1[i],s2[i]])
                Q[j] = ((phi) * N * Q[j] + wplus * M[j,s2[i]]) / Nnew
            else
                Q[j] = ((phi) * N * Q[j] + wminus * M[j,s2[i]]) / Nnew
            end
        end
		N = Nnew
	end
	return -lik
end

# baseline model is same as above, but with w+ = w-

ewalik = (x,data) -> ewalik_valenced([x[1:2];x[3];x[3];x[4:8]],data)
