function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
 





% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PART 1%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[L_out,L_in] = size(Theta1);
[L_out2,L_in2] = size(Theta2);

% Theta1 = randInitializeWeights(L_in - 1, L_out);                    %% genrating the same size of random theta 
% Theta2 = randInitializeWeights(L_in2 - 1, L_out2);                  % genrating theta2 for hidden layer



[m,n] =size(X);                           %% m is number of trainning exmple n is features

x =ones(m,1);                             %% x is columes of 1 

                              
X2 =[x X];                          %% generating X2 with bias values of 1


z2 = X2*Theta1';                       %   z2 = thet1.a1  ( X2 = 5000 x 401 and Theta1 = 401 x 25 

                                      %   z2 = 5000 x 25 

a =sigmoid(z2);                         %  a2 = g(z)         a = 5000 x 25

[m,n] =size(a);                           %%     m = 5000, n= 25

                              

a2 =[x a];                          %% adding a collumn vector of 1 
                                         % a2 is 5000 x 26  
                                         % Theta2 = 10 x26 

z3 = a2*Theta2';                       % z3 =Theta2.a2 , z3 = 5000 x10  

g = sigmoid(z3);                      % hyposthesis g = g(z2);  5000 x 10





for i = 1:L_out2
 
Y(:,i)=[y==i];
end
 
size(Y);

    
    J = (-1/m)* (sum(sum(Y.*log(g) + (1-Y).*(log(1-g)))));
    
    theta_1 = Theta1(:,2:L_in);           %% regularized all theta except bias theta 
    theta_2 = Theta2(:,2:L_in2);          %% regularized all theta except bias theta  
    
    theta1 = theta_1.^2;                   %% esquare each point of theta
    theta2 = theta_2.^2;

    reg_of_cost = (lambda/(2*m))*((sum(sum(theta1)))+ (sum(sum(theta2))));     %% calculating each regularized cost of thetas bys
                                                                               % bys summing all thetas values    

    J = J + reg_of_cost; 
    
    %%  now we have to calculate gradient D
    
    
   
    
    b = [x z2];                     %% adding biase uint at z_2
    
    del3 = g -Y ;                  %% del2 is 5000 x 10
    
    
    del2 = del3*Theta2.*sigmoidGradient(b);              %(del2 is 50000 x 26 )
    
    del2 = del2(:,2:end);                 %% removing bias unit del2( 5000 x 25)
    
   
    D = del2'* X2;                        %% D = 25 x 401       for gradient one
   
    
    D2 = del3'* a2 ;                        % D2 = 10 x 26
    
    
    
    
   Theta1_grad = Theta1_grad + D;               % Theta1_grad is 25 x 401
   
   Theta1_grad = Theta1_grad/m;
   
   Theta2_grad = Theta2_grad + D2;              % Theta2_grad is 10 x 26
   
   Theta2_grad = Theta2_grad/m;
  
   
   %% now we have to calculate gradient for regularized form
   
   
    theta_1 = Theta1(:,2:L_in);           %% regularized all theta except bias theta   25 x 400
    theta_2 = Theta2(:,2:L_in2);          %% regularized all theta except bias theta   10 x 25
    
    h = zeros(L_out,1);                   %% creating zeos for bias unit of theta1 to become zero
    h2 = zeros(L_out2,1);                 %% creating zeos for bias unit of theta1 to become zero
                       
    
    
    theta_1 = [h theta_1];                 %% by doing this we are not regularzing bias unit of theta  
    theta_2 = [h2 theta_2];
   
   Theta1_grad =  Theta1_grad + (lambda/m)* theta_1;
   
   Theta2_grad =  Theta2_grad + (lambda/m)* theta_2;

% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
