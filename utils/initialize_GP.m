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
function GP = initialize_GP(specs)

    % Create GP structure:
        GP = struct;

    % Number of dimensions:
        GP.D             = specs.D;
        
    % Covariance function:
%         GP.covfunc       = {@kerRQard};
%         GP.covfunc       = {@kerSEard};
%         GP.covfunc       = {@kerMaternard};
        GP.covfunc      = {@covRQard};
        
        % Hyperparameters (DIM):
            ls = 0.1;
            ls = reshape(ls,[length(ls),1]);
            std = 30;
            alpha = 1;
%             d = 5;
        
        % Cov. function hyperparameters (in this order):
%             hyp.cov = log([ls;std]);
            hyp.cov = log([ls;std;alpha]);
%             hyp.cov = [log(ls);log(std);d];
    
    % Likelihood function:
        GP.likfunc = @likGauss;
        std_n = 2;
        hyp.lik = log(std_n);
        
    % Mean function:
%         GP.mean      = {@primeanConst};
        GP.mean      = {@meanConst};
        hyp.mean     = 50;
        
    % Include the hyperparameters:
        GP.hyp     	= hyp;
        
    % Empty set of initial evaluations:
        GP.x          = [];
        GP.y          = [];
        
	% Add a vector of test locations to plot in:
        GP.z   = specs.z_plot;
        
    % Random number for sampling from GP:
        GP.W         = specs.W;
        
end

