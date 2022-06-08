
 directory = dir("photos/*.jpg");

 %crops
 for i = 1:length(directory)
      %Finds original image and converts to grayscale
      image_path = strcat("photos/",directory(i).name);
      img = rgb2gray(imread(image_path));
      %Crops to a 509 x 461 image and writes to new file
      cropped = imcrop(img,[16,200,508,460]);
      if sum(sum(img)>10000) < 200
        new_file_path = strcat("cropped_dark/",directory(i).name);

      else
        new_file_path = strcat("cropped_light/",directory(i).name);

      end  
      imwrite(cropped,new_file_path);
 end

 %filters
 cropd_directory = dir("cropped_dark/*.jpg");
 for j = 1 : length(cropd_directory)
      %Finds cropped image
      image_path = strcat("cropped_dark/",cropd_directory(j).name);
      img = imread(image_path);
      %filters crop file and writes to new folder
      filtered = medfilt2(img);
      new_file_path = strcat("filtered_d/",cropd_directory(j).name);
      imwrite(filtered,new_file_path);
 end
 cropl_directory = dir("cropped_light/*.jpg");
 for j = 1 : length(cropl_directory)
      %Finds cropped image
      image_path = strcat("cropped_light/",cropl_directory(j).name);
      img = imread(image_path);
      %filters crop file and writes to new folder
      filtered = medfilt2(img);
      new_file_path = strcat("filtered_l/",cropl_directory(j).name);
      imwrite(filtered,new_file_path);
 end
 


 %contour detection
 filterd_directory = dir("filtered_d/*.jpg");
 for k = 1 : length(filterd_directory)
      %Finds cropped image
      image_path = strcat("filtered_d/",filterd_directory(k).name);
      img = imread(image_path);
      %contours image
      contour_img = edge(img,'sobel');
      new_file_path = strcat("sobel_d/",filterd_directory(k).name);
      imwrite(contour_img,new_file_path);
      imshow(contour_img)
 end
 filter_directory = dir("filtered_l/*.jpg");
 for k = 1 : length(filter_directory)
      %Finds cropped image
      image_path = strcat("filtered_l/",filter_directory(k).name);
      img = imread(image_path);
      %contours image
      contour_img = edge(img,'sobel');
      new_file_path = strcat("sobel_l/",filter_directory(k).name);
      imwrite(contour_img,new_file_path);
      imshow(contour_img)
 end


 %refilter contours
 contourd_directory = dir("sobel_d/*.jpg");
 for l = 1 : length(contourd_directory)
     %finds contour image
     image_path = strcat("sobel_d/",contourd_directory(l).name);
     img = imread(image_path);
     %filters contour image
     filtered = imgaussfilt(img,8);
     new_file_path = strcat("refiltered_d/",contourd_directory(l).name);
     imwrite(filtered,new_file_path)
     imshow(filtered)
 end
 contourl_directory = dir("sobel_l/*.jpg");
 for l = 1 : length(contourl_directory)
     %finds contour image
     image_path = strcat("sobel_l/",contourl_directory(l).name);
     img = imread(image_path);
     %filters contour image
     filtered = imgaussfilt(img,4);
     new_file_path = strcat("refiltered_l/",contourl_directory(l).name);
     imwrite(filtered,new_file_path)
     imshow(filtered)
 end

 %binarize refiltered images
 refilteredd_directory = dir("refiltered_d/*.jpg");
 for m = 1 : length(refilteredd_directory)
     %finds contour image
     image_path = strcat("refiltered_d/",refilteredd_directory(m).name);
     img = imread(image_path);
     %filters contour image
     filtered = imbinarize(img,.12);
     new_file_path = strcat("binarized_d/",refilteredd_directory(m).name);
     imwrite(filtered,new_file_path)
     imshow(filtered)
 end
 refilteredl_directory = dir("refiltered_l/*.jpg");
 for m = 1 : length(refilteredl_directory)
     %finds contour image
     image_path = strcat("refiltered_l/",refilteredl_directory(m).name);
     img = imread(image_path);
     %filters contour image
     filtered = imbinarize(img,.08);
     new_file_path = strcat("binarized_l/",refilteredl_directory(m).name);
     imwrite(filtered,new_file_path)
     imshow(filtered)
 end

 %reblur binarized images
 binarizedd_directory = dir("binarized_d/*.jpg");
 for n = 1 : length(binarizedd_directory)
     %finds contour image
     image_path = strcat("binarized_d/",binarizedd_directory(n).name);
     img = imread(image_path);
     %filters contour image
     filtered = imgaussfilt(img,10);
     new_file_path = strcat("reblured_d/",binarizedd_directory(n).name);
     imwrite(filtered,new_file_path)
     imshow(filtered)
 end
 binarizedl_directory = dir("binarized_l/*.jpg");
 for n = 1 : length(binarizedl_directory)
     %finds contour image
     image_path = strcat("binarized_l/",binarizedl_directory(n).name);
     img = imread(image_path);
     %filters contour image
     filtered = imgaussfilt(img,20);
     new_file_path = strcat("reblured_l/",binarizedl_directory(n).name);
     imwrite(filtered,new_file_path)
     imshow(filtered)
 end
 volume = 0;
 %rebinarize reblured images and invert and sum
 rebluredd = dir("reblured_d/*.jpg");
 for o = 1 : length(rebluredd)
     %finds contour image
     image_path = strcat("reblured_d/",rebluredd(o).name);
     img = imread(image_path);
     %filters contour image
     filtered = imcomplement(imbinarize(img,.135));
     volume = volume + (sum(sum(filtered)) * .7) ;
     new_file_path = strcat("rebinarized_d/",rebluredd(o).name);
     imwrite(filtered,new_file_path)
     imshow(filtered)
 end
 rebluredl = dir("reblured_l/*.jpg");
 for o = 1 : length(rebluredl)
     %finds contour image
     image_path = strcat("reblured_l/",rebluredl(o).name);
     img = imread(image_path);
     %filters contour image
     filtered = imcomplement(imbinarize(img,.04));
     volume = volume + (sum(sum(filtered))*.7);
     new_file_path = strcat("rebinarized_l/",rebluredl(o).name);
     imwrite(filtered,new_file_path)
     imshow(filtered)
 end
 disp(strcat("volume is ~ ",string(volume)," units^3"))
 

 


