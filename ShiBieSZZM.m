function shibiezm_sz=ShiBieSZZM(shuzizimu,xiuzhengzm_sz);
[y,x,z]=size(xiuzhengzm_sz);
   
for k=1:34
sum=0;
for i=1:y
    for j=1:x
         if  shuzizimu(i,j,k)==xiuzhengzm_sz(i,j)%统计黑白
             sum=sum+1;
        end
    end
end
baifenbi(1,k)=double(sum/(x*y));
end
chepai= find(baifenbi>=max(baifenbi));
chepai=chepai(1,1);
%===================数字直接返回=========================
if (chepai>=1)&&(chepai<=10)
       zm_sz=chepai-1;
       zm_sz=num2str(zm_sz);
elseif (chepai>=11)&&(chepai<=34)
   
%==================字母对应序号转字母====================
%=========11-15 ABCDE 16-20FGHIJ 21-25 KLMNP 26-30 QRSTU 31-35 VWXYZ
    if     chepai==11
         zm_sz='A';
    elseif chepai==12
         zm_sz='B';
    elseif chepai==13
         zm_sz='C';
    elseif chepai==14
         zm_sz='D';
    elseif chepai==15
         zm_sz='E';
    elseif chepai==16
         zm_sz='F';
    elseif chepai==17
         zm_sz='G';
    elseif chepai==18
         zm_sz='H';
    elseif chepai==19
         zm_sz='J';
    elseif chepai==20
         zm_sz='K';
    elseif chepai==21
         zm_sz='L';
    elseif chepai==22
         zm_sz='M';
    elseif chepai==23
         zm_sz='N';
    elseif chepai==24
         zm_sz='P';
    elseif chepai==25
         zm_sz='Q';
    elseif chepai==26
         zm_sz='R';
    elseif chepai==27
         zm_sz='S';
    elseif chepai==28
         zm_sz='T';
    elseif chepai==29
         zm_sz='U';
    elseif chepai==30
         zm_sz='V';
    elseif chepai==31
         zm_sz='W';
    elseif chepai==32
         zm_sz='X';
    elseif chepai==33
         zm_sz='Y';
    elseif chepai==34
         zm_sz='Z';        
    end
end
shibiezm_sz=zm_sz;
