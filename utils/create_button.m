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
function create_button(shape,variable,hdl_callback,axes_hdl,pars)

    button_text_color = [0.3 0.3 0.3];

    % Buttons creation:
    button_start = uicontrol('Style','pushbutton',...
                            'String',pars.what2mod,...
                            'BackgroundColor',[152,251,152]/255,...
                            'ForegroundColor',button_text_color,...
                            'Callback',{hdl_callback,axes_hdl,pars});
                        
	button_start.Position = [shape.pos shape.size];
    
    font_size = 10;
    set(button_start,'FontSize',font_size);

end