clear all; clc; imtool close all;

normalize = @(A) ( A - min(A(:)) ) ./ ( max(A(:)) - min(A(:)) );

foldername = 'QF2-1_5160-5240';
fileList = dir('QF2-1_5160-5240');

Images = Image.empty;
% files 1 and 2 are . (current dir) and .. (parent dir), respectively, 
% so we start with 3
for a = 3:size(fileList, 1)
    Images = [Images; Image(imread(['QF2-1_5160-5240'  '/'  fileList(a).name]))];
end

%f = 26; % Test Frame
w = 2; % Subtraction Width

centroids = [];

for f = (1 + w):(numel(Images) - w) % frame

    %imtool(Images(f).img);
    %imtool(abs(Images(f + w).img - Images(f - w).img));

    %subbed = normalize(abs(Images(f + w).S - Images(f - w).S));
    subbed_L = normalize(abs(Images(f + w).L - Images(f - w).L));
    subbed_S = normalize(abs(Images(f + w).S - Images(f - w).S));
    combo = normalize(0.5*subbed_L + subbed_S);

    mask = subbed_L > 0.15;
    %imtool(mask);

    q = imclose(mask, strel('disk', 2));
    %imtool(q);
    %q = mask;
    cleaned_mask = clean_mask(q);
    % imtool(cleaned_mask);

    % opened_mask = imopen(mask, strel('disk', 2));
    % imtool(opened_mask);
    % 
    connected_mask = imclose(cleaned_mask, strel('disk', 10));
    % imtool(connected_mask);

    [r1, c1, r2, c2, boxed_Image] = bounding_box(connected_mask, Images(f));
    % imtool(boxed_Image.img);
    
    for a = 1:numel(r1)
        centroids = [centroids; (r1(a)+r2(a))/2  (c1(a)+c2(a))/2  f];
    end
    
    imwrite(boxed_Image.img, ['boxed/' , int2str(f), '.jpg']);
    
end

save('centroids.mat', 'centroids');