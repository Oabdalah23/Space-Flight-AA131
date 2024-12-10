
%% Orbital Mechanics and Perturbations
% Calculates orbital period, RAAN precession, argument of perigee precession,
% semi-major axis decay, and eccentricity change.

function results = orbital_mechanics(a, e, i, mu, J2, R_E, rho, B, P_SR, CR, c)
    % Inputs:
    % a   - Semi-major axis (km)
    % e   - Eccentricity
    % i   - Inclination (rad)
    % mu  - Gravitational parameter (km^3/s^2)
    % J2  - Earth's oblateness factor
    % R_E - Earth's radius (km)
    % rho - Atmospheric density (kg/m^3)
    % B   - Ballistic coefficient (kg/m^2)
    % P_SR - Solar radiation pressure (N/m^2)
    % CR  - Coefficient of reflectivity
    % c   - Speed of light (m/s)

    % Orbital Period
    T_period = 2 * pi * sqrt(a^3 / mu);

    % RAAN Precession Rate
    dOmega_dt = -3/2 * J2 * sqrt(mu/a^7) * R_E^2 * cos(i);
    dOmega_dt_deg_year = dOmega_dt * (180/pi) * 365.25 * 86400;

    % Argument of Perigee Precession Rate
    domega_dt = 3/4 * J2 * sqrt(mu/a^7) * R_E^2 * (5 * cos(i)^2 - 1);
    domega_dt_deg_year = domega_dt * (180/pi) * 365.25 * 86400;

    % Semi-Major Axis Decay Rate
    da_dt = -2 * rho * (a^2/B) * sqrt(mu/a);
    da_dt_m_year = da_dt * 1000 * 365.25 * 86400;

    % Eccentricity Change Rate
    n = sqrt(mu/a^3);
    de_dt = (3 * P_SR * CR) / (4 * B * n * c);
    de_dt_year = de_dt * 365.25 * 86400;

    % Results
    results = struct('T_period', T_period, ...
                     'dOmega_dt_deg_year', dOmega_dt_deg_year, ...
                     'domega_dt_deg_year', domega_dt_deg_year, ...
                     'da_dt_m_year', da_dt_m_year, ...
                     'de_dt_year', de_dt_year);
end
