function [ X_live_sample Y_live_sample, Road_boundary,thre] =  DataSample(morph_out,CA,CH,CV,CD,input_H,input_S,input_I)

%function [boundaries] = DataSample(morph_out,img,CA,CH,CV,CD,input_H,input_S,input_I)


train_live_sample = [];

thre = 0;
[boundaries] = bwboundaries(morph_out,'noholes'); 


if(~isempty(boundaries))

for k=1:length(boundaries)
  
   blob_length(k) = length(boundaries{k}) ;
    
end


  [dummy, index] = max(blob_length);
  
  Road_boundary = boundaries{index};
  
  %keyboard()
  
   [rows,cols] = size(morph_out);
   
    for count = 1:200;
        
       
        
       rand_row_neg =  randi(135,1); 
       rand_row =  randi(rows-2,1);
       rand_col =  randi(cols-2,1);
       rand_row = rand_row+1;                %% rand will not chosse max or min value of image
       
       rand_col = rand_col+1; 
       
       
        point_index = find(Road_boundary(:,2)== rand_col);
       
       %keyboard()
      
       
         train_live_sample(count,:) = [CA(rand_row_neg,rand_col) CH(rand_row_neg,rand_col) CV(rand_row_neg,rand_col) CD(rand_row_neg,rand_col) input_H(rand_row_neg,rand_col) input_S(rand_row_neg,rand_col) input_I(rand_row_neg,rand_col) 1];
         % Y_live_sample(count,1) = 1;
         
         
         
      
       
          
    end
       
     for count1 = 1:500;
         
         
       rand_row =  randi(rows-2,1);
       rand_col =  randi(cols-2,1);
       rand_row = rand_row+1;                %% rand will not chosse max or min value of image
       
       rand_col = rand_col+1; 
       
       
        point_index = find(Road_boundary(:,2)== rand_col);
        
       if(~isempty(point_index))
        
       if(rand_row-20 > Road_boundary(point_index(1),1) )  
           
           count=count+1;
           
           thre = thre+1;
         train_live_sample(count,:) = [CA(rand_row,rand_col) CH(rand_row,rand_col) CV(rand_row,rand_col) CD(rand_row,rand_col) input_H(rand_row,rand_col) input_S(rand_row,rand_col) input_I(rand_row,rand_col) 2];
          %Y_live_sample(count,1) = 2 ;
        end   
           
       end
       
     end
    
     
     train_live_sample =  randmize_data(train_live_sample);
     
     
     X_live_sample = train_live_sample(:,1:7);
     Y_live_sample = train_live_sample(:,8);
     
        
   % keyboard()
else
   
    
     X_live_sample = 1;
     Y_live_sample =1; 
     Road_boundary = [1 1];
     thre =0;
    
    
   
end

  



end
