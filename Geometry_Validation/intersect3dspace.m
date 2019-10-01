clc; clear all; close all;
cord=zeros(8,3);
global inter;
inter=0;

for i = 1:8
    cord(i,:)=randi(32,1,3);
end
for j =1:6
    t=7-j;
for k=1:t
d3intersect(cord(k,:),cord(k+1,:),cord(k+1+6-(7-j),:),cord(k+1+6-(7-j)+1,:),j);
if(inter==1)
    fprintf("intersection");
    break;
end
end
if(inter==1)
    fprintf("intersection");
    break;
end
end
fprintf("no intersection\n")   ; 
%d3intersect(cord(i,:),cord(i+1,:),cord(i+1+6-j,:),cord(i+1+6-j+1,:),j);    