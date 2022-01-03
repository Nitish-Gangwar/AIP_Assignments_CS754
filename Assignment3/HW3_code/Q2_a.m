
No_of_angles=18;

image=imread('./slice_50.png');
image_mod = im2double(pad_image(image));
theta=180*rand(No_of_angles,1);
R = radon(image_mod, theta);
[length, width] = size(image_mod);

recon_image = iradon(R, theta,'linear','Ram-Lak', 1.0, length);

imshow(recon_image);