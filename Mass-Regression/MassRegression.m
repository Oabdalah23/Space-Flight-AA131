%% Mass Regression Analysis
% This script performs mass regression analysis for various spacecraft subsystems.

%% Add Paths for Data & Functions
addpath(genpath('data'));

%% Load Data from Excel File
filename = 'data/data.xlsx'; % Adjusted path to match directory structure
data = readtable(filename);

% Extract Relevant Columns
totalDryMass = data.DryMass; % Ensure 'DryMass' is available in your data
totalWetMass = data.WetMass;
payloadMass = data.Payload;
structMass = data.Struct__Mech;
thermalMass = data.ThermalControl;
powerMass = data.Power;
TTCMass = data.TT_C;
processingMass = data.On_BoardProc_;
ADCSMass = data.ADCS;
propMass = data.Prop_;
propellantMass = data.Propellant;
otherMass = data.Other;

% Define Subsystem Names & Corresponding Data
subsystemNames = {'Payload', 'Structure & Mechanical', 'Thermal Control', 'Power', 'TT&C', ...
                  'On-Board Processing', 'ADCS', 'Propulsion', 'Propellant', 'Other'};
subsystemData = {payloadMass, structMass, thermalMass, powerMass, TTCMass, ...
                 processingMass, ADCSMass, propMass, propellantMass, otherMass};

% Initialize Arrays to Store Results
numSubsystems = length(subsystemNames);
slopes = zeros(numSubsystems, 1);
intercepts = zeros(numSubsystems, 1);
rSquared = zeros(numSubsystems, 1);

% Perform Regression for Each Subsystem
for i = 1:numSubsystems
    [slopes(i), intercepts(i), rSquared(i)] = performRegression(totalDryMass, subsystemData{i});
end

% Display Results
fprintf('Regression Results:\n\n');
for i = 1:numSubsystems
    fprintf('%s Mass Model:\n', subsystemNames{i});
    fprintf('Y = %.2f + %.4fX\n', intercepts(i), slopes(i));
    fprintf('R² = %.4f\n\n', rSquared(i));
end

% Plot Results for All Subsystems
figure;
hold on;
colors = lines(numSubsystems);
markerShapes = {'o', 's', '^', 'd', 'v', '>', '<', 'p', 'h', '+'};

for i = 1:numSubsystems
    scatter(totalDryMass, subsystemData{i}, 70, colors(i,:), 'filled', markerShapes{i});
    plot(totalDryMass, slopes(i)*totalDryMass + intercepts(i), 'Color', colors(i,:), 'LineWidth', 2.5);
end

legend(subsystemNames, 'Location', 'northwest');
grid on;
set(gca, 'GridAlpha', 0.3);
hold off;

% Save the Figure Without Title & Labels
saveas(gcf, 'data/cleaned_mass_models_no_labels.png');

% Linear Regression Function
function [slope, intercept, rSquared] = performRegression(x, y)
    X = [ones(length(x), 1) x];
    b = X \ y;
    intercept = b(1);
    slope = b(2);
    
    yFit = X * b;
    rSquared = 1 - sum((y - yFit).^2) / sum((y - mean(y)).^2);
end
