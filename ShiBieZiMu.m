function shibiezimu=ShiBieZiMu(zimu,xiuzhengzimu);
[y,x,z]=size(xiuzhengzimu);
for k=1:24
sum=0;
for i=1:y
    for j=1:x
         if  zimu(i,j,k)==xiuzhengzimu(i,j)%统计黑白
             sum=sum+1;
        end
    end
end
baifenbi(1,k)=sum/(x*y);
end
chepai= find(baifenbi>=max(baifenbi));
shibiezimu=chepai;%在数字中，从0开始所以要减一。这里不用
if         shibiezimu==1
        shibiezimu='A';
    elseif shibiezimu==2
        shibiezimu='B';
    elseif shibiezimu==3
        shibiezimu='C';
    elseif shibiezimu==4
        shibiezimu='D';
    elseif shibiezimu==5
        shibiezimu='E';
    elseif shibiezimu==6
        shibiezimu='F';
    elseif shibiezimu==7
        shibiezimu='G';
    elseif shibiezimu==8
        shibiezimu='H';
    elseif shibiezimu==9
        shibiezimu='J';
    elseif shibiezimu==10
        shibiezimu='K';
    elseif shibiezimu==11
        shibiezimu='L';
    elseif shibiezimu==12
        shibiezimu='M';
    elseif shibiezimu==13
        shibiezimu='N';
    elseif shibiezimu==14
        shibiezimu='P';
    elseif shibiezimu==15
        shibiezimu='Q';
    elseif shibiezimu==16
        shibiezimu='R';
    elseif shibiezimu==17
        shibiezimu='S';
    elseif shibiezimu==18
        shibiezimu='T';
    elseif shibiezimu==19
        shibiezimu='U';
    elseif shibiezimu==20
        shibiezimu='V';
    elseif shibiezimu==21
        shibiezimu='W';
    elseif shibiezimu==22
        shibiezimu='X';
    elseif shibiezimu==23
        shibiezimu='Y';
    elseif shibiezimu==24
        shibiezimu='Z';
    end