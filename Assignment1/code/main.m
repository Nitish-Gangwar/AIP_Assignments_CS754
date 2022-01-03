
% Set the required
noOfFrames=3;
epsilon=0.2;

% Reading frames from video
video=mmread('/home/nitish/Desktop/CS754_advance_IP/assignment1/cars.avi',1:10,[],false,true);
a=video.frames;

% Crop and convert patches into grayscale
codedFrames=cell(noOfFrames,1);
codeForFrames = cell(noOfFrames, 1);
for i=1:noOfFrames
    codedFrames{i} = rgb2gray(a(i).cdata);
    temp=double(codedFrames{i}(100:219,100:339));
%     temp=double(codedFrames{i});
    codedFrames{i} = temp./255.0;
end
[height, width] = size(codedFrames{i});
coded_image=double(zeros(height,width));
result=zeros(height,width);
frame_codes = [];

for i=1:noOfFrames
    [temp_coded,temp_coded_image]=convert_coded(codedFrames{i});
    frame_codes = cat(3,frame_codes,temp_coded);
    coded_image=coded_image+temp_coded_image;
    figure;
%     imshow(codedFrames{i});
    imshow(temp_coded_image);
    
    caption = sprintf('Frame No : %d ', i);
    title(caption);
    impixelinfo;
end
% Dividing my number of frames considered so that max value remains within
% 1.0
coded_image=(coded_image/noOfFrames);

figure;
imshow(coded_image);
title("Coded image");
impixelinfo;


reconstructed_frames = patch_generation(coded_image, frame_codes, epsilon);
disp(size(reconstructed_frames));

for i=1:noOfFrames
    figure;
    imshow(contrast_streching(reconstructed_frames(:,:,i)));
%https://in.mathworks.com/matlabcentral/answers/4064-rmse-root-mean-square-error
    caption = sprintf('Reconstructed Frame No : %d RMSE: %d', i, ...
                 sqrt(immse(codedFrames{i}, reconstructed_frames(:,:,i))));
    title(caption);
    impixelinfo;
end
  