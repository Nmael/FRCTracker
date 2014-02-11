function [ cleaned ] = clean_mask( mask )
%CLEAN_MASK Summary of this function goes here
%   Detailed explanation goes here

% Max number of pixels to be counted as a region
MIN_PIXEL_COUNT = numel(mask)/500;

cleaned = mask;
labeled_mask = bwlabel(mask);

for a = 1:max(labeled_mask(:))
    [r,c] = find(labeled_mask == a);
    if numel(r) < MIN_PIXEL_COUNT;
        cleaned(r,c) = 0;
    end
end

end

