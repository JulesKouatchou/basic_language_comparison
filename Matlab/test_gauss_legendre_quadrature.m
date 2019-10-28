
% Adapted from code written by Greg von Winckel - 02/25/2004
%  https://www.mathworks.com/matlabcentral/fileexchange/4540-legendre-gauss-quadrature-weights-and-nodes

function gaussLegendreQuad(M)

    fprintf('--------------------------\n')
    fprintf('Gauss-Legendre Quadrature:  %5g \n', M)
    fprintf('--------------------------\n')

    a = -3.0;
    b =  3.0;

    tic
    N   = M-1;
    Np1 = N+1;
    Np2 = N+2

    xu=linspace(-1,1,Np1)';

    % Initial guess
    y=cos((2*(0:N)'+1)*pi/(2*N+2))+(0.27/Np1)*sin(pi*xu*N/Np2);

    % Legendre-Gauss Vandermonde Matrix
    L=zeros(Np1,Np2);

    % Derivative of LGVM
    Lp=zeros(Np1,Np2);

    % Compute the zeros of the N+1 Legendre Polynomial
    % using the recursion relation and the Newton-Raphson method

    y0=2;

    % Iterate until new points are uniformly within epsilon of old points
    while max(abs(y-y0))>eps
          L(:,1)=1;
          Lp(:,1)=0;

          L(:,2)=y;
          Lp(:,2)=1;

          for k=2:Np1
              L(:,k+1)=( (2*k-1)*y.*L(:,k)-(k-1)*L(:,k-1) )/k;
          end

          Lp=(Np2)*( L(:,Np1)-y.*L(:,Np2) )./(1-y.^2);

          y0=y;
          y=y0-L(:,Np2)./Lp;
    end

    % Linear map from[-1,1] to [a,b]
    x=(a*(1-y)+b*(1+y))/2;

    % Compute the weights
    w=(b-a)./((1-y.^2).*Lp.^2)*(Np2/Np1)^2;
    
    integral_value = w'*exp(x);

    toc

exit;
