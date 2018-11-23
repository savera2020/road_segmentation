function W = randInitializeWeights(L_in, L_out)
%RANDINITIALIZEWEIGHTS Randomly initialize the weights of a layer with L_in
%incoming connections and L_out outgoing connections
%   W = RANDINITIALIZEWEIGHTS(L_in, L_out) randomly initializes the weights 
%   of a layer with L_in incoming connections and L_out outgoing 
%   connections. 
%
%   Note that W should be set to a matrix of size(L_out, 1 + L_in) as
%   the column row of W handles the "bias" terms
%

% You need to return the following variables correctly 
W = zeros(L_out, 1 + L_in);


E = .12;            % it will genrate theta from range {-.12,.12}

% good choice of E is squareroot of 6 / squareroot(L_in + L_out) 

% ====================== YOUR CODE HERE ======================
% Instructions: Initialize W randomly so that we break the symmetry while
%               training the neural network.
%
% Note: The first row of W corresponds to the parameters for the bias units
%
theta1 = rand(L_out,L_in)*(2*E)- E;        % generating random value of theta between {-.12,.12}

bias  = ones(L_out,1);

W = bias;

W(:,2:1+L_in)= theta1;










% =========================================================================

end