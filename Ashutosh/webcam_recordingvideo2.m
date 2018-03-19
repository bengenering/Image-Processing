clear all
clc
vidWriter = VideoWriter('frames.avi');
open(vidWriter);
for index = 1:20
    % Acquire frame for processing
    img = snapshot(webcam);
    
    % Write frame to video
    writeVideo(vidWriter, img);
end
close(vidWriter);
clear cam
