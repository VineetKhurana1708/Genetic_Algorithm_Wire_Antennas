%Data will be stored in cell array C  after running this  

clc 
clear all

filename = 'buffer';
input_vec= [0 0 0 -0.1 0 20 ;-0.1 0 20 1 0 20;1 0 20 16 0 50]; % Format is [x1,y1,z1,x2,y2,z2]in one row . Resembles inp file format

fid= fopen(strcat(filename,'.inp'),'w'); 


formatSpec = "CM Ex card is correct, errors can be bugs \r\nCE \r\nGW 1 20 %d %d %d %d %d %d  1.02e-3\r\nGW 2 1 %d %d %d %d %d %d  1.02e-3\r\nGW 3 20 %d %d %d %d %d %d  1.02e-3\r\nGE 1\r\nGN 1 0\r\nEX 0 1 1 0 1 0\r\nFR 0 1 0 0 3.68 0\r\nRP 0 19 73 1003 -90 0 5 5 ";



str = sprintf(formatSpec,input_vec(1,:),input_vec(2,:),input_vec(3,:));

fprintf(fid,str);
fclose(fid);



system(strcat('nec2++ -i ',strcat(filename,'.inp'))); % USes arg filename to call NEC .For example , system('nec2++ -i buff.inp')


fid=-1;% Sometimes MATLAB was unable to open this file when called after NEC , maybe because NEC hadnt finished processing the output yet . Hence this loop
while(fid==-1)
fid=fopen(strcat(filename,'.out'));
%pause(2);
end


skip=0;
pattern = "RADIATION PATTERNS";


 while(1)
 line_ex = fgetl(fid);
 
 if(contains(line_ex,pattern))
  break;   
 end
 skip=skip+1;
 end
 
 
 Imported_Data = textscan(fid,'%f %f %f %f %f %f %f %s %f %f %f %f','headerlines',3);%data starts after 3 field after Radiation pattern string appears
 
 
for i= 1:1:length(Imported_Data{1})%This post processsing is taking most of the time in the program , optimise this 
buff=isnan(str2double(Imported_Data{8}(i)));
if(buff==0)
Imported_Data{12}(i)=Imported_Data{11}(i);
Imported_Data{11}(i)=Imported_Data{10}(i);
Imported_Data{10}(i)=Imported_Data{9}(i);
Imported_Data{9}(i)=str2double(Imported_Data{8}(i));
Imported_Data{8}(i)=cellstr(" ");
end
end


fclose(fid);
