# Data and code for Okazawa et al. (2021)

This repository contains data and test code for the following paper:

Okazawa G, Hatch CE, Mancoo A, Machens CK, Kiani R (2021). Representational geometry of perceptual decisions in the monkey parietal cortex. *Cell* (in press)

## Requirement

The data are saved as MATLAB v7 mat file format.

The code is tested under MATLAB R2019b. Requires statistics toolbox and curve fitting toolbox.


## Main dataset

[Face_cor.mat](./Face_cor.mat): PSTH data collected from two monkeys in face categorization task.

[Motion_cor.mat](./Motion_cor.mat): PSTH data collected from three monkeys in motion direction discrimination task.

Both dataset contains followings:

* PSTH (unit x time x stimulus condition): trial-averaged PSTHs for correct trials. Aligned to stimulus onset and smoothed with 100 ms boxcar function.
* Tstamp (1 x time): time stamp of PSTHs (ms)
* coherence (unit x stimulus condition): average stimulus strength (%) in each stimulus condition for each unit


## Test code

[Okazawa2021.m](./Okazawa2021.m): Generate population average PSTHs (Fig. 2A-B) and PCA plot (Fig. 2E-F; without bootstrap procedure for estimation of SE).

## Contact

For questions or further inquiry about the dataset and code, please contact the first or lead author (okazawa@nyu.edu, roozbeh@nyu.edu).

## License

These files are being released openly in the hope that they might be useful but with no promise of support. If using them leads to a publication, please cite the paper.

The dataset is released under a CC-BY 4.0 license.

The code is released under a [BSD license](./LICENSE.md).
