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
function update_GPplot(fig_hdl,axes_hdl,GP)

    if isempty(fig_hdl) && isempty(axes_hdl)
        return;
    end

% 	display('*** Update plots!');

    % Update GP:
    plot_GP(fig_hdl,axes_hdl,GP);
    
    drawnow;

end

function plot_GP(fig_hdl,axes_hdl,GP)

    [GP.mpost,GP.vpost,GP.stdpost,GP.samples] = get_posterior(GP,GP.z,GP.x,GP.y);
    
    GP = get_plotting_atributes(GP);
    
    figure(fig_hdl); 
    subplot(axes_hdl);
    cla(axes_hdl);
    hold on; grid on; box on;
    % Special case for no data:
    if isempty(GP.x)
        
        f_ = [GP.mpost + 2*GP.stdpost; flip(GP.mpost - 2*GP.stdpost,1)];
        fill([GP.z; flip(GP.z,1)], f_, GP.uncertainty_color)
        plot(GP.z,GP.mpost,'LineStyle','-','Color',[65,105,225]/255,'LineWidth',1.5)
        plot(GP.z,GP.samples,'LineStyle','--','Color',[65,105,225]/255,'LineWidth',0.5)
        plot(GP.z,GP.f_true,'LineStyle','-','Color',0.7 * [1 1 1],'LineWidth',1.5)
        
    else

        f_ = [GP.mpost + 2*GP.stdpost; flip(GP.mpost - 2*GP.stdpost,1)];
        fill([GP.z; flip(GP.z,1)], f_, GP.uncertainty_color)
        plot(GP.z,GP.mpost,'LineStyle','-','Color',[65,105,225]/255,'LineWidth',1.5)
        plot(GP.x,GP.y,'o','color',GP.real_color,'MarkerFaceColor',GP.real_color);
        plot(GP.z,GP.samples,'LineStyle','--','Color',[65,105,225]/255,'LineWidth',0.5)
        plot(GP.z,GP.f_true,'LineStyle','-','Color',0.7 * [1 1 1],'LineWidth',1.5)
        
    end

end

function GP = get_plotting_atributes(GP)

    GP.uncertainty_color = [240,248,255]/255;
    GP.real_color        = [205,92,92]/255;
%     GP.minimum_color     = [106,90,205]/255;
    GP.fontsize          = 12;

end