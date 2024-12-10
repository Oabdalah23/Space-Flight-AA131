%% Keplerian Orbit Propagator
% Brad Yac-Diaz & Omar Abdallah

%% Constants
mu = 3.986e5; % km^3/s^2, Gravitational Parameter of Earth
radiusEarth = 6378; % km

% Launch Date / Time (June 25, 2019, 6:30 UTC)
GMST = CAL2GMST(2019, 6, 25, (6.5/24)); % Convert to GMST (in Radians)

% Revised Initial Orbital Elements (adjusted for perturbations)
a_initial = 7743.907; % km (adjusted +91 m for semi-major axis decay)
e_initial = 0.085279; % (adjusted to offset eccentricity growth)
i_initial = deg2rad(151.386209); % inclination remains unchanged
RAAN_initial = deg2rad(183.48); % adjusted for -3.48 degrees precession over mission
omega_initial = deg2rad(96.682175); % adjusted for +5.95 degrees precession
theta_initial = deg2rad(346.297048); % Similar to original orbit

%% Convert Orbital Elements to ECI Position and Velocity
OE_Initial2 = [a_initial; e_initial; i_initial; RAAN_initial; omega_initial; theta_initial];
ECI_posVel_Initial = OE2ECI(OE_Initial, mu);

%% Extract Initial Position and Velocity
ECI_Pos_Initial = ECI_posVel_Initial(1:3);
ECI_Vel_Initial = ECI_posVel_Initial(4:6);

%% Calculate Orbital Period
T_period = 2*pi*sqrt((a_initial^3)/mu); % seconds

%% Propagate Orbit for 24 hours (86400 seconds)
num_steps = 8640; % 10-second intervals for increased resolution
tspan = linspace(0, 86400, num_steps);

% Initial Conditions for ODE Solver
y0 = [ECI_Pos_Initial; ECI_Vel_Initial];

% ODE Solver (ODE45)
[t, y] = ode45(@(t,y) orbitODE(t, y, mu), tspan, y0);

% Extract Positions & Velocities
ECI_positions = y(:, 1:3)';
ECI_velocities = y(:, 4:6)';

% Initialize Arrays for ECEF & GEOCentric Positions
ECEF_positions = zeros(size(ECI_positions));
GEOC_positions = zeros(size(ECI_positions));

%% Convert ECI to ECEF and GEOCentric Coordinates
for i = 1:num_steps
    current_GMST = GMST + 2*pi*(t(i)/86400); % Update GMST for each time step
    ECEF_positions(:,i) = ECI2ECEF(ECI_positions(:,i), current_GMST);
    GEOC_positions(:,i) = ECEF2GEOC(ECEF_positions(:,i), radiusEarth);
end

%% Plot

% 2D Ground Track Map
figure;
plot2Dmap('Data/earth2Dmap.png');
hold on;
xlim([-180 180]);
ylim([-90 90]);
plot(-GEOC_positions(2,:), GEOC_positions(1, :),'.k')
title('Satellite Ground Track (24 Hours)');
xlabel('Longitude (deg)');
ylabel('Latitude (deg)');

% 3D Satellite Orbit in ECI Frame
figure;
plot3Dbody('Data/earthImage.jpg', radiusEarth);
hold on;
plot3(ECI_positions(1,:), -ECI_positions(2,:), ECI_positions(3,:), 'r-', 'LineWidth', 2);
xlabel('X (km)');
ylabel('Y (km)');
zlabel('Z (km)');
axis equal;
grid on;

% 3D Satellite Orbit in ECEF Frame
figure;
plot3(ECEF_positions(1,:), ECEF_positions(2,:), ECEF_positions(3,:), 'b-', 'LineWidth', 2);
hold on;
[X,Y,Z] = sphere(50);
surf(radiusEarth*X, radiusEarth*Y, radiusEarth*Z, 'FaceColor', 'g', 'FaceAlpha', 0.2, 'EdgeColor', 'none');
xlabel('X (km)');
ylabel('Y (km)');
zlabel('Z (km)');
axis equal;
grid on;

%% Function for Orbital Dynamics ODE Solver
function dydt = orbitODE(t, y, mu)
    r = y(1:3);
    v = y(4:6);
    a = -mu * r / norm(r)^3;  % Two-body Acceleration due to Earth's Gravity
    dydt = [v; a];
end
