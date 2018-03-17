clear all
close all
clc
webcam_gettingstarted
x=img;
imshow(x);
clear cam
if size(x,3)>1
    y=rgb2gray(x);
end
b=histeq(y);
imshow(b);
b=double(b);
[output,count,m,svec]=facefind(b);
imshow(x)
col=[1,0,0];
col=[0,1,0];
t=2;
N=size(output,2);
if N>0
    for i=1:1:N
        x1=output(1,i);
        x2=output(2,i);
        y1=output(3,i);
        y2=output(4,i);
        vec=[x1 x2 y1 y2];
        ind=find(isinf(vec));
        a=200;
        vec(ind)=sign(vec(ind))*a;
        
        h1=line([vec(1) vec(2),vec(3) vec(3)]);
        h2=line([vec(2) vec(2),vec(3) vec(4)]);
        h3=line([vec(1) vec(2),vec(4) vec(4)]);
        h4=line([vec(1) vec(1),vec(3) vec(4)]);
        
        h=[h1 h2 h3 h4];
        set(h,'color',col);
        set(h,'LineWidth',t);
        
        a=abs(vec(1)-vec(2));
        b=abs(vec(3)-vec(4));
        c1=vec(1)-a/9;
        c2=5*a/4;
        d1=vec(3)-b/3;
        d2=17*b/12;
        xRect=imcrop(x,[c1 d1 c2 d2]);
        imshow(xRect);
        imwrite(xguiyi1,x);
        xguiyi=imresize(xRect,[112,92]);
        imshow(xguiyi);
        imwrite(xguiyi1,x);
    end
end
        
        
        
        
        
        
        
        