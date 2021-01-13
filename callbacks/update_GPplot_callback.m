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
function update_GPplot_callback(hObj,evnt,axes_hdl,pars)

global ls std X Y;

if isempty(ls)
    ls = pars.ls_init;
end

if isempty(std)
    std = pars.std_init;
end

switch pars.what2mod
    case 'ls'
        ls = get(hObj,'Value');
    case 'std'
        std = get(hObj,'Value');
    case 'new_evaluation'
        Xnew = pars.specs.xmin + (pars.specs.xmax - pars.specs.xmin) * rand();
        % get_parabola_value = construct_parabola_saturated(pars.GP.hyp);
        % Ynew = get_parabola_value(Xnew);
        get_function_value = construct_discontinuity(pars.GP.hyp);
        Ynew = get_function_value(Xnew);
        
        % Update global variable:
        X = [X;Xnew];
        Y = [Y;Ynew];
end

pars.GP.x = X;
pars.GP.y = Y;
pars.GP.hyp.cov(1) = log(ls);
pars.GP.hyp.cov(2) = log(std);

% Update plot:
fig_hdl = axes_hdl.Parent;
update_GPplot(fig_hdl,axes_hdl,pars.GP)
end