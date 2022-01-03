
tic;
% Reading the image
image1=imread('./slice_53.png');
image2=imread('./slice_54.png');
image3=imread('./slice_55.png');
image_mod_1 = im2double(pad_image(image1));
image_mod_2 = im2double(pad_image(image2));
image_mod_3 = im2double(pad_image(image3));
[length, width] = size(image_mod_1);
theta_1 = randi([0 179],1,18);
theta_2 = randi([0 179],1,18);
theta_3 = randi([0 179],1,18);
theta_fin = cat(1,cat(1,theta_1, theta_2),theta_3);
R_1 = radon(image_mod_1, theta_1);
R_2 = radon(image_mod_2, theta_2);
R_3 = radon(image_mod_3, theta_3);
[p_length, p_width] = size(R_1);


m = 3*(p_length*p_width);
n = 3*(length*width);
y = cat(1,cat(1,reshape(R_1,[],1),reshape(R_2,[],1)),...
    reshape(R_3,[],1));
lambda = 0.1;
rel_tol = 0.01;

[x,status]=l1_ls(d_forward_model(length, theta_fin) ...
    , d_adjoint_model(length, theta_fin, R_1),m,n,y,lambda,...
    rel_tol, true);


temp_img = reshape(x, length, length, 3);
temp_img_1 = temp_img(:,:,1);
temp_img_2 = temp_img(:,:,2);
temp_img_3 = temp_img(:,:,3);
temp_img_2 = temp_img_1 + temp_img_2;
temp_img_3 = temp_img_1 + temp_img_3;

recon_image_1 = idct2(temp_img_1);
recon_image_2 = idct2(temp_img_2);

imshow(idct2(temp_img_1));
figure;
imshow(idct2(temp_img_2));
figure;
imshow(idct2(temp_img_3));

toc;