function ShuZi=DuQuShuZi(s0,s1,s2,s3,s4,s5,s6,s7,s8,s9)
%=======================²ÊÉ«×ª»Ò¶È============
ShuZi(:,:,1)   =imresize(im2bw(rgb2gray(s0),graythresh(rgb2gray(s0))),[110 55],'bilinear');
ShuZi(:,:,2)   =imresize(im2bw(rgb2gray(s1),graythresh(rgb2gray(s1))),[110 55],'bilinear');
ShuZi(:,:,3)   =imresize(im2bw(rgb2gray(s2),graythresh(rgb2gray(s2))),[110 55],'bilinear');
ShuZi(:,:,4)   =imresize(im2bw(rgb2gray(s3),graythresh(rgb2gray(s3))),[110 55],'bilinear');
ShuZi(:,:,5)   =imresize(im2bw(rgb2gray(s4),graythresh(rgb2gray(s4))),[110 55],'bilinear');
ShuZi(:,:,6)   =imresize(im2bw(rgb2gray(s5),graythresh(rgb2gray(s5))),[110 55],'bilinear');
ShuZi(:,:,7)   =imresize(im2bw(rgb2gray(s6),graythresh(rgb2gray(s6))),[110 55],'bilinear');
ShuZi(:,:,8)   =imresize(im2bw(rgb2gray(s7),graythresh(rgb2gray(s7))),[110 55],'bilinear');
ShuZi(:,:,9)   =imresize(im2bw(rgb2gray(s8),graythresh(rgb2gray(s8))),[110 55],'bilinear');
ShuZi(:,:,10)  =imresize(im2bw(rgb2gray(s9),graythresh(rgb2gray(s9))),[110 55],'bilinear');