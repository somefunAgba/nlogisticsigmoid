function [y,dy_dx] = nlsig(x,xmax,xmin,ymax,ymin,n,lambda,e,isreverse)
%NLOGISTIC-SIGMOID
% min->max
%<oasomefun@futa.edu.ng> c. 2020

if nargin < 6
    n = 1;
    lambda = 6;
    e = 0;
    isreverse = 0;
end
if nargin <= 6
    lambda = 6;
    e = 0;
    isreverse = 0;
end
if nargin <= 7
    e = 0;
    isreverse = 0;
end
if nargin <= 8
    isreverse = 0;
end

veclen_x = numel(x);
e = min(100,max(-100,e));
e = e/100;
% set constraints, max and min
ymin = (1-e)*ymin;
ymax = (1-e)*ymax;

% quantize or partition the input-output space by
% a n degree. A greater n is a more finer space
% The most sparse or coarse space is n = 1

dy =(ymax-ymin)/n;
dx =(xmax-xmin)/n;

% ky = ymin;
kx = xmin;

% set alpha and delta as a function of input space
alpha = lambda.*(2/dx);
% set tau as a function of the output space
tau = alpha/dy;

% inflections (midpoints)
delta_i=zeros(n,1);
% partial output;
v_i = zeros(n,veclen_x);
% output
y = zeros(1,veclen_x);
y(1,:) = ymin;
% rate of output with respect to input
dy_dx = zeros(1,veclen_x);
% exponential input direction logic
c = -1;
if (isreverse==1)
    c = 1;
end

for i=1:n
    delta_i(i,1) = kx + (dx*(i-0.5));
    % kx = kx + dx;
    
    % exponential input
    u = c.*alpha.*(x-delta_i(i,1));
    %v_i(i,:) = dy./(1+exp(u));
    v_i(i,:) = dy./(1+expbyones(u,2));
    y(1,:) = y(1,:) + v_i(i,:);
    
    % partial output-derivative
    % d_i = v_i(i,:).*(dy - v_i(i,:));
    dy_dx(1,:) = dy_dx(1,:) + ( v_i(i,:).*(dy - v_i(i,:)) );
end

dy_dx = tau.*dy_dx;


end
