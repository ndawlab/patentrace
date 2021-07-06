# patentrace

Repository for data and code from Hunter et al, in press at Nature Human Behavior.

Data analysis was in two stages. Initially, learning models were fit to choice data in Julia to produce per-subject parameter estimates. These were then regressed on psychiatric covariates in Matlab. We include code and data for the final analysis stage, and code and data for an updated version of the first stage.

# Matlab code & data for core regression analyses/results:
The directory "matlab" contains a matlab file with per-subject RL parameters and covaraites and a file of commands sufficient to reproduce the statistical results in the paper (i.e. the regressions reported in the Supplementary Tables).

# Choice data and Julia code for fitting learning models to choice data:
The directory "julia" contains raw choice data and a Jupyter notebook containing code fitting of learning models to estimate per-subject parameters.
This uses an expectation maximization library available at https://www.github.com/ndawlab/em. This requires a recent (e.g. 1.5+) version of Julia and various additional packages to be manually installed, as detailed in the example file there. 
The results in the paper (the parameters in the matlab directory above) were generated using an earlier version of this library for an older (0.6) verson of Julia. This, in turn called a different (Python-based) optimization library, which is less efficient than the current implementation (using Julia's native Optim package) because it is not multithreaded. However, this means the parameter estimates and results produced with the newer code do not correspond numerically (in terms of numeric estimates and p values) with those from the Matlab code above.

We will continue to update this repository going forward.
