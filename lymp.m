c=cell(1,52);
c_1=imread(sprintf('%d.bmp',1));
% figure
% imshow(c_1);
%geyay scale  1
im = rgb2gray(c_1);
% figure
% imshow(im);
%contrast enhancement   2
pout_imadjust = imadjust(im);
pout_histeq = histeq(im);
pout_adapthisteq = adapthisteq(im);
% figure
% imshow(pout_imadjust);
%guassian filter   3
Iblur1 = imgaussfilt(pout_imadjust,2);
% figure
% imshow(Iblur1);
%threshold filter   4
w=Iblur1<50;
% figure
% imshow(w);
%oppening   5
se=strel('disk',9);
X=imopen(w,se);
% figure
% imshow(X);
%conn    6
CC = bwconncomp(X);
S = regionprops(CC, 'Area');
L = labelmatrix(CC);
BW2 = ismember(L, find([S.Area] >= 1000));
% figure
% imshow(BW2);
%dilate      7
er=imdilate(BW2, se);
% figure
% imshow(er);

%  subplot(3,3,1), imshow(c_1), title ('original');
%  subplot(3,3,2), imshow(im), title ('gray');
%  subplot(3,3,3), imshow(pout_imadjust), title ('contrast');
%  subplot(3,3,4), imshow(Iblur1), title ('guassian');
%  subplot(3,3,5), imshow(w), title ('threshold');
%  subplot(3,3,6), imshow(X), title ('strech');
%  subplot(3,3,7), imshow(BW2), title ('Component connected');
%  subplot(3,3,8), imshow(BWc1), title ('Clear');
%  subplot(3,3,9), imshow(er), title ('Dilate');

%Phase 2 
stats=regionprops(er,'MajorAxisLength','MinorAxisLength','Perimeter','Area','Eccentricity');
Area= sum( [stats.Area] );
MajorAxisLength=sum([stats.MajorAxisLength]);
MinorAxisLength=sum([stats.MinorAxisLength]);
Perimeter=sum([stats.Perimeter]);
Eccentricity=sum([stats.Eccentricity]);
T3 = table(Area,MajorAxisLength,MinorAxisLength,Perimeter,Eccentricity);
T3.Label=repmat(char('Lymp'),size(T,1),1);








for i=2:52
c{i}=imread(sprintf('%d.bmp',i));
%geyay scale  1
im = rgb2gray(c{i});
%contrast enhancement   2
pout_imadjust = imadjust(im);
pout_histeq = histeq(im);
pout_adapthisteq = adapthisteq(im);
%guassian filter   3
Iblur1 = imgaussfilt(pout_imadjust,2);
%threshold filter   4
w=Iblur1<50;
%oppening
se=strel('disk',9);
X=imopen(w,se);
%
CC = bwconncomp(X);
S = regionprops(CC, 'Area');
L = labelmatrix(CC);
BW2 = ismember(L, find([S.Area] >= 1000));
%dilate
er=imdilate(BW2, se);

%Phase 2 
stats=regionprops(er,'MajorAxisLength','MinorAxisLength','Perimeter','Area','Eccentricity');
Area= sum( [stats.Area] );
MajorAxisLength=sum([stats.MajorAxisLength]);
MinorAxisLength=sum([stats.MinorAxisLength]);
Perimeter=sum([stats.Perimeter]);
Eccentricity=sum([stats.Eccentricity]);
newRow = {Area,MajorAxisLength,MinorAxisLength,Perimeter,Eccentricity, repmat(char('Lymp'),size(T,1),1)};
C3=vertcat(T1,T2,T3);

T3 = [T3;newRow];

% %end of phase 2
% %figure
% %imshow(er)
% subplot(3,3,1), imshow(c{i}), title ('original');
% subplot(3,3,2), imshow(im), title ('gray');
% subplot(3,3,3), imshow(pout_imadjust), title ('contrast');
% subplot(3,3,4), imshow(Iblur1), title ('guassian');
% subplot(3,3,5), imshow(w), title ('threshold');
% subplot(3,3,6), imshow(X), title ('strech');
% subplot(3,3,7), imshow(BW2), title ('Component connected');
% subplot(3,3,8), imshow(BWc1), title ('Clear');
% subplot(3,3,9), imshow(er), title ('Dilate');


end
T3