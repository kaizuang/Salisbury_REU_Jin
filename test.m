

 directory = dir("photos/*.jpg");

 disp(directory)

 for i = 1:length(directory)
      %Finds original image
      disp(directory(i));
      image_path = strcat("photos/",directory(i).name);
      img = imread(image_path);

      
      %Crops to a 509 x 461 image and writes to new file
      cropped = imcrop(img,[16,200,508,460]);
      new_file_path = strcat("cropped/img",string(i),"_cropped.jpg");
      imwrite(cropped,new_file_path);
      imshow(cropped)


      







 end


    


   