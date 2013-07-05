function shibiehanzi=ShiBieHanZi(hanzi,xiuzhenghanzi);
[y,x,z]=size(xiuzhenghanzi);
for k=1:6
sum=0;
for i=1:y
    for j=1:x
         if  hanzi(i,j,k)==xiuzhenghanzi(i,j)%统计黑白
             sum=sum+1;
        end
    end
end
baifenbi(1,k)=sum/(x*y);
end
chepai= find(baifenbi>=max(baifenbi));
shibiehanzi=chepai;%在数字中，从0开始所以要减一。这里不用
if       shibiehanzi==1
         shibiehanzi='川';
    elseif shibiehanzi==2
         shibiehanzi='贵';
    elseif shibiehanzi==3
         shibiehanzi='京';
    elseif shibiehanzi==4
         shibiehanzi='渝';
    elseif shibiehanzi==5
         shibiehanzi='粤';
    elseif shibiehanzi==6
         shibiehanzi='鲁';
             elseif shibiehanzi==7
         shibiehanzi='浙';
end