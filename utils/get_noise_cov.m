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
function k_n = get_noise_cov(hyp_lik,x)

    % Error checking:
    if nargin == 1
        error('2 inputs are needed');
    end
    
    % Check dimensions of x and/or z:
    if isfield(hyp_lik,'D_euc')
        D_euc = hyp_lik.D_euc;
        D = D_euc + 1;
    elseif isfield(hyp_lik,'c1') && isfield(hyp_lik,'c2')
        error('Please, specify the number of euclidean input dimensions hyp_lik.D_euc for the bivariate kernel');
    else
        N = size(x,1);
        k_n = exp(2*hyp_lik) * eye(N);
        return;
    end
    
    % Get deltas:
    delta_x = x(:,D);
    
    % Get indices matrix:
    ind_mat = bsxfun(@times,delta_x,delta_x');
    
    % Get noise matrix:
    k_n =   exp(2*hyp_lik.c1) + ... % simu noise (always there, but exp(hyp.lik.c2) has to be the error std)
            exp(2*hyp_lik.c2) .* (ind_mat); % error noise

end