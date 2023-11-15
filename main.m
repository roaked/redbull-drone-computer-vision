
%% Chose an image

%training set

%img = imread('IMG_9766.jpg');
img = imread('IMG_9510.jpg');
%img = imread('IMG_7125.jpg');
%img = imread('IMG_7071.jpg');


%other images

%img = imread('IMG_4599.jpg');
%img = imread('IMG_2074.jpg');
%img = imread('IMG_1130.jpg');
%img = imread('IMG_0345.jpg');
%img = imread('IMG_0268.jpg');
%img = imread('IMG_0208.jpg');
%img = imread('IMG_9991.jpg');
%img = imread('IMG_8509.jpg');


%% Colorspace Segmentation && Morphological Operations

%close all

[seg,BW] = Segmenter(img);

figure (1)
subplot(1,2,1)
imshow(img)
subplot(1,2,2)
imshow(seg)


%% BW Noise removal


%close all


se = strel('square',20);
BW = imopen(BW,se);
BW = imclose(BW,se); 
figure (2)
imshow(BW);
WB = 1-BW;



%% Edge detection

%close all

% BW1 = edge(BW,'sobel');
% figure (3)
% imshow(BW1)
% 
% BW2 = edge(BW,'log');
% figure (4)
% imshow(BW2)

BWcanny = edge(BW,'canny');
figure (3)
imshow(BWcanny)

imgHSVseg = rgb2hsv(seg);

hueseg = imgHSVseg(:,:,1);


BWImage = edge(hueseg,'canny',0.1,0.01);
figure (4)
imshow(BWImage)


%Canny best results

%% Gate Aligned & Detect Corners

[C] = CornerDetec(BWcanny);

%3. Plot the corners
figure (5)
imshow(img); hold on 
plot(C([1:4 1],1),C([1:4 1],2),'r*','LineWidth',5,'MarkerSize',5);


%% Centroid Detection

stat = regionprops(BWcanny,'centroid');
figure (6)
imshow(img); hold on;
plot(C([1:4 1],1),C([1:4 1],2),'g','LineWidth',5,'MarkerSize',5);
plot(C([1:4 1],1),C([1:4 1],2),'r*','LineWidth',5,'MarkerSize',5);

centroid_Number = 2;
if size(struct2table(stat),1) == 1
    centroid_Number = 1;
else
    holes = imfill(BW,'holes');
    holes = 1-holes;
    InnerWhite = WB - holes;
    WBcanny = edge(InnerWhite,'canny');
    [C2] = CornerDetec(WBcanny);
    plot(C2([1:4 1],1),C2([1:4 1],2),'g','LineWidth',5,'MarkerSize',5);
    plot(C2([1:4 1],1),C2([1:4 1],2),'r*','LineWidth',5,'MarkerSize',5);
end

plot(stat(centroid_Number).Centroid(1),stat(centroid_Number).Centroid(2),'yx'...
    ,'MarkerSize',20,'LineWidth',5);


%% Hough Transform

%close all

BWcanny = bwmorph(BWcanny,'bridge',100);

[H, theta, rho] = hough(BWcanny);
numpeaks = 200;
peaks = houghpeaks(H,numpeaks,'threshold',20);
lines = houghlines(BWcanny, theta, rho, peaks,'FillGap',20,'MinLength',0.01);

%imshow(img), hold on
max_len = 0;

figure (7)
subplot(1,2,1)
imshow(BWcanny)
hold on
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','red');
end

subplot(1,2,2)
imshow(img)
hold on
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','red');
end
title('Original image')



%% Gate Image Enhancement

segWB = img.*uint8(WB);
rgbImage = segWB;
% Extract the individual red, green, and blue color channels.
redChannel = rgbImage(:, :, 1);
greenChannel = rgbImage(:, :, 2);
blueChannel = rgbImage(:, :, 3);
% Find pixels that are pure black - black in all 3 channels.
blackPixels = redChannel == 0 & greenChannel  == 0 & blueChannel  == 0;

redChannel(blackPixels) = 255;
greenChannel(blackPixels) = 0;
blueChannel(blackPixels) = 255;
% Recombine separate color channels into a single, true color RGB image.
rgbImage = cat(3, redChannel, greenChannel, blueChannel);

figure (8)
imshow(rgbImage)
hold on
plot(C([1:4 1],1),C([1:4 1],2),'g','LineWidth',5,'MarkerSize',5);

if size(struct2table(stat),1) == 2
    plot(C2([1:4 1],1),C2([1:4 1],2),'g','LineWidth',5,'MarkerSize',5);
end

