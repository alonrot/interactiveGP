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
function specs = initialize_ES()
    
    % Constraints defining search space (DIM):
        specs.xmin          = -10;
        specs.xmax          = 10;

    % Number of dimensions:
        specs.D             = size(specs.xmin,2);

    % Maximum number of evaluations allowed:
        specs.MaxEval      = 50;    % Horizon (number of evaluations allowed)
        
    % Test points for obtaining the posterior belief:
        specs.Nbel      = 200;
        
    % Random set of representer points:
        specs.z_plot    = define_Ndim_grid(specs);
        
    % Enumerate the subplots:
        specs.subplot_struct    = [1 1];
        specs.subplot_num.gp    = 1;
        
	% Numer of GP samples:
        specs.Ns        = 3;
        
    % Random number for sampling from GP:
        specs.W         = randn(specs.Nbel,specs.Ns);
        
    % Prepare GP:
        specs.GP        = initialize_GP(specs);
        
	% Function:
        % specs.f         = construct_parabola_saturated(specs.GP.hyp);
        specs.f         = construct_discontinuity(specs.GP.hyp);
        
	% Get underlying function:
        specs.f_true    = specs.f(specs.z_plot);
        
	% Add true function to the GP:
        specs.GP.f_true   = specs.f_true;

end
