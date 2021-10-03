
c=cell(1,48);
c_1=imread(sprintf('%d.bmp',1));
%  figure
%  imshow(c_1);
%geyay scale  1
im = rgb2gray(c_1);
%  figure
%  imshow(im);
%contrast enhancement   2
pout_imadjust = imadjust(im);
pout_histeq = histeq(im);
pout_adapthisteq = adapthisteq(im);
%  figure
%  imshow(pout_imadjust);
%guassian filter   3
Iblur1 = imgaussfilt(pout_imadjust,2);
%  figure
%  imshow(Iblur1);
%threshold filter   4
w=Iblur1<50;
%  figure
%  imshow(w);
%oppening
se=strel('disk',2);
X=imopen(w,se);
%  figure
%  imshow(X);
%conn
CC = bwconncomp(X);
S = regionprops(CC, 'Area');
L = labelmatrix(CC);
BW2 = ismember(L, find([S.Area] >= 1600));

%   figure
%   imshow(BW2);

%  subplot(3,3,1), imshow(c_1), title ('original');
%  subplot(3,3,2), imshow(im), title ('gray');
%  subplot(3,3,3), imshow(pout_imadjust), title ('contrast');
%  subplot(3,3,4), imshow(Iblur1), title ('guassian');
%  subplot(3,3,5), imshow(w), title ('threshold');
%  subplot(3,3,6), imshow(X), title ('strech');
%  subplot(3,3,7), imshow(BW2), title ('Component connected');



%Phase 2 
stats=regionprops(BW2,'MajorAxisLength','MinorAxisLength','Perimeter','Area','Eccentricity');
Area= sum( [stats.Area] );
MajorAxisLength=sum([stats.MajorAxisLength]);
MinorAxisLength=sum([stats.MinorAxisLength]);
Perimeter=sum([stats.Perimeter]);
Eccentricity=sum([stats.Eccentricity]);
T4 = table(Area,MajorAxisLength,MinorAxisLength,Perimeter,Eccentricity);
T4.Label=repmat(char('Mono'),size(T,1),1);


for i=2:48
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
se=strel('disk',2);
X=imopen(w,se);
%
CC = bwconncomp(X);
S = regionprops(CC, 'Area');
L = labelmatrix(CC);
BW2 = ismember(L, find([S.Area] >= 1600));

%Phase 2 
stats=regionprops(BW2,'MajorAxisLength','MinorAxisLength','Perimeter','Area','Eccentricity');
Area= sum( [stats.Area] );
MajorAxisLength=sum([stats.MajorAxisLength]);
MinorAxisLength=sum([stats.MinorAxisLength]);
Perimeter=sum([stats.Perimeter]);
Eccentricity=sum([stats.Eccentricity]);
newRow = {Area,MajorAxisLength,MinorAxisLength,Perimeter,Eccentricity, repmat(char('Mono'),size(T,1),1)};
C4=vertcat(T1,T2,T3,T4);

T4 = [T4;newRow];

%end of phase 2
% 
% subplot(3,3,1), imshow(c{i}), title ('original');
% subplot(3,3,2), imshow(im), title ('gray');
% subplot(3,3,3), imshow(pout_imadjust), title ('contrast');
% subplot(3,3,4), imshow(Iblur1), title ('guassian');
% subplot(3,3,5), imshow(w), title ('threshold');
% subplot(3,3,6), imshow(X), title ('strech');
% subplot(3,3,7), imshow(BW2), title ('Component connected');


end
T4