% Copyright 2020 Max Planck Society. All rights reserved.
% 
% Author: Alonso Marco Valle (amarcovalle/alonrot) amarco(at)tuebingen.mpg.de
% Affiliation: Max Planck Institute for Intelligent Systems, Autonomous Motion
% Department / Intelligent Control Systems
% 
% This file is part of interactiveGP.
% 
% interactiveGP is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by the Free
% Software Foundation, either version 3 of the License, or (at your option) any
% later version.
% 
% interactiveGP is distributed in the hope that it will be useful, but
% WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
% FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
% details.
% 
% You should have received a copy of the GNU General Public License along with
% interactiveGP.  If not, see <http://www.gnu.org/licenses/>.
%
%
function [fig_hdl,axes_hdl] = initialize_plots(in)

    in = get_plotting_atributes(in);

    fig_hdl          = figure;
    fig_hdl.Position = in.fig_position;
    
    fig_hdl.MenuBar  = in.MenuBar;
    fig_hdl.Name     = in.Name;
    
    axes_hdl.gp   = subplot(in.subplot_struct(1),in.subplot_struct(2),in.subplot_num.gp);
    axes_hdl.gp.Units = 'pixels';
    axes_hdl.gp.Position = in.subplot_pos;
    title('GP posterior - Learning a parabola shape','interpreter','tex');
    xlabel('x_*','interpreter','tex');
    ylabel('f(x_*) | y','interpreter','tex');
    xlim([in.xmin in.xmax]);
    % ylim([-20 120]); % parabola
    ylim([-40 120]); % discontinuity
    

end

function in = get_plotting_atributes(in)

    in.uncertainty_color = [240,248,255]/255;
    in.simu_color        = [0.466 0.674 0.188];
    in.real_color        = [205,92,92]/255;
    in.minimum_color     = [106,90,205]/255;
    in.fontsize          = 12;
    in.subplot_struct    = [1,1];
    in.subplot_num.rect  = 1;   
    in.fig_position      = [192 229 1097 480]; % mac
%     in.fig_position      = [850 678 1097 480]; % wagner
    in.subplot_pos       = [75 75 750 300];
    in.MenuBar = 'none';
    in.Name = 'Control';

end
