% https://in.mathworks.com/help/images/ref/padarray.html#d123e227724

function padded_image = pad_image(image)
    padded_image = padarray(image,[18 0],0,'pre');
    padded_image = padarray(padded_image,[18 0],0,'post');
end