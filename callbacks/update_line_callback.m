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
function update_line(hObj,evnt,hdl,par)

global m offset;

switch par.what2mod
    case 'slope'
        m = get(hObj,'Value');
    case 'offset'
        offset = get(hObj,'Value');
end

% Update plot:
axes(hdl); cla;
y = m * par.x + offset;
plot(par.x,y)
xlim([0 10]); ylim([-10 10]);
end