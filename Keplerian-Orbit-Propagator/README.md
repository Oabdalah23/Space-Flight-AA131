# Keplerian Orbit Propagator

This MATLAB project simulates the propagation of a satellite in Earth orbit using Keplerian orbital elements. It includes additional analyses for satellite eclipse durations and ground station contact times. These tools provide insights into key mission parameters and performance metrics.

## Features

- Converts orbital elements to Earth-Centered Inertial (ECI) coordinates.
- Simulates orbital motion using a two-body model with MATLAB's `ode45` solver.
- Converts ECI coordinates to Earth-Centered Earth-Fixed (ECEF) coordinates and geocentric latitude, longitude, and altitude.
- Visualizes the satellite's ground track on a 2D map and 3D orbit in both ECI and ECEF frames.
- **Showcases Eclipse Duration Analysis**: This analysis includes errors due to simplifications. The correct eclipse duration was verified using Ansys STK.
- **Showcases Ground Contact Analysis**: Calculates satellite line-of-sight (LOS) contact times with a ground station. Simplifications may affect the accuracy of results.

## Directory Structure

```
Keplerian-Orbit-Propagator/
│
├── KeplerianOrbitPropagator.m        # Main script for orbit propagation
├── EclipseDuration.m                 # Script for eclipse duration and frequency analysis
├── GroundContact.m                   # Script for ground station contact analysis
│
├── functions/
│   ├── CAL2GMST.m                   # Converts date to GMST
│   ├── OE2ECI.m                     # Converts orbital elements to ECI
│   ├── ECI2ECEF.m                   # Converts ECI to ECEF
│   ├── ECEF2GEOC.m                  # Converts ECEF to geocentric lat/lon/alt
│   ├── plot2Dmap.m                  # Plots 2D Earth map for ground track
│   ├── plot3Dbody.m                 # Plots 3D Earth body for visualization
│   └── Additional functions for Eclipse and Ground Contact calculations
│
├── data/
│   ├── earth2Dmap.png               # Image of 2D Earth map
│   └── earthImage.jpg               # Image of Earth for 3D plotting
│
├── README.md                         # Project documentation
├── LICENSE                           # License file (e.g., MIT License)
└── .gitignore                        # Git ignore file
```

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/Keplerian-Orbit-Propagator.git
   cd Keplerian-Orbit-Propagator
   ```

2. Ensure you have MATLAB installed with access to the following toolboxes:
   - Optimization Toolbox
   - Mapping Toolbox (optional, for map visualization)

3. Add the repository to your MATLAB path:
   ```matlab
   addpath(genpath('path_to_repository'))
   ```

## Usage

### Keplerian Orbit Propagation
1. Open `KeplerianOrbitPropagator.m` in MATLAB.
2. Modify the initial orbital elements and other parameters as needed.
3. Run the script to generate the following outputs:
   - 2D ground track of the satellite.
   - 3D orbit visualization in the ECI and ECEF frames.

### Eclipse Duration Analysis
1. Open `EclipseDuration.m` in MATLAB.
2. Modify the initial conditions and propagation duration as needed.
3. Run the script to calculate:
   - Total duration of satellite eclipses during the mission.
   - Frequency of eclipses (time intervals when the satellite enters Earth's shadow).

#### Note on Eclipse Duration
This analysis includes errors due to simplifications in the calculations. The correct eclipse duration was verified using Ansys STK software. This implementation is included to demonstrate the approach and methodology.

### Ground Contact Analysis
1. Open `GroundContact.m` in MATLAB.
2. Modify the initial satellite and ground station parameters as needed (default uses Kennedy Space Center).
3. Run the script to calculate:
   - Total time the satellite has line-of-sight (LOS) contact with the ground station.
   - Average contact time per orbit period.
   - Average frequency of contacts.

#### Note on Ground Contact
This analysis uses simplified geometric models and may contain errors. It is included to showcase the methodology, while refined tools like Ansys STK are recommended for precise calculations.

## Dependencies

This project depends on several MATLAB functions and data files:
- Custom Functions: `CAL2GMST.m`, `OE2ECI.m`, `ECI2ECEF.m`, `ECEF2GEOC.m`, `plot2Dmap.m`, `plot3Dbody.m`, and additional functions for eclipse and ground contact calculations.
- Data Files: `earth2Dmap.png`, `earthImage.jpg`.

Ensure all required files are present in the respective directories.

## Acknowledgments

- Developed by Brad Yac-Diaz & Omar Abdallah.
- Utilized functions provided by AA 131 Instructor, Simone D'Amico (Associate Professor of Aeronautics and Astronautics and, by courtesy, of Geophysics).
