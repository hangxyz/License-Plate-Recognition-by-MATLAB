close all
clc
[fn,pn,fi]=uigetfile('ChePaiKu\*.jpg','选择图片');
YuanShi=imread([pn fn]);%输入原始图像
figure(1);subplot(3,2,1),imshow(YuanShi),title('原始图像');
%%%%%%%%%%1、图像预处理%%%%%%%%%%%
YuanShiHuiDu=rgb2gray(YuanShi);%转化为灰度图像
subplot(3,2,2),imshow(YuanShiHuiDu),title('灰度图像');

BianYuan=edge(YuanShiHuiDu,'canny',0.5);%Canny算子边缘检测
subplot(3,2,3),imshow(BianYuan),title('Canny算子边缘检测后图像');

se1=[1;1;1]; %线型结构元素 
FuShi=imerode(BianYuan,se1);    %腐蚀图像
subplot(3,2,4),imshow(FuShi),title('腐蚀后边缘图像');

se2=strel('rectangle',[25,25]); %矩形结构元素
TianChong=imclose(FuShi,se2);%图像聚类、填充图像
subplot(3,2,5),imshow(TianChong),title('填充后图像');

YuanShiLvBo=bwareaopen(TianChong,2000);%从对象中移除面积小于2000的小对象
figure(2);
subplot(2,2,1),imshow(YuanShiLvBo),title('形态滤波后图像');
%%%%%%%%%%2、车牌定位%%%%%%%%%%%
[y,x]=size(YuanShiLvBo);%size函数将数组的行数返回到第一个输出变量，将数组的列数返回到第二个输出变量
YuCuDingWei=double(YuanShiLvBo);
%%%%%%%%%%2.1、车牌粗定位之一确定行的起始位置和终止位置%%%%%%%%%%%
Y1=zeros(y,1);%产生y行1列全零数组
for i=1:y
    for j=1:x
        if(YuCuDingWei(i,j)==1)
            Y1(i,1)= Y1(i,1)+1;%白色像素点统计
        end
    end
end
[temp,MaxY]=max(Y1);%Y方向车牌区域确定。返回行向量temp和MaxY，temp向量记录Y1的每列的最大值，MaxY向量记录Y1每列最大值的行号
subplot(2,2,2),plot(0:y-1,Y1),title('原图行方向像素点值累计和'),xlabel('行值'),ylabel('像素'); 
PY1=MaxY;
while ((Y1(PY1,1)>=50)&&(PY1>1))
        PY1=PY1-1;
end
PY2=MaxY;
while ((Y1(PY2,1)>=50)&&(PY2<y))
        PY2=PY2+1;
end
IY=YuanShi(PY1:PY2,:,:);
%%%%%%%%%%2.2、车牌粗定位之二确定列的起始位置和终止位置%%%%%%%%%%%
X1=zeros(1,x);%产生1行x列全零数组
for j=1:x
    for i=PY1:PY2
        if(YuCuDingWei(i,j,1)==1)
                X1(1,j)= X1(1,j)+1;               
         end  
    end       
end
subplot(2,2,4),plot(0:x-1,X1),title('原图列方向像素点值累计和'),xlabel('列值'),ylabel('像数');
PX1=1;
while ((X1(1,PX1)<3)&&(PX1<x))
       PX1=PX1+1;
end    
PX3=x;
while ((X1(1,PX3)<3)&&(PX3>PX1))
        PX3=PX3-1;
end
CuDingWei=YuanShi(PY1:PY2,PX1:PX3,:);
subplot(2,2,3),imshow(CuDingWei),title('粗定位后的彩色车牌图像')
%%%%%%%%%%2.3、车牌精定位之一预处理%%%%%%%%%%%
CuDingWeiHuiDu=rgb2gray(CuDingWei); %将RGB图像转化为灰度图像
c_max=double(max(max(CuDingWeiHuiDu)));
c_min=double(min(min(CuDingWeiHuiDu)));
T=round(c_max-(c_max-c_min)/3); %T为二值化的阈值
CuDingWeiErZhi=im2bw(CuDingWeiHuiDu,T/256);
figure(3);
subplot(2,2,1),imshow(CuDingWeiErZhi),title('粗定位的二值车牌图像')%DingWei
%%%%%%%%%%2.4、车牌精定位之二去除边框干扰%%%%%%%%%%%
[r,s]=size(CuDingWeiErZhi);%size函数将数组的行数返回到第一个输出变量，将数组的列数返回到第二个输出变量
YuJingDingWei=double(CuDingWeiErZhi);%;CuDingWeiErZhi
X2=zeros(1,s);%产生1行s列全零数组
for i=1:r
    for j=1:s
        if(YuJingDingWei(i,j)==1)
            X2(1,j)= X2(1,j)+1;%白色像素点统计
        end
    end
end
[temp,MaxX]=max(X2);
subplot(2,2,2),plot(0:s-1,X2),title('粗定位车牌图像列方向像素点值累计和'),xlabel('列值'),ylabel('像素');
%%%%%%%%%%2.4.1、去除左侧边框干扰%%%%%%%%%%%
[g,h]=size(YuJingDingWei);
ZuoKuanDu=0;YouKuanDu=0;KuanDuYuZhi=5;
while sum(YuJingDingWei(:,ZuoKuanDu+1))~=0
    ZuoKuanDu=ZuoKuanDu+1;
end
if ZuoKuanDu<KuanDuYuZhi   % 认为是左侧干扰
    YuJingDingWei(:,[1:ZuoKuanDu])=0;%给图像d中1到KuanDu宽度间的点赋值为零
    YuJingDingWei=QieGe(YuJingDingWei); %值为零的点会被切割
end
subplot(2,2,3),imshow(YuJingDingWei),title('去除左侧边框的二值车牌图像')
%%%%%%%%%2.4.1、去除右侧边框干扰%%%%%%%%%%%
[e,f]=size(YuJingDingWei);%上一步裁剪了一次，所以需要再次获取图像大小
d=f;
while sum(YuJingDingWei(:,d-1))~=0
    YouKuanDu=YouKuanDu+1;
    d=d-1;
end
if YouKuanDu<KuanDuYuZhi   % 认为是右侧干扰
    YuJingDingWei(:,[(f-YouKuanDu):f])=0;%
    YuJingDingWei=QieGe(YuJingDingWei); %值为零的点会被切割
end
subplot(2,2,4),imshow(YuJingDingWei),title('精确定位的车牌二值图像')
% % % %%%%%%%%%%2.5、保存车牌图像%%%%%%%%%%%
% % % % imwrite(DingWei,'DingWei.jpg');
% % % % [filename,filepath]=uigetfile('DingWei.jpg','输入一个定位裁剪后的车牌图像');
% % % % jpg=strcat(filepath,filename);
% % % % DingWei=imread('DingWei.jpg');
% % % %%%%%%%%%%3、车牌字符分割%%%%%%%%%%%
% % % %%%%%%%%%%3.1、预处理%%%%%%%%%%%
% % % figure(4);
% % % % subplot(2,2,1),imshow(DingWei),title('车牌图像')
% % % % ChePaiHuiDu=rgb2gray(DingWei); %将RGB图像转化为灰度图像
% % % % subplot(2,2,2),imshow(ChePaiHuiDu),title('车牌灰度图像')
% % % % g_max=double(max(max(ChePaiHuiDu)));
% % % % g_min=double(min(min(ChePaiHuiDu)));
% % % % T=round(g_max-(g_max-g_min)/3); %T为二值化的阈值
% % % % [m,n]=size(ChePaiHuiDu);
% % % % % ChePaiErZhi=(double(ChePaiHuiDu)>=T); %车牌二值图像
% % % % ChePaiErZhi=im2bw(ChePaiHuiDu,T/256);
% % % % % im2bw:通过设定亮度将真彩等图像转换为二值图像，T/256为阈值，范围[0,1]
% % % % subplot(2,2,3),imshow(ChePaiErZhi),title('车牌二值图像')
ChePaiErZhi=YuJingDingWei;%logical()
ChePaiLvBo=bwareaopen(ChePaiErZhi,20);
subplot(1,2,1),imshow(ChePaiLvBo),title('形态学滤波后的车牌二值图像')
ChePaiYuFenGe=double(ChePaiLvBo);

[p,q]=size(ChePaiYuFenGe);
X3=zeros(1,q);%产生1行q列全零数组
for j=1:q
    for i=1:p
       if(ChePaiYuFenGe(i,j)==1) 
           X3(1,j)=X3(1,j)+1;
       end
    end
end
subplot(1,2,2),plot(0:q-1,X3),title('列方向像素点灰度值累计和'),xlabel('列值'),ylabel('累计像素量');
%%%%%%%%%%3.2、字符分割%%%%%%%%%%%p高q宽，倒序分割
Px0=q;%字符右侧限
Px1=q;%字符左侧限
for i=1:6
    while((X3(1,Px0)<3)&&(Px0>0))
       Px0=Px0-1;
    end
    Px1=Px0;
    while(((X3(1,Px1)>=3))&&(Px1>0)||((Px0-Px1)<15))
        Px1=Px1-1;
    end
    ChePaiFenGe=ChePaiLvBo(:,Px1:Px0,:);
    figure(6);subplot(1,7,8-i);imshow(ChePaiFenGe);
    ii=int2str(8-i);
    imwrite(ChePaiFenGe,strcat(ii,'.jpg'));%strcat连接字符串。保存字符图像。
    Px0=Px1;
end
%%%%%%%%%%对第一个字符进行特别处理%%%%%%%%%%%
PX3=Px1;%字符1右侧限
while((X3(1,PX3)<3)&&(PX3>0))
       PX3=PX3-1;
end
ZiFu1DingWei=ChePaiYuFenGe(:,1:PX3,:);
subplot(1,7,1);imshow(ZiFu1DingWei);
imwrite(ZiFu1DingWei,'1.jpg');
%%%%%%%%%%%4、车牌字符识别%%%%%%%%%%%
%%%%%%%%%%%4.1、车牌字符预处理%%%%%%%%%%%
ZiFu1=imresize(~imread('1.jpg'), [110 55],'bilinear');%用反色识别
ZiFu2=imresize(~imread('2.jpg'), [110 55],'bilinear');
ZiFu3=imresize(~imread('3.jpg'), [110 55],'bilinear');
ZiFu4=imresize(~imread('4.jpg'), [110 55],'bilinear');
ZiFu5=imresize(~imread('5.jpg'), [110 55],'bilinear');
ZiFu6=imresize(~imread('6.jpg'), [110 55],'bilinear');
ZiFu7=imresize(~imread('7.jpg'), [110 55],'bilinear');
%%%%%%%%%%%4.2、把0-9,A-Z以及省份简称的数据存储方便访问%%%%%%%%%%%
HanZi=DuQuHanZi(imread('MuBanKu\sichuan.bmp'),imread('MuBanKu\guizhou.bmp'),imread('MuBanKu\beijing.bmp'),imread('MuBanKu\chongqing.bmp'),...
                imread('MuBanKu\guangdong.bmp'),imread('MuBanKu\shandong.bmp'),imread('MuBanKu\zhejiang.bmp'));
ShuZiZiMu=DuQuSZZM(imread('MuBanKu\0.bmp'),imread('MuBanKu\1.bmp'),imread('MuBanKu\2.bmp'),imread('MuBanKu\3.bmp'),imread('MuBanKu\4.bmp'),...
                   imread('MuBanKu\5.bmp'),imread('MuBanKu\6.bmp'),imread('MuBanKu\7.bmp'),imread('MuBanKu\8.bmp'),imread('MuBanKu\9.bmp'),...
                   imread('MuBanKu\10.bmp'),imread('MuBanKu\11.bmp'),imread('MuBanKu\12.bmp'),imread('MuBanKu\13.bmp'),imread('MuBanKu\14.bmp'),...
                   imread('MuBanKu\15.bmp'),imread('MuBanKu\16.bmp'),imread('MuBanKu\17.bmp'),imread('MuBanKu\18.bmp'),imread('MuBanKu\19.bmp'),...
                   imread('MuBanKu\20.bmp'),imread('MuBanKu\21.bmp'),imread('MuBanKu\22.bmp'),imread('MuBanKu\23.bmp'),imread('MuBanKu\24.bmp'),...
                   imread('MuBanKu\25.bmp'),imread('MuBanKu\26.bmp'),imread('MuBanKu\27.bmp'),imread('MuBanKu\28.bmp'),imread('MuBanKu\29.bmp'),...
                   imread('MuBanKu\30.bmp'),imread('MuBanKu\31.bmp'),imread('MuBanKu\32.bmp'),imread('MuBanKu\33.bmp'));
ZiMu=DuQuZiMu(imread('MuBanKu\10.bmp'),imread('MuBanKu\11.bmp'),imread('MuBanKu\12.bmp'),imread('MuBanKu\13.bmp'),imread('MuBanKu\14.bmp'),...
              imread('MuBanKu\15.bmp'),imread('MuBanKu\16.bmp'),imread('MuBanKu\17.bmp'),imread('MuBanKu\18.bmp'),imread('MuBanKu\19.bmp'),...
              imread('MuBanKu\20.bmp'),imread('MuBanKu\21.bmp'),imread('MuBanKu\22.bmp'),imread('MuBanKu\23.bmp'),imread('MuBanKu\24.bmp'),...
              imread('MuBanKu\25.bmp'),imread('MuBanKu\26.bmp'),imread('MuBanKu\27.bmp'),imread('MuBanKu\28.bmp'),imread('MuBanKu\29.bmp'),...
              imread('MuBanKu\30.bmp'),imread('MuBanKu\31.bmp'),imread('MuBanKu\32.bmp'),imread('MuBanKu\33.bmp'));
ShuZi=DuQuShuZi(imread('MuBanKu\0.bmp'),imread('MuBanKu\1.bmp'),imread('MuBanKu\2.bmp'),imread('MuBanKu\3.bmp'),imread('MuBanKu\4.bmp'),...
                imread('MuBanKu\5.bmp'),imread('MuBanKu\6.bmp'),imread('MuBanKu\7.bmp'),imread('MuBanKu\8.bmp'),imread('MuBanKu\9.bmp')); 
%%%%%%%%%%%4.3、车牌字符识别%%%%%%%%%%%
t=1;
ZiFu1JieGuo=ShiBieHanZi(HanZi,ZiFu1);   ShiBieJieGuo(1,t)=ZiFu1JieGuo;t=t+1;
ZiFu2JieGuo=ShiBieZiMu (ZiMu, ZiFu2);   ShiBieJieGuo(1,t)=ZiFu2JieGuo;t=t+1;
ZiFu3JieGuo=ShiBieSZZM(ShuZiZiMu,ZiFu3);ShiBieJieGuo(1,t)=ZiFu3JieGuo;t=t+1;
ZiFu4JieGuo=ShiBieSZZM(ShuZiZiMu,ZiFu4);ShiBieJieGuo(1,t)=ZiFu4JieGuo;t=t+1;
ZiFu5JieGuo=ShiBieShuZi(ShuZi,ZiFu5);   ShiBieJieGuo(1,t)=ZiFu5JieGuo;t=t+1;
ZiFu6JieGuo=ShiBieShuZi(ShuZi,ZiFu6);   ShiBieJieGuo(1,t)=ZiFu6JieGuo;t=t+1;
ZiFu7JieGuo=ShiBieShuZi(ShuZi,ZiFu7);   ShiBieJieGuo(1,t)=ZiFu7JieGuo;t=t+1;
ShiBieJieGuo
msgbox(ShiBieJieGuo,'结果');
fid=fopen('Data.xls','a+');
fprintf(fid,'%s\r\n',ShiBieJieGuo,datestr(now));
fclose(fid);


