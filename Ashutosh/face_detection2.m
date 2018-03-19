clear all
clc
% Create a cascade detector object.
faceDetector = vision.CascadeObjectDetector();

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

% Read a video frame and run the face detector.
videoFileReader = vision.VideoFileReader('frames.avi');
videoFrame      = step(videoFileReader);
bbox            = step(faceDetector, videoFrame);

% Draw the returned bounding box around the detected face.
videoFrame = insertShape(videoFrame, 'Rectangle', bbox);
figure; imshow(videoFrame); title('Detected face');

% Convert the first box into a list of 4 points
% This is needed to be able to visualize the rotation of the object.
bboxPoints = bbox2points(bbox);