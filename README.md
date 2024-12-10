
# Keplerian Orbit Propagator

This MATLAB project simulates the propagation of a satellite in Earth orbit using Keplerian orbital elements. The simulation provides both 2D and 3D visualizations of the satellite's trajectory over a 24-hour period.

## Features

- Converts orbital elements to Earth-Centered Inertial (ECI) coordinates.
- Simulates orbital motion using a two-body model with MATLAB's `ode45` solver.
- Converts ECI coordinates to Earth-Centered Earth-Fixed (ECEF) coordinates and geocentric latitude, longitude, and altitude.
- Visualizes the satellite's ground track on a 2D map and 3D orbit in both ECI and ECEF frames.

## Directory Structure

```
Keplerian-Orbit-Propagator/
│
├── KeplerianOrbitPropagator.m    # Main script
│
├── functions/
│   ├── CAL2GMST.m                   # Converts date to GMST
│   ├── OE2ECI.m                     # Converts orbital elements to ECI
│   ├── ECI2ECEF.m                   # Converts ECI to ECEF
│   ├── ECEF2GEOC.m                  # Converts ECEF to geocentric lat/lon/alt
│   ├── plot2Dmap.m                  # Plots 2D Earth map for ground track
│   └── plot3Dbody.m                 # Plots 3D Earth body for visualization
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

1. Open `KeplerianOrbitPropagator.m` in MATLAB.
2. Modify the initial orbital elements and other parameters as needed.
3. Run the script to generate the following outputs:
   - 2D ground track of the satellite.
   - 3D orbit visualization in the ECI and ECEF frames.

## Orbital Elements

The script uses revised initial orbital elements for a satellite:
- Semi-major axis (`a_initial`): 7743.907 km
- Eccentricity (`e_initial`): 0.085279
- Inclination (`i_initial`): 151.386209° (in radians)
- Right Ascension of Ascending Node (`RAAN_initial`): 183.48° (in radians)
- Argument of Perigee (`omega_initial`): 96.682175° (in radians)
- True Anomaly (`theta_initial`): 346.297048° (in radians)

## Visualization

- **Ground Track (2D Map):** Plots the satellite's path on a 2D Earth map.
- **3D ECI Orbit:** Shows the satellite's trajectory in the Earth-Centered Inertial frame.
- **3D ECEF Orbit:** Visualizes the orbit relative to the rotating Earth.

## Dependencies

This project depends on several MATLAB functions and data files:
- Custom Functions: `CAL2GMST.m`, `OE2ECI.m`, `ECI2ECEF.m`, `ECEF2GEOC.m`, `plot2Dmap.m`, `plot3Dbody.m`
- Data Files: `earth2Dmap.png`, `earthImage.jpg`

Ensure all required files are present in the respective directories.

## License

This project is licensed under the [MIT License](LICENSE).

## Contributing

Contributions are welcome! If you'd like to improve this project, feel free to fork the repository and submit a pull request.

## Acknowledgments

- Developed by Brad Yac-Diaz & Omar Abdallah.
- Special thanks to the MATLAB community for supporting tools and resources.

## Contact

For any questions or suggestions, please reach out via GitHub issues or contact [your email address].
