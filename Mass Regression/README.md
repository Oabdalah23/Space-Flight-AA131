
# Mass Regression Analysis

This module performs regression analysis on spacecraft subsystems' mass data to establish relationships between the total dry mass and subsystem masses. 

## Features

- Linear regression for each subsystem.
- Visualizes scatter plots and regression lines.
- Outputs regression equations and R² values for each subsystem.

## Data

The script uses an Excel file, `data.xlsx`, which contains the following columns:
- `DryMass`: Total dry mass of the spacecraft.
- `WetMass`: Total wet mass of the spacecraft.
- Subsystem masses: `Payload`, `Structure & Mechanical`, `Thermal Control`, `Power`, `TT&C`, `On-Board Processing`, `ADCS`, `Propulsion`, `Propellant`, and `Other`.

## Usage

1. Place the input file `data.xlsx` in the `data/` directory.
2. Run the script:
   ```matlab
   MassRegression.m
   ```
3. The script will:
   - Output regression results for each subsystem.
   - Save a plot (`cleaned_mass_models_no_labels.png`) in the `data/` directory.

## Results

Regression models are generated for each subsystem in the form:
```
Y = Intercept + Slope * X
```
Where:
- `Y` is the subsystem mass.
- `X` is the total dry mass.

R² values indicate the goodness of fit.

## Dependencies

- MATLAB with basic functionality.
- Excel file reader capabilities.

## Acknowledgments

Developed as part of the **Space-Flight-AA131** project.
