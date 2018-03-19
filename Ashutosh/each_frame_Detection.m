clear all
clc
%Detect objects using Viola-Jones Algorithm

%To detect Face
FDetect = vision.CascadeObjectDetector;

%Read the input image
vidDevice = imaq.VideoDevice('winvideo', 1, 'YUY2_640x480','ROI', [1 1 640 480],'ReturnedColorSpace', 'rgb');
vidInfo = imaqhwinfo(vidDevice);
nFrame = 0
while(nFrame<20)
rgbFrame = step(vidDevice); % Acquire single frame
rgbFrame = flipdim(rgbFrame,2);
%Returns Bounding Box values based on number of objects
BB = step(FDetect,rgbFrame);

 figure,
 imshow(rgbFrame);
 hold on
for i = 1:size(BB,1)
    rectangle('Position',BB(i,:),'LineWidth',5,'LineStyle','-','EdgeColor','r');
end
title('Face Detection');
nFrame=nFrame+1;
end
hold off;