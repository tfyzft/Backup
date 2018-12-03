
function dgau2D = DivGauss2D(sigma,seta)

% Magic numbers
  GaussianDieOff = .000001;  
  r = 0.5;
  % Design the filters - a gaussian and its derivative
  pw = 1:50; % possible widths
  ssq = sigma^2;
  width = find(exp(-(pw.*pw)/(2*ssq))>GaussianDieOff,1,'last');
  if isempty(width)
    width = 1;  % the user entered a really small sigma
  end

  t = (-width:width);
  gau = exp(-(t.*t)/(2*ssq))/(2*pi*ssq);     % the gaussian 1D filter

  % Find the directional derivative of 2D Gaussian (along X-axis)
  % Since the result is symmetric along X, we can get the derivative along
  % Y-axis simply by transposing the result for X direction.
  [x,y]=meshgrid(-width:width,-width:width);
  x1 = x .* cos( seta ) + y .* sin( seta );
  y1 = -x .* sin( seta ) + y .* cos( seta );

  dgau2D=-x1.*exp(-(x1.*x1+y1.*y1*r*r)/(2*ssq))/(pi*ssq);
  %=======================================================================%
  