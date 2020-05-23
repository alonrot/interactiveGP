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
function [mpost,vpost,stdpost,samples] = get_posterior(GP,z_test,Xeval,Yeval)
%GET_POSTERIOR Gaussian Process posterior conditioned on data
%   [mpost,vpost,stdpost] = GET_POSTERIOR(GP,z_test,Xeval,Yeval) returns
%   the posterior mean and variance of a Gaussian process on the test
%   locations z_test, conditioned on the data {Xeval,Yeval}.
%
% (C) 2016 Max Planck Society. All rights reserved.
%
% Alonso Marco Valle
%
    
    GP.z = z_test;
    GP.x = Xeval;
    GP.y = Yeval;
    [mpost,vpost,stdpost] = conditioning(GP);
    
    % Get some samples:
    samples = get_samples(mpost,vpost,GP.W);
    
    if ~isempty(find(stdpost<0,1))
        display('Some variances are negative. A fix might be needed');
    elseif ~isempty(find(isinf(stdpost),1))
        display('Some variances are Inf');
        % Fix for plotting purposes:
        display('The Inf values are changed to non-Inf values, just for plotting purposes');
        stdpost(isinf(stdpost)) = max(stdpost(~isinf(stdpost)))*10;
    end
    
end

function samples = get_samples(mpost,vpost,W)
    samples = bsxfun(@plus,mpost,chol(chol_fix(vpost))' * W);
end

function [mpost,vpost,stdpost] = conditioning(GP)

    % Special case for no data:
    if isempty(GP.x)
        
        kzz = get_Gramm_Matrix(GP);
        mpost = feval(GP.mean{:},GP.hyp.mean,GP.z);
        vpost = kzz;
        stdpost = sqrt(diag(vpost));

    else

        % Build up Gramm matrices:
        [kzz,kXX,kzX] = get_Gramm_Matrix(GP);

        % Prior mean:
        M = feval(GP.mean{:},GP.hyp.mean,GP.x);
        m = feval(GP.mean{:},GP.hyp.mean,GP.z);

        % Get noise covariance function:
        kXX_n = get_noise_cov(GP.hyp.lik,GP.x);

        % Posterior mean and covariance:
        G_ = kXX + kXX_n;
        R_ = chol(chol_fix(G_));
        A_ = kzX / R_;
        mpost = m + A_ * (R_' \ (GP.y-M));
        vpost = kzz - A_*A_';
        stdpost = sqrt(diag(vpost));
    
    end

end

function [kzz,kXX,kzX] = get_Gramm_Matrix(GP)

    % Build up Gramm matrices:
    if nargout == 1
        kzz     = feval(GP.covfunc{:},GP.hyp.cov,GP.z,[]);
        return;
    else
        kXX     = feval(GP.covfunc{:},GP.hyp.cov,GP.x,[]);
        kzz     = feval(GP.covfunc{:},GP.hyp.cov,GP.z,[]);
        kzX     = feval(GP.covfunc{:},GP.hyp.cov,GP.z,GP.x);
    end

end