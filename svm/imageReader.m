clear all
clc

% Example of reading all the files in a given folder, e.g., TrainSunset. 
% For the sunset detector, you should keep the images in 4 separate folders: train and test 
% are separate, and the folder names tell you what the labels are (sunset = +1, non = -1) 
dirs = cell(6,1);
label = cell(6,1);
class = cell(6,1); % 0 = train; 1 = test

dirs{1} = 'images/TrainBumpers';
label{1} = 1;
class{1} = 0;
dirs{2} = 'images/TrainNonbumpers';
label{2} = -1;
class{2} = 0;

dirs{3} = 'images/TestBumpers';
label{3} = 1;
class{3} = 1;
dirs{4} = 'images/TestNonbumpers';
label{4} = -1;
class{4} = 1;
    
fileList = cell(size(dirs, 1),1);
for i = 1:size(dirs,1)
    fileList{i} = dir(dirs{i});
end

% files 1 and 2 are . (current dir) and .. (parent dir), respectively, 
% so we start with 3.
% X = [];
% Y = [];
% C = [];
% D = [];
% F = {};
% for i = 1:size(fileList, 1)
%     for j = 3:size(fileList{i})
%         fileLoc = [dirs{i}  '/'  fileList{i}(j).name];
%         img = imread(fileLoc);
%         fv = extractFeatureVector(img);
%         X = [X; fv];
%         Y = [Y; label{i}];
%         C = [C; class{i}];
%         D = [D; difficulty{i}];
%         F{size(F, 2) + 1} = fileLoc;
%     end
% end
% 
% save('features.mat', 'X', 'Y', 'C', 'F');