%% Eclipse Duration and Frequency Analysis
% Calculates the duration and frequency of satellite eclipses during its orbit.

%% Constants
mu = 3.986e5; % km^3/s^2, Gravitational Parameter of Earth
radiusEarth = 6378; % km

%% Initial Setup
% Launch Date/Time: June 25, 2019, 6:30 UTC
GMST = CAL2GMST(2019, 6, 25, (6.5 / 24)); % Convert to GMST (radians)

% Initial Position and Velocity
GEOC_Initial = [28.608333; 80.604444; 720]; % Geocentric (Lat, Long, Height [km])
ECEF_Pos_Initial = GEOC2ECEF(GEOC_Initial, radiusEarth); % Convert to ECEF
ECI_Pos_Initial = ECEF2ECI(ECEF_Pos_Initial, GMST); % Convert to ECI
ECI_Vel_Initial = [7.8; 0; 0]; % Assumed velocity for LEO (km/s)

% Combine Initial Position and Velocity
ECI_posVel_Initial = [ECI_Pos_Initial; ECI_Vel_Initial];
OE_Initial = ECI2OE(ECI_posVel_Initial, mu); % Orbital Elements

% Extract Orbital Elements
a_initial = OE_Initial(1); % Semi-major axis
e_initial = OE_Initial(2); % Eccentricity
i_initial = OE_Initial(3); % Inclination
RAAN_initial = OE_Initial(4); % RAAN
omega_initial = OE_Initial(5); % Argument of Periapsis
theta_initial = OE_Initial(6); % True Anomaly

% Calculate Orbital Period
T_period = 2 * pi * sqrt((a_initial^3) / mu); % seconds

%% Propagation
% Propagate for 30 orbital periods from June 25, 2019, 6:30:00 UTC
t1 = datetime(2019, 6, 25, 6, 30, 0);
orbitTime = 30 * T_period;
t2 = t1 + seconds(orbitTime);
durationSeconds = seconds(t2 - t1); % Total duration (seconds)
num_steps = durationSeconds; % Position and velocity checked every second
tspan = linspace(0, durationSeconds, num_steps);

% Initial Conditions for ODE Solver
y0 = [ECI_Pos_Initial; ECI_Vel_Initial];

% Solve Orbital Dynamics
[t, y] = ode45(@(t, y) orbitODE(t, y, mu), tspan, y0);

% Extract Satellite Positions
satECI_positions = y(:, 1:3)'; % km

% Time Vector and Sun Positions
t = t1:seconds(1):t2; % Time in 1-second intervals
sunECI_positions = sunECI_atTime(t); % Sun position in ECI (km)

% Calculate Parallel and Perpendicular Components
[rSat_parallel, rSat_perp] = ECI_sat_sun2parallelPerp(satECI_positions, sunECI_positions);

% Check for Eclipse
[eclipse, ~, ~, ~] = checkEclipse(rSat_parallel, rSat_perp, sunECI_positions);

% Total Time in Eclipse
eclipseDuration = sum(eclipse(1, :) == 1); % Seconds in eclipse

% Display Results
fprintf("Total Orbit Time: %.2f seconds\n", orbitTime);
fprintf("Total Eclipse Time: %.2f seconds\n", eclipseDuration);

%% Function Definitions

% Sun Position in ECI
function r_v_ECI_sun = sunECI_atTime(t)
    a = 149597870.691; % Semi-major axis (km)
    e = 0.01; % Eccentricity
    i = 0.4101524; % Inclination (radians)
    RAAN = 0; % Right Ascension of Ascending Node (radians)
    argPeri = 1.74533; % Argument of Periapsis (radians)

    [K, M, I] = ymd(t); % Year, Month, Day
    [hr, min, sec] = hms(t); % Hour, Minute, Second
    fractionalDay = (hr + (min + sec ./ 60) ./ 60) ./ 24;

    JD = 367 * K - (7 * (K + (M + 9) / 12)) / 4 + (275 * M) / 9 + I + 1721013.5 + fractionalDay; % Julian Date
    mean_anomaly_total = 357.529 + 0.98560028 * (JD - 2451545.0); % Degrees
    mean_anomaly = deg2rad(wrapTo360(mean_anomaly_total)); % Radians

    eccentricAnomaly = arrayfun(@(M) M2E(M, e, 0.001), mean_anomaly);
    true_anomaly = arrayfun(@(E) E2T(E, e), eccentricAnomaly);

    r_v_ECI_sun = arrayfun(@(TA) OE2ECI([a; e; i; RAAN; argPeri; TA], mu), true_anomaly, 'UniformOutput', false);
    r_v_ECI_sun = cell2mat(r_v_ECI_sun); % Combine results
end

% Satellite to Sun Parallel and Perpendicular Components
function [r_parallel, r_perp] = ECI_sat_sun2parallelPerp(r_v_ECI_sat, r_v_ECI_sun)
    r_parallel = zeros(size(r_v_ECI_sat));
    r_perp = zeros(size(r_v_ECI_sat));

    for i = 1:size(r_v_ECI_sat, 2)
        r_sat = r_v_ECI_sat(:, i);
        r_sun = r_v_ECI_sun(:, i);
        r_parallel(:, i) = dot(r_sat, r_sun) * (-r_sun / norm(r_sun));
        r_perp(:, i) = r_sat - r_parallel(:, i);
    end
end

% Check Eclipse Status
function [eclipse, radiustally, behindTally, magPerp] = checkEclipse(r_parallel, r_perp, r_v_ECI_sun)
    R_earth = 6378.1370; % Earth's equatorial radius (km)
    eclipse = zeros(1, size(r_parallel, 2));
    radiustally = 0; behindTally = 0;

    for i = 1:size(r_parallel, 2)
        mag_r_perp = norm(r_perp(:, i));
        magPerp(i) = mag_r_perp;
        if mag_r_perp <= R_earth && dot(r_parallel(:, i), r_v_ECI_sun(:, i)) <= 0
            eclipse(i) = 1;
        end
    end
end

% Orbital Dynamics ODE
function dydt = orbitODE(t, y, mu)
    r = y(1:3);
    v = y(4:6);
    a = -mu * r / norm(r)^3;
    dydt = [v; a];
end
