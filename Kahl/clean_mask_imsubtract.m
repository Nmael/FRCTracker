function [ cleaned ] = clean_mask_imsubtract( mask )
%CLEAN_MASK Summary of this function goes here
%   Detailed explanation goes here

% Max number of pixels to be counted as a region
% MIN_PIXEL_COUNT = numel(mask)/500;
MIN_PIXEL_COUNT = 100;

cleaned = mask;
labeled_mask = bwlabel(mask);

for a = 1:max(labeled_mask(:))
    [r,c] = find(labeled_mask == a);
    if numel(r) < MIN_PIXEL_COUNT;
        cleaned(r,c) = 0;
    end
end

converged = 0;

while converged == 0
    labeled_mask2 = bwlabel(cleaned);
    num_regions = max(labeled_mask2(:));
    mean_region_size = sum(cleaned(:))/num_regions;
    converged = 1;
    for a = 1:num_regions
        [r,c] = find(labeled_mask2 == a);
        if numel(r) < mean_region_size/2;
            cleaned(r,c) = 0;
            converged = 0;
        end
    end
end

end