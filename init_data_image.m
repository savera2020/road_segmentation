%  
%clear ; close all; clc



function [vector_image,CA,CH,CV,CD,input_H,input_S,input_I] = init_data_image(img)
      
              
       input_gray_image = rgb2gray(img);
       input_HSI = rgbtohsi(img);                       %%
        
        
        %%
        [rows,cols] = size(input_gray_image); 
        
        %[cA,cH,cV,cD] = dwt2(input_gray_image,'haar');
        [cA,cH,cV,cD] = haar_wavelet(input_gray_image);
        
        CA = imresize(cA, [rows cols]);
        CH = imresize(cH, [rows cols]);
        CV = imresize(cV, [rows cols]);
        CD = imresize(cD, [rows cols]);
        
        input_H = input_HSI(:,:,1);
        input_S = input_HSI(:,:,2);
        input_I = input_HSI(:,:,3);
        
        
        vector_image  = [CA(:) CH(:) CV(:) CD(:) input_H(:) input_S(:) input_I(:)];
        
        
        
        
        
        
        


end

