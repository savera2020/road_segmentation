function morph_out = morphy_operation(bin_image)


se5 = strel('rectangle',[10 10]);

erod_imag = imerode(bin_image,se5);


morph_out = imdilate(erod_imag,se5);



end

