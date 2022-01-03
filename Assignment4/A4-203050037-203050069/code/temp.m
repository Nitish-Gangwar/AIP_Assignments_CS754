tic;
I = zeros(100, 100);
I(50:70, 50:70) = 255;
imshow(I);

flat_I = reshape(I,[],1);
for i = 1:100
    for j = 1:100
    flat_I((j-1)*100 + (i)) = I(i,j);
    end
end
recon_I = zeros(100, 100);

for i = 1:100*100
     temp_i = i-fix((i-1)/100)*100;
    temp_j = fix(i/100)+1;
    recon_I(temp_i,temp_j) = flat_I(i);
end
figure;
imshow(recon_I);
% D = compute_dct(100*100);
% coffts = D'*flat_I;
% coffts_reshape = reshape(coffts, 100, 100);
% 
% figure;
% imshow(coffts_reshape);



toc;