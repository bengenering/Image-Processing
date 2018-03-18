clear all
clc
%Read the input image 
webcam_gettingstarted
I=img;
imshow(I);
%To detect Mouth
MouthDetect = vision.CascadeObjectDetector('Mouth','MergeThreshold',16);
BB=step(MouthDetect,I);
imshow(I);
hold on
for i = 1:size(BB,1)
 rectangle('Position',BB(i,:),'LineWidth',4,'LineStyle','-','EdgeColor','r');
end
%To detect Eyes
EyeDetect = vision.CascadeObjectDetector('EyePairBig');
BB=step(EyeDetect,I);
hold on
rectangle('Position',BB,'LineWidth',4,'LineStyle','-','EdgeColor','b');
