function [ R1, C1, R2, C2, boxed_Image_Obj ] = bounding_box( mask, Image_Obj )
%BOUNDING_BOX Summary of this function goes here
%   Detailed explanation goes here

labeled_mask = bwlabel(mask);
R1 = [];
C1 = [];
R2 = [];
C2 = [];

box_mask = zeros(size(mask));

for a = 1:max(labeled_mask(:))
    [r,c] = find(labeled_mask == a);
    r1 = min(r);
    c1 = min(c);
    r2 = max(r);
    c2 = max(c);
    R1 = [R1; r1];
    C1 = [C1; c1];
    R2 = [R2; r2];
    C2 = [C2; c2];
    box_mask(r1:r2,c1:c2) = 1;
end

boxed_img = Image_Obj.img;
boxed_img(:,:,1) = boxed_img(:,:,1) .* box_mask;
boxed_img(:,:,2) = boxed_img(:,:,2) .* box_mask;
boxed_img(:,:,3) = boxed_img(:,:,3) .* box_mask;

boxed_Image_Obj = Image(boxed_img);

end

