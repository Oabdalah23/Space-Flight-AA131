%% Hohmann Transfer
% Calculates the delta-V and orbital parameters for a Hohmann transfer.

function results = hohmann_transfer(r_park, r_target, mu)
    % Inputs:
    % r_park   - Radius of parking orbit (km)
    % r_target - Radius of target orbit (km)
    % mu       - Gravitational parameter (km^3/s^2)

    % Semi-Major Axis of Transfer Orbit
    a_transfer = (r_park + r_target) / 2;

    % Velocity at Perigee of Transfer Orbit
    v_transfer_periapsis = sqrt(mu * (2/r_park - 1/a_transfer));
    v_park = sqrt(mu / r_park);

    % Delta-V for First Burn
    Delta_v1 = v_transfer_periapsis - v_park;

    % Velocity at Apogee of Transfer Orbit
    v_transfer_apogee = sqrt(mu * (2/r_target - 1/a_transfer));
    v_target = sqrt(mu / r_target);

    % Delta-V for Second Burn
    Delta_v2 = v_target - v_transfer_apogee;

    % Total Delta-V
    Delta_v_total = Delta_v1 + Delta_v2;

    % Results
    results = struct('a_transfer', a_transfer, ...
                     'Delta_v1', Delta_v1, ...
                     'Delta_v2', Delta_v2, ...
                     'Delta_v_total', Delta_v_total);
end
