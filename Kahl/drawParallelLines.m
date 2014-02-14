function [ img_lines, img_paral, R1R2T_paral ] = drawParallelLines( edgels, colour )
%DRAWPARALLELLINES Summary of this function goes here
%   Detailed explanation goes here

img_lines = zeros([size(edgels) 3]);
img_paral = zeros([size(edgels) 3]);
R1R2T_paral = [];

%% Red Lines
[H, T, R] = hough(edgels);
%peaks = houghpeaks(H, 25, 'NHoodSize', [1 1]);
%peaks = houghpeaks(H, 15, 'Threshold', 0.4*max(H(:)));
peaks = houghpeaks(H, 15);
T_peaks = T(peaks(:,2));
R_peaks = R(peaks(:,1));
isParallel = zeros(size(T_peaks));

for a = 1:numel(T_peaks)
    if isParallel(a) == 0
        for b = a+1:numel(T_peaks)
            if abs(T_peaks(a) - T_peaks(b)) < 2 && ...
               abs(R_peaks(a) - R_peaks(b)) > 10 && ...
               abs(R_peaks(a) - R_peaks(b)) < 40
                isParallel(a) = 1;
                isParallel(b) = 1;
                R1R2T_paral = [R1R2T_paral;
                               R_peaks(a) R_peaks(b) (T_peaks(a)+T_peaks(b))/2];
            end
        end
    end
end

for a = 1:numel(T_peaks)
    T_a = T_peaks(a);
    R_a = R_peaks(a);
    for c = 1:size(img_lines,2)
        r = round((R_a - c*cosd(T_a))/sind(T_a));
        if r > 0 && r < size(img_lines,1)
            img_lines(r,c,1) = colour(1);
            img_lines(r,c,2) = colour(2);
            img_lines(r,c,3) = colour(3);
            if isParallel(a) == 1
                img_paral(r,c,1) = colour(1);
                img_paral(r,c,2) = colour(2);
                img_paral(r,c,3) = colour(3);
            end
        end
    end
    for r = 1:size(img_lines,1)
        c = round((R_a - r*sind(T_a))/cosd(T_a));
        if c > 0 && c < size(img_lines,2)
            img_lines(r,c,1) = colour(1);
            img_lines(r,c,2) = colour(2);
            img_lines(r,c,3) = colour(3);
            if isParallel(a) == 1
                img_paral(r,c,1) = colour(1);
                img_paral(r,c,2) = colour(2);
                img_paral(r,c,3) = colour(3);
            end
        end
    end
end

% imshow(imadjust(mat2gray(H)),'XData',T,'YData',R,...
%       'InitialMagnification','fit');
% title('Hough Transform of Image');
% xlabel('\theta'), ylabel('\rho');
% axis on, axis normal, hold on;
% colormap(hot);

end

