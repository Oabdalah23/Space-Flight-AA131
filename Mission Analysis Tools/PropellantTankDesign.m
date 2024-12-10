
%% Propellant Tank Design
% Calculates tank thickness, mass, and pressurization requirements.

function results = propellant_tank_design(p_burst, r_tank, sigma_allow, V_propellant, rho_tank, eta, P_f, T_f, P_i, T_i, R)
    % Inputs:
    % p_burst      - Burst pressure (Pa)
    % r_tank       - Tank radius (m)
    % sigma_allow  - Allowable stress (Pa)
    % V_propellant - Propellant volume (m^3)
    % rho_tank     - Tank material density (kg/m^3)
    % eta          - Tank design factor
    % P_f          - Final pressure (Pa)
    % T_f          - Final temperature (K)
    % P_i          - Initial pressure (Pa)
    % T_i          - Initial temperature (K)
    % R            - Gas constant for nitrogen (J/kg·K)

    % Tank Thickness
    t = (p_burst * r_tank) / (2 * sigma_allow);

    % Tank Surface Area and Mass
    surface_area = 4 * pi * r_tank^2; % Assuming spherical tank
    m_tank = (1 + eta) * surface_area * t * rho_tank;

    % Nitrogen Volume for Pressurization
    V_N2 = (P_f * V_propellant) / (P_i * (T_f / T_i) - P_f);

    % Mass of Nitrogen
    m_N2 = (P_i * V_N2) / (R * T_i);

    % Results
    results = struct('tank_thickness', t, ...
                     'tank_mass', m_tank, ...
                     'nitrogen_volume', V_N2, ...
                     'nitrogen_mass', m_N2);
end
