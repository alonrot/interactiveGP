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
function disco = construct_discontinuity(hyp)

    disco = @(X) get_disco(X,hyp);

end

function Y = get_disco(X,hyp)

    Y = zeros(length(X),1);
    Y(abs(X)>7) = 50;

    Y = Y + get_noise(hyp);

end

function epsilon = get_noise(hyp)

    % Same as the noise specified in the prior:
    std_n = exp(hyp.lik);
    epsilon = std_n * randn;

end