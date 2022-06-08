 directory = dir("photos/*.jpg");
 a = zeros(1,length(directory));
 %populates array
 for i = 1:length(directory)
      %Finds original image and converts to grayscale
      image_path = strcat("photos/",directory(i).name);
      img = rgb2gray(imread(image_path));
      %Crops to a 509 x 461 image and writes to new file
      cropped = imcrop(img,[16,200,508,460]);
      a(i) = sum(sum(img)>10000);
 end
 [f,xi] = ksdensity(a);
 plot(xi,f,'LineWidth',2)
 title('Clusters')
 xlabel('Sum')