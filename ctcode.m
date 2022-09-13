%Script to do CT reconstruction of ABS and DF

close all
clear
clc
%%

%Directory with data
dirstr='8_15 vialB';

%Processed ABS,DPC data
f_ABS=dir(strcat(dirstr,filesep,'Processed',filesep,'ABS',filesep,'ABS*.mat'));

angs=0:1:179; %Vector of angles which should be the same as the angles of projections
numfiles=size(angs,2);

%Slice through the y_ind slice of each image
y_ind=100;
xcent=99;
xwidth=xcent-1;
xwidth=90;
xmin=xcent-xwidth;
xmax=xcent+xwidth;
ABS_sinogram=zeros(length(xmin:xmax),numfiles);

%%

for j=1:length(y_ind)
tic;
    for i=1:numfiles
        %Load ABS
        load(strcat(f_ABS(i).folder,filesep,f_ABS(i).name))
        load(strcat(f_ABS(i).folder,filesep,f_ABS(i).name))

        ABS=-log(ABS(y_ind(j),xmin:xmax));
        ABS_sinogram(:,i)=ABS;    
    end
toc;

%%
%Commenting this out since we really only need to output a single slice

slice=iradon(ABS_sinogram,0:179,250); %Reconstruct

%Draw image of slice
figure(1);imagesc(slice);colormap gray; axis image;title(strcat('Slice ',int2str(j)));drawnow;
drawnow;

%Output file
% imout=strcat('slice',int2str(j),'.tif');
% imwrite(slice,imout);

end


    

