function shibieshuzi=ShiBieShuZi(shuzi,xiuzhengshuzi_1)
[y,x,z]=size(xiuzhengshuzi_1);
   
for k=1:10
sum=0;
for i=1:y
    for j=1:x
         if  shuzi(i,j,k)==xiuzhengshuzi_1(i,j)%Í³¼ÆºÚ°×
             sum=sum+1;
        end
    end
end
baifenbi(1,k)=sum/(x*y);
end
chepai= find(baifenbi>=max(baifenbi));
shibieshuzi=chepai-1;
shibieshuzi=num2str(shibieshuzi);