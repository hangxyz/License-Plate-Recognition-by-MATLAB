function ZiMu = DuQuZiMu(s10,s11,s12,s13,s14,s15,s16,s17,s18,s19,...
                         s20,s21,s22,s23,s24,s25,s26,s27,s28,s29,...
                         s30,s31,s32,s33)
             
%1-5 ABCDE 6-10FGHJK 11-15 LMNPQ 16-20 RSTUV 21-24 WXYZ
ZiMu(:,:,1)   =imresize(im2bw(s10,graythresh(rgb2gray(s10))),[110 55],'bilinear');
ZiMu(:,:,2)   =imresize(im2bw(s11,graythresh(rgb2gray(s11))),[110 55],'bilinear');
ZiMu(:,:,3)   =imresize(im2bw(s12,graythresh(rgb2gray(s12))),[110 55],'bilinear');
ZiMu(:,:,4)   =imresize(im2bw(s13,graythresh(rgb2gray(s13))),[110 55],'bilinear');
ZiMu(:,:,5)   =imresize(im2bw(s14,graythresh(rgb2gray(s14))),[110 55],'bilinear');
ZiMu(:,:,6)   =imresize(im2bw(s15,graythresh(rgb2gray(s15))),[110 55],'bilinear');
ZiMu(:,:,7)   =imresize(im2bw(s16,graythresh(rgb2gray(s16))),[110 55],'bilinear');
ZiMu(:,:,8)   =imresize(im2bw(s17,graythresh(rgb2gray(s17))),[110 55],'bilinear');
ZiMu(:,:,9)   =imresize(im2bw(s18,graythresh(rgb2gray(s18))),[110 55],'bilinear');
ZiMu(:,:,10)  =imresize(im2bw(s19,graythresh(rgb2gray(s19))),[110 55],'bilinear');
ZiMu(:,:,11)  =imresize(im2bw(s20,graythresh(rgb2gray(s20))),[110 55],'bilinear');
ZiMu(:,:,12)  =imresize(im2bw(s21,graythresh(rgb2gray(s21))),[110 55],'bilinear');
ZiMu(:,:,13)  =imresize(im2bw(s22,graythresh(rgb2gray(s22))),[110 55],'bilinear');
ZiMu(:,:,14)  =imresize(im2bw(s23,graythresh(rgb2gray(s23))),[110 55],'bilinear');
ZiMu(:,:,15)  =imresize(im2bw(s24,graythresh(rgb2gray(s24))),[110 55],'bilinear');
ZiMu(:,:,16)  =imresize(im2bw(s25,graythresh(rgb2gray(s25))),[110 55],'bilinear');
ZiMu(:,:,17)  =imresize(im2bw(s26,graythresh(rgb2gray(s26))),[110 55],'bilinear');
ZiMu(:,:,18)  =imresize(im2bw(s27,graythresh(rgb2gray(s27))),[110 55],'bilinear');
ZiMu(:,:,19)  =imresize(im2bw(s28,graythresh(rgb2gray(s28))),[110 55],'bilinear');
ZiMu(:,:,20)  =imresize(im2bw(s29,graythresh(rgb2gray(s29))),[110 55],'bilinear');
ZiMu(:,:,21)  =imresize(im2bw(s30,graythresh(rgb2gray(s30))),[110 55],'bilinear');
ZiMu(:,:,22)  =imresize(im2bw(s31,graythresh(rgb2gray(s31))),[110 55],'bilinear');
ZiMu(:,:,23)  =imresize(im2bw(s32,graythresh(rgb2gray(s32))),[110 55],'bilinear');
ZiMu(:,:,24)  =imresize(im2bw(s33,graythresh(rgb2gray(s33))),[110 55],'bilinear');

