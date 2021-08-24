# patentrace

Repository for data and code from Hunter et al, 2021 Nature Human Behavior.

Data analysis was in two stages. Initially, learning models were fit to choice data in Julia to produce per-subject parameter estimates. These were then regressed on psychiatric covariates (originally, in Matlab). We include Matlab code and data for the original final analysis stage (matching the results as reported), and also updated code and data for a reimplemented end-to-end version of both stages, comprising both the parameter estimation and the regression.

# Matlab code & data for regression analyses/results:
The directory "matlab" contains a matlab file with previously estiamted per-subject RL parameters and covariates and a file of commands sufficient to reproduce the statistical results in the paper (i.e. the regressions reported in the Supplementary Tables).

# Choice data and Julia code for fitting learning models to choice data:
The directory "julia" contains raw choice data and a Jupyter notebook containing code fitting of learning models to estimate per-subject parameters, then regress these parameters on the covariates to test their associations with the psychatricself report measures.

This uses an expectation maximization library available at https://www.github.com/ndawlab/em. This requires a recent (e.g. 1.5+) version of Julia and various additional packages to be manually installed, as detailed in the example file there. The results in the paper (the parameters in the matlab directory above) were generated using an earlier version of this library for an obsolete (0.6) verson of Julia. This, in turn called an older (Python-based) optimization library, which is less efficient than the current implementation (using Julia's native Optim package) because it is not multithreaded. (We also have updated the M step for a more efficient computation.) The Jupyter notebook here calls the older Python optimizer to produce results more similar to the original code (though they are not exactly the same numerically, due to all the other updates).

We will continue to update this repository going forward.
