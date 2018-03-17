webcam_gettingstarted
i=img;
clear cam
originimage=i;
imagemask=rgb2hsv(originimage);
[row column k]=size(imagemask);
h=imagemask(:,:,1);
s=imagemask(:,:,2);
v=imagemask(:,:,3);
for i=1:row
    for j=1:column
        if h(i,j)>0.1
            h(i,j)=0;
        else
            h(i,j)=1;
        end
    end
end
figure,imshow(h);
