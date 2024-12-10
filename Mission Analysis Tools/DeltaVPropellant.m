%% Delta-V and Propellant Requirements
% Calculates delta-V for maneuvers and the required propellant mass.

function results = delta_v_propellant(I_sp, g_0, M_wet, M_dry, Delta_v)
    % Inputs:
    % I_sp   - Specific impulse (s)
    % g_0    - Gravitational acceleration (m/s^2)
    % M_wet  - Wet mass (kg)
    % M_dry  - Dry mass (kg)
    % Delta_v - Delta-V required (m/s)

    % Delta-V Calculation
    calculated_Delta_v = I_sp * g_0 * log(M_wet / M_dry);

    % Propellant Mass Requirement
    m_p = M_wet * (1 - exp(-Delta_v / (I_sp * g_0)));

    % Results
    results = struct('calculated_Delta_v', calculated_Delta_v, ...
                     'propellant_mass', m_p);
end
