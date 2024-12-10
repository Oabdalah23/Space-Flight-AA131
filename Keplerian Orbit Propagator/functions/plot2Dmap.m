function [] = plot2Dmap(imageName)
% plot2Dmap creates a 2D image of the Earth that can be easily plotted
% over.
% 
% Inputs: 
%   imageName - string name of the Earth 2D image

% Display 2D image of Earth
mapPlot = imshow(imageName);

% Scale image so that latitude and longitude can easily be superimposed
set(mapPlot,'XData',[-180 180],'YData',[90 -90])
set(gca, 'YDir', 'normal');

% Set axis limits
xlim([-180 180])
ylim([-90 90])

% Crate axis labels
xlabel('Longitude [deg]')
ylabel('Latitude [deg]')
axis on
end

