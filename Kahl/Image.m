classdef Image
    %IMAGE Summary of this class goes here
    %   Detailed explanation goes here
    properties
        img
%         R
%         G
%         B
        L
        S
%         T
    end
    methods
        function this = Image(I)
            if isfloat(I)
                this.img = I;
            elseif isinteger(I)
                this.img = double(I) / 255;
            else
                error('InvalidInputError: Input image must be double or uint8');
            end
            R = this.img(:,:,1);
            G = this.img(:,:,2);
            B = this.img(:,:,3);
            this.L = R + G + B;
            this.S = R - B;
            %this.T = thisR - 2*thisG + thisB;
        end
    end
end

