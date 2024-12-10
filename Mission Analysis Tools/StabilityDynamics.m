
%% Stability Dynamics
% Calculates gravitational, aerodynamic, and solar radiation pressure torques.

function results = stability_dynamics(I_x, I_y, theta, R, rho, C_d, A, v, c_pa, c_g, F_s, q, i, L)
    % Inputs:
    % I_x, I_y - Moments of inertia (kg·m^2)
    % theta    - Angle (rad)
    % R        - Orbital radius (m)
    % rho      - Atmospheric density (kg/m^3)
    % C_d      - Drag coefficient
    % A        - Cross-sectional area (m^2)
    % v        - Velocity (m/s)
    % c_pa, c_g - Center of pressure and center of gravity offsets (m)
    % F_s      - Solar flux (N/m^2)
    % q        - Reflectivity coefficient
    % i        - Angle of incidence (rad)
    % L        - Distance (m)

    % Gravitational Torque
    T_g = (3/2) * (I_y - I_x) * (theta) * (1/R^3);

    % Aerodynamic Torque
    T_a = (1/2) * rho * C_d * A * v^2 * (c_pa - c_g);

    % Solar Radiation Pressure Torque
    T_sp = (F_s / c) * A * (1 + q) * cos(i) * L;

    % Total Torque
    T_total = T_g + T_a + T_sp;

    % Results
    results = struct('gravitational_torque', T_g, ...
                     'aerodynamic_torque', T_a, ...
                     'solar_pressure_torque', T_sp, ...
                     'total_torque', T_total);
end
