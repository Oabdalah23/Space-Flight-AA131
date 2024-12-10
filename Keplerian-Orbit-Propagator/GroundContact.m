%% Ground Contact Analysis
% This script calculates the satellite's line-of-sight (LOS) contact time with a ground station.

% Add functions directory to MATLAB path
addpath(genpath('functions'));

%% Constants and Initial Setup
mu = 3.986e5; % km^3/s^2, Gravitational Parameter of Earth
radiusEarth = 6378; % km

% Ground station (Kennedy Space Center) geocentric coordinates
GEOC_kennedy = [28.5241667, -80.6508333, 0.003]'; % Latitude, Longitude, Elevation (km)
ECEF_kennedy = GEOC2ECEF(GEOC_kennedy, radiusEarth); % Convert to ECEF coordinates

% Launch Date/Time: June 25, 2019, 6:30 UTC
GMST = CAL2GMST(2019, 6, 25, (6.5 / 24)); % Convert to GMST (radians)

% Initial satellite position and velocity
GEOC_Initial = [28.608333; -80.604444; 720]; % Latitude, Longitude, Altitude (km)
ECEF_Pos_Initial = GEOC2ECEF(GEOC_Initial, radiusEarth); % Convert to ECEF
ECI_Pos_Initial = ECEF2ECI(ECEF_Pos_Initial, GMST); % Convert to ECI
ECI_Vel_Initial = [7.8; 0; 0]; % Assumed velocity for LEO (km/s)
y0 = [ECI_Pos_Initial; ECI_Vel_Initial];

% Orbital elements
OE_Initial = ECI2OE(y0, mu);
T_period = 2 * pi * sqrt((OE_Initial(1)^3) / mu); % Orbital period (seconds)

%% Propagation
numPeriods = 30; % Number of orbital periods
orbitTime = numPeriods * T_period; % Total propagation time (seconds)
tspan = linspace(0, orbitTime, orbitTime); % Time vector for propagation

% ODE Solver
[t, y] = ode45(@(t, y) orbitODE(t, y, mu), tspan, y0);
satECI_positions = y(:, 1:3)'; % Extract satellite positions in ECI

% Convert ECI positions to ECEF
GMSTs = arrayfun(@(i) CAL2GMST(2019, 6, 25, (6.5 + i / 86400)), t, 'UniformOutput', false);
satECEF_positions = ECI2ECEF(satECI_positions, cell2mat(GMSTs));

%% Ground Station Contact Analysis
lat = GEOC_kennedy(1); % Latitude of ground station
long = GEOC_kennedy(2); % Longitude of ground station
rotation_ECEF2ENU = [-sind(long), -cosd(long) * sind(lat), cosd(long) * sind(lat);
                      cosd(long), -sind(long) * sind(lat), sind(long) * cosd(lat);
                      0, cosd(lat), sind(lat)];

satENU_positions = zeros(size(satECEF_positions));
for i = 1:length(satENU_positions)
    satENU_positions(:, i) = rotation_ECEF2ENU * (satECEF_positions(:, i) - ECEF_kennedy);
end

% Calculate azimuth and elevation angles
az = atan2d(satENU_positions(1, :), satENU_positions(2, :));
el = atan2d(satENU_positions(3, :), sqrt(satENU_positions(1, :).^2 + satENU_positions(2, :).^2));

% Line-of-sight contact time
contactTime = sum(el > 0); % Total time with LOS in seconds

%% Display Results
fprintf("Total Orbit Time: %.2f seconds\n", orbitTime);
fprintf("Total Ground Contact Time: %.2f seconds\n", contactTime);
fprintf("Average Contact Time per Period: %.2f seconds\n", contactTime / numPeriods);
fprintf("Average Contact Frequency: %.4f contacts per second\n", numPeriods / contactTime);

%% Orbital Dynamics Function
function dydt = orbitODE(~, y, mu)
    r = y(1:3);
    v = y(4:6);
    a = -mu * r / norm(r)^3; % Two-body acceleration
    dydt = [v; a];
end
