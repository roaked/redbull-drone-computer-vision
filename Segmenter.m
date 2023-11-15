function [seg,BW] = Segmenter(img)

imgHSV = rgb2hsv(img);

hue = imgHSV(:,:,1);
sat = imgHSV(:,:,2);
val = imgHSV(:,:,3);

[counts,binLocations] = imhist(hue);
a = 0;
b = 0;
for i = 1:256
    a = a + binLocations(i)*counts(i);
    b = b + counts(i);
end
c = a/b;
[~,I] = max(counts);
I = I/256;

if c <= 0.15 %caso imagem 0345
    BW = hue >= 0.50 & hue <= 0.60 ...
        | hue >= 0.8 & hue <= 0.990 & val < 0.7 & sat > 0.3 ... 
        | val > 0.9 & sat > 0.8;
    
    BW = imdilate(BW,strel('cube',8));
    BW = bwareafilt(BW,[5000 9999999999]);
    BW = imclose(BW,strel('cube',80));
    BW = imopen(BW,strel('cube',30));
    
elseif 0.15 < c && c <= 0.1913 %caso imagem 1130
    BW = hue >= 0.61 & hue <= 0.65 & sat>=0.30... 
   | hue >= 0.62 & hue <= 0.68 & sat>=0.08 & val > 0.20...
   | hue > 0.68 & hue <= 0.72 & sat < 0.2 ...
   | hue >= 0.0 & hue <= 0.2 & sat<=0.18 & val > 0.55;...
  
    BW = bwareafilt(BW,[5000 9999999999]);
    BW = imdilate(BW,strel('cube',5));
    BW = bwareafilt(BW,1);%

    BW = imclose(BW,strel('cube',80));
    BW = imopen(BW,strel('cube',20));
   

elseif 0.20 < c && c < 0.4 && I > 0.15 && I < 0.20 %imagem0268
    BW = hue >= 0.65 & hue <= 0.69 & sat>=0.4...
        | hue >= 0.61 & hue <= 0.65 & sat>=0.25 & val >= 0.9 ...
        | hue >= 0.64 & hue <= 0.65 & sat>=0.35 & val <= 0.9;
    
    BW = imdilate(BW,strel('cube',3));
    BW = bwareafilt(BW,[5000 9999999999]);
    BW = bwareafilt(BW,1);
    BW = imclose(BW,strel('cube',80));
    BW = imopen(BW,strel('cube',30));
    BW = imdilate(BW,strel('cube',5));

elseif 0.193 < c && c < 0.55
    BW = hue >= 0.64 & hue <= 0.85 & sat>=0.10 ...
        | hue >= 0.55 & hue <= 0.64 & sat >= 0.4...
        | hue >= 0.45 & hue <= 0.64 & val > 0.99 & sat < 0.4...
        | hue >= 0.68 & hue <= 0.80 & sat<=0.08 & val > 0.4 & val < 0.8;
        
    BW = imdilate(BW,strel('cube',2));

    BW = bwareafilt(BW,[5000 9999999999]);
    BW = bwareafilt(BW,1);

    BW = imclose(BW,strel('cube',80));
    BW = imopen(BW,strel('cube',20));
    BW = bwareafilt(BW,1);

elseif c >= 0.55 %caso imagem 0208 
    BW = sat >= 0.76;
    
    BW = bwareafilt(BW,[5000 9999999999]);
    BW = bwareafilt(BW,1);
    BW = imclose(BW,strel('cube',80));
    BW = imopen(BW,strel('cube',30));
    BW = imdilate(BW,strel('line',30,90));
    BW = imerode(BW,strel('cube',10));
end

seg = img.*uint8(BW);

end
