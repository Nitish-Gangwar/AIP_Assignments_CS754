function [code,coded_image] = convert_coded(image)
    code = randi([0,1],size(image));
    coded_image = image.*code;
end 