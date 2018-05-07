clear all;
close all;
 


%%%%%% read output from fpga
id2=fopen('C:\Users\fmeni\Desktop\prov', 'r');
read1=fread(id2, 'ubit1');
numbers=2904;
for k=1:numbers
 
  
 
    for i=1:16
        bitout(17-i)=read1(16*k+i-16);%16*k+i
        
        output(i,k)=bitout(i);
    end
    for j=1:16
        bitout_str(j)=num2str(bitout(j));
    end
    
  Au=bin2dec(bitout_str(2:16));
  %if (Au>32768)
%Au=Au-32768;
  %Au=bin2dec(Bu(2:16))-2^16;
%end
     %Au=bin2dec(Bu)
     
     a(k)= Au;
end
 plot(a)
 %plot(output(15,:))
 hold on
 fclose(id2);
 
 
%  
%  %%%%% read input file
%  id2=fopen('test1b', 'r');
% readin=fread(id2, 'ubit1');
%  
% for k=1:numbers-1
%  
%   
%  
%     for i=1:16
%         bitin(17-i)=readin(16*k+i-16);%16*k+i-16
%         
%         input(i,k)=bitin(i);
%     end
%     for j=1:16
%         bitin_str(j)=num2str(bitin(j));
%     end
%     
%   Zu=bin2dec(bitin_str(2:16));
%   %if (Au>32768)
% %Au=Au-32768;
%   %Au=bin2dec(Bu(2:16))-2^16;
% %end
%      %Au=bin2dec(Bu)
%      
%      z(k)= Zu;
% end
%  plot(z)
%  hold on
%  legend('output','input')
%  fclose(id2);
%  
%  
%  
%  
