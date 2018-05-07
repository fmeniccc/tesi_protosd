clear all;
close all;
 
%%%%% GENERA FILE BINARIO DA VETTORE
% fileID = fopen('C:\Users\EAV\Desktop\read5.txt');
% in=textread('C:\Users\EAV\Desktop\read5.txt','%c');
% IN=str2num(in);
% databit=16;
% inbit=databit-1;
% IN=IN(databit+1:end);
% for i=1:28160-databit
%     a=(i-1)*databit+1;
%    INdec(i)=(2^inbit)*IN(a)+(2^(inbit-1))*IN(a+1)+(2^(inbit-2))*IN(a+2)+(2^(inbit-3))*IN(a+3)+(2^(inbit-4))*IN(a+4)+(2^(inbit-5))*IN(a+5)+(2^(inbit-6))*IN(a+6)+(2^(inbit-7))*IN(a+7)+(2^(inbit-8))*IN(a+8)+(2^(inbit-9))*IN(a+9)+(2^(inbit-10))*IN(a+10)+(2^(inbit-11))*IN(a+11)+(2^(inbit-12))*IN(a+12)+(2^(inbit-13))*IN(a+13)+(2^(inbit-14))*IN(a+14)+(2^(inbit-15))*IN(a+15); 
% end
%A=INdec;

%A=linspace(-500,500,1001);
%A=[1,2,3,4,5,6,7,8,9,1,3,5,3,6,7,7,4,2,1];
%A=randi(20,1,3000);
A=linspace(-20,20,41);
A=[A,fliplr(A),A,fliplr(A),A,fliplr(A),A,fliplr(A),A,fliplr(A),A,fliplr(A),A,fliplr(A),A,fliplr(A),A,fliplr(A),A,fliplr(A),A,fliplr(A),A,fliplr(A)];
A=[A,A,A,A,A,A,A,A,A,A];
La=length(A);
fileID = fopen('test_linear','w');

for k=1:La
 
    a= A(k);
    if (a<0)
        a=a+65536;
    end
    B=dec2bin(a, 16);
    for j=1:16
        b(j)=str2num(B(j));
    end
    for i=1:16
        fwrite(fileID,b(17-i),'ubit1');
    end
      
end
 
 
fclose(fileID);
 
 
id2=fopen('test_linear', 'r');
read23=fread(id2)';
fclose(id2);
