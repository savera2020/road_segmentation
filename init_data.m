%  
%clear ; close all; clc



function [tr_in  tr_out] = init_data(img)

        

        imshow(img, []);
        rect = getrect();    %% Draw the rectangular for input image
        close(1) 
        object_image = imcrop(img, rect);
        
        object_image = imresize(object_image,[160,160]);
        
        imshow(img, []);
        rect1 = getrect();    %% Draw the rectangular for input image
        close(1)
        
        
        object_gray_image = rgb2gray(object_image);
        
        
        background_image = imcrop(img, rect1);
        background_image = imresize(background_image,[160,160]);
        background_gray_image = rgb2gray(background_image);
        
        object_HSI = rgbtohsi(object_image);                       %%
        background_HSI = rgbtohsi(background_image);  
        
        %%

        positive_sample = wavelet_feature(im2double(object_gray_image),object_HSI);
        
        negative_sample = wavelet_feature(im2double(background_gray_image),background_HSI);
        
        positive_lable = ones(3000,1);
        
        negative_lable = zeros(3000,1);
        

feature = 7;


positive_data =  double([positive_sample positive_lable]);

negative_data = double([negative_sample negative_lable]);








train1 = [positive_data;negative_data];


train1 = randmize_data(train1);               %% randmize the data




tr_in = double(train1(:,1:feature));
tr_out = double(train1(:,feature+1))+1;





%  cv_in = double(cv_data1(:,1:feature));
%  cv_out = double(cv_data1(:,feature+1))+1;
% 
%  
% 
% test_in = double(test_data1(:,1:feature));
% test_out = double(test_data1(:,feature+1))+1;

%clear data;
clear rect;
clear train1;
clear cv_data1;
clear test_data1;
clear object_gray_image
clear object_HSI
clear object_image
clear background_gray_image
clear background_HSI
clear background_image
clear negative_lable
clear negative_sample
clear nig_data
clear pos_data
clear trafic_data
clear positive_lable
clear possible sample
% clear TLD_train_data
% clear TLD_test_data
% clear TLD_negative_data
clear feature

end

