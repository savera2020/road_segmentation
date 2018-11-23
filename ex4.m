%
%% Initialization
clear ; close all; clc

myPath= '/home/lord/road_detection_project/paris_car_data_set/';

savePath= '/home/lord/road_detection_project/out_put/';

a=dir(fullfile(myPath,'*.jpg'));
fileNames={a.name};

final_boundaries = cell(1,[]);

for count = 1:length(fileNames) %

fileName = strcat(myPath,fileNames(count));  
img = imread(fileName{1});



%% Setup the parameters you will use for this exercise
input_layer_size  = 7;  % 20x20 Input Images of Digits
hidden_layer_size = 50;   % 25 hidden units
num_labels = 2;          % 10 labels, from 1 to 10   
                          % (note that we have mapped "0" to label 10)
if(count<2)


[tr_in tr_out]= init_data(img);                          

                          
                          
X = tr_in;
y= tr_out;

clear tr_in;
clear tr_out;
% % Unroll parameters 
% nn_params = [Theta1(:) ; Theta2(:)];


%% ================ Part 6: Initializing Pameters ================
%  In this part of the exercise, you will be starting to implment a two
%  layer neural network that classifies digits. You will start by
%  implementing a function to initialize the weights of the neural network
%  (randInitializeWeights.m)

%fprintf('\nInitializing Neural Network Parameters ...\n')

initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);

% Unroll parameters
initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];


else
    
    X = X_live_sample;
    y = Y_live_sample;
    
    
    initial_nn_params = [Theta1(:) ; Theta2(:)];
    
    


end


%% =============== Part 7: Implement Backpropagation ===============



%% =============== Part 8: Implement Regularization ===============
%


%% =================== Part 8: Training NN ===================
%  You have now implemented all the code necessary to train a neural 
%  network. To train your neural network, we will now use "fmincg", which
%  is a function which works similarly to "fminunc". Recall that these
%  advanced optimizers are able to train our cost functions efficiently as
%  long as we provide them with the gradient computations.
%
fprintf('\nTraining Neural Network... \n')

%  After you have completed the assignment, change the MaxIter to a larger
%  value to see how more training helps.

%if(
options = optimset('MaxIter', 400);

%  You should also try different values of lambda
lambda = .1;

% Create "short hand" for the cost function to be minimized
costFunction = @(p) nnCostFunction(p, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, X, y, lambda);

% Now, costFunction is a function that takes in only one argument (the
% neural network parameters)
[nn_params, cost] = fmincg(costFunction, initial_nn_params, options);

% Obtain Theta1 and Theta2 back from nn_params
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% fprintf('Program paused. Press enter to continue.\n');
% pause;

if(count<2)
   
    
    
%     save ('initial_theta1','Theta1');
%     save ('initial_theta2','Theta2')
    
end



%% ================= Part 9: Visualize Weights =================
%  You can now "visualize" what the neural network is learning by 
%  displaying the hidden units to see what features they are capturing in 
%  the data.

% fprintf('\nVisualizing Neural Network... \n')
% 
% displayData(Theta1(:, 2:end));

% fprintf('\nProgram paused. Press enter to continue.\n');
% pause;

%% ================= Part 10: Implement Predict =================
%  After training the neural network, we would like to use it to predict
%  the labels. You will now implement the "predict" function to use the
%  neural network to predict the labels of the training set. This lets
%  you compute the training set accuracy.

pred = predict(Theta1, Theta2, X);
fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred == y))* 100);



% pred = predict(Theta1, Theta2, cv_in);
% fprintf('\nCross validation  Accuracy: %f\n', mean(double(pred == (cv_out))) * 100);
% % pred = predict(Theta1, Theta2, test_in);
% % fprintf('\nTest Set Accuracy: %f\n', mean(double(pred == (test_out))) * 100);
%  pred = predict(Theta1, Theta2, test_in(1:1000,:));
%  fprintf('\nTest Set Accuracy: %f\n', mean(double(pred == (test_out(1:1000)))) * 100);


%plot(cost)

[vector_image,CA,CH,CV,CD,input_H,input_S,input_I] = init_data_image(img);


pred = predict(Theta1, Theta2, vector_image);

result = pred-1;


output_image = reshape(result',480,640);

output_image(1:140,:) = 0;
%imshow(output_image)
morph_out = morphy_operation(logical(output_image));
 
morph_out = morphy_operation(logical(~ morph_out)); 

morph_out = ~morph_out;

% imshow(img)
% pause(.1)
% 
% imshow(morph_out,[]);

% pause(.1)
[ X_live_sample1 Y_live_sample1, Road_boundary,thre] = DataSample(morph_out,CA,CH,CV,CD,input_H,input_S,input_I);


if(thre>20)
    
 X_live_sample = X_live_sample1;
 
 Y_live_sample = Y_live_sample1;

    
    
end

img_out = draw_boundary(Road_boundary,img);


imshow(img_out)

pause(.3)


filesave= strcat(savePath,num2str(count),'.jpg');


final_boundaries1{count,1} = Road_boundary;

%imwrite(img_out,filesave,'jpg');




close all

%keyboard()




end


save('final_boundaries1','final_boundaries1')








