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
function create_slider(shape,variable,hdl_callback,axes_hdl,pars)

% Slider bar for m:
uicontrol('Style', 'slider','Min',variable.min,'Max',variable.max,'Value',variable.init,...
    'Position', [shape.pos(1) shape.pos(2) shape.size(1) shape.size(2)],'Callback',{hdl_callback,axes_hdl,pars});
 % Add a text uicontrol to label the slider.
uicontrol('Style','text','Position',[shape.pos(1)+20 shape.pos(2)+50 shape.size(1)+10 shape.size(2)-100],...
    'String',pars.what2mod);
uicontrol('Style','text','Position',[shape.pos(1)+20 shape.pos(2) shape.size(1)+10 shape.size(2)-100],...
    'String',num2str(variable.min));
uicontrol('Style','text','Position',[shape.pos(1)+20 shape.pos(2)+100 shape.size(1)+10 shape.size(2)-100],...
    'String',num2str(variable.max));

end