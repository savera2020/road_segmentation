
function img_out = draw_boundary(road_boundary,img_in)


for i=1:size(road_boundary,1)
    
    
    if(((road_boundary(i,1)-1)>1)&& ((road_boundary(i,2)-1)>1) && ((road_boundary(i,1)+1)<480) && ((road_boundary(i,1)+1)<640))
     
    img_in(road_boundary(i,1)-1:road_boundary(i,1)+1,road_boundary(i,2)-1:road_boundary(i,2)+1,1)= 255;
    
    img_in(road_boundary(i,1)-1:road_boundary(i,1)+1,road_boundary(i,2)-1:road_boundary(i,2)+1,2)= 0 ;
    img_in(road_boundary(i,1)-1:road_boundary(i,1)+1,road_boundary(i,2)-1:road_boundary(i,2)+1,3)= 0 ;
    end

   img_out  = img_in;

end



end
