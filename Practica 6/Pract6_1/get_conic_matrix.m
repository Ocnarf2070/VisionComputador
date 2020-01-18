function conic_matrix = get_conic_matrix(covariance,centroid)
% Returns the matrix representation of a conic section given the:
% covariance: covariance matrix of a two dimensional gaussian
% centoid: centroid [mu1 mu2] of that gaussian
    syms x1 x2
    X = [x1 x2];
    independiente = -1/2*((log(det(covariance))+centroid*covariance.^(-1)*centroid'));
    lineal = X*covariance.^(-1)*centroid'; % simplify?
    cuadratico = -1/2*X*covariance.^(-1)*X.';
    ecuacion = cuadratico + lineal + independiente;
    [decision,terminos] = coeffs(ecuacion);
    A = double(decision(find(terminos==x1^2)));
    B = double(decision(find(terminos==x1*x2)));
    C = double(decision(find(terminos==x2^2)));
    D = double((decision(find(terminos==x1))));
    E = double(decision(find(terminos==x2)));
    F = double(decision(find(terminos==1)));
    conic_matrix = [A B/2 D/2; B/2 C E/2; D/2 E/2 F];

