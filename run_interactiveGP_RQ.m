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

%% Initialize specs:
specs = initialize_ES();

%% Create plot:
[fig_hdl,axes_hdl] = initialize_plots(specs);

%% Create slider:

% Subplot size:
pos_sp = axes_hdl.gp.Position;

% Slider construction lengthscale:
shape.pos       = [pos_sp(1) + pos_sp(3),pos_sp(2)] + [50 0];
shape.size      = [20;120];
variable.init   = 1; ls_init = variable.init;
variable.min    = 0.1;
variable.max    = 10;
hdl_callback    = @update_GPplot_callback_RQ;
pars.GP         = specs.GP;
pars.what2mod   = 'ls';
pars.ls_init    = 1;
create_slider(shape,variable,hdl_callback,axes_hdl.gp,pars);

% Slider construction offset:
shape.pos       = [pos_sp(1) + pos_sp(3),pos_sp(2)] + [125 0];
shape.size      = [20;120];
variable.init   = exp(specs.GP.hyp.cov(2));
variable.min    = 1;
variable.max    = 50;
hdl_callback    = @update_GPplot_callback_RQ;
pars.GP         = specs.GP;
pars.what2mod   = 'std';
pars.std_init   = exp(specs.GP.hyp.cov(2));
create_slider(shape,variable,hdl_callback,axes_hdl.gp,pars);

% Slider construction alpha:
shape.pos       = [pos_sp(1) + pos_sp(3),pos_sp(2)] + [200 0];
shape.size      = [20;120];
variable.init   = exp(specs.GP.hyp.cov(3));
variable.min    = -2;
variable.max    = 1;
hdl_callback    = @update_GPplot_callback_RQ;
pars.GP         = specs.GP;
pars.what2mod   = 'alpha';
pars.alpha_init = exp(specs.GP.hyp.cov(3));
create_slider(shape,variable,hdl_callback,axes_hdl.gp,pars);

%% Create button:

shape.pos       = [pos_sp(1) + pos_sp(3),pos_sp(2) + pos_sp(4)/2] + [50 0];
shape.size      = [120 40];
hdl_callback    = @update_GPplot_callback_RQ;
pars.GP         = specs.GP;
pars.specs      = specs;
pars.what2mod    = 'new_evaluation';
create_button(shape,[],hdl_callback,axes_hdl.gp,pars)

%% Update plot:

specs.GP.hyp.cov(1) = log(pars.ls_init);
update_GPplot(fig_hdl,axes_hdl.gp,specs.GP);

