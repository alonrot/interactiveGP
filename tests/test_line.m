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
%% Initialization:
clear all; close all; clc;

%% Create plot:
[fig_hdl,axes_hdl] = initialize_plots();

%% Define line:

global m offset;

% Parameters:
m = 1;
offset = 0;

% Vectors:
N_div = 100;
x = linspace(0,10,N_div);
y = m * x + offset;

%% Update plot:

axes(axes_hdl.rect); cla;
plot(x,y);
xlim([0 10]); ylim([-10 10]);

%% Create slider:

% Subplot size:
pos_sp = axes_hdl.rect.Position;

% Slider construction slope:
shape.pos       = [pos_sp(1) + pos_sp(3),pos_sp(2)] + [50 0];
shape.size      = [20;120];
variable.init   = 1;
variable.min    = -10;
variable.max    = 10;
hdl_callback    = @update_line_callback;
pars.x          = x;
pars.what2mod    = 'slope';
create_slider(shape,variable,hdl_callback,axes_hdl.rect,pars);

% Slider construction offset:
shape.pos       = [pos_sp(1) + pos_sp(3),pos_sp(2)] + [100 0];
shape.size      = [20;120];
variable.init   = 0;
variable.min    = -10;
variable.max    = 10;
hdl_callback    = @update_line_callback;
pars.x          = x;
pars.what2mod    = 'offset';
create_slider(shape,variable,hdl_callback,axes_hdl.rect,pars);

