function x = normalize(x, mu, sigma)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose: 
% Test data set z-score standardization
% -----------------------------------
% Model:
% X = (X - mu) / sigma
% -----------------------------------
% Usage:
% X = test data set (n * d matrix)
% mu = the mean of train data set
% sigma = the sigma of train data set
% -----------------------------------
% Returns:
% X = the data is z-score normalized
% -----------------------------------
% Written by Woliang Yu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    x=bsxfun(@minus,x,mu);
    x=bsxfun(@rdivide,x,sigma);
end
