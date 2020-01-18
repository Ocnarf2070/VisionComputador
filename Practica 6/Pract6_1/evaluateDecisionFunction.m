 function d = evaluateDecisionFunction(x, num_classes, mu, covar, prior)
% Evaluate the gaussian deccision function of a vector of features given:
% x: vector of features
% num_classes: number of classes in the problem
% covar: covariance matrix of the class
% prior: a priori probability of that class
    A=log(prior);
    diff=x-mu;
    B=-(num_classes*log(2*pi)+log(det(covar))+diff'*inv(covar)*diff)/2;
    d =A+B;
end
