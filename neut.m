c=cell(1,50);
c_1=imread(sprintf('%d.bmp',1));
% figure
% imshow(c_1);
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
%  figure()
%  imshow(Iblur1);
%threshold filter   4
w=Iblur1<35;
%  figure
%  imshow(w)
%oppening
se=strel('disk',3);
X=imopen(w,se);
%  figure
%  imshow(X)
%comp conn
CC = bwconncomp(X);
S = regionprops(CC, 'Area');
L = labelmatrix(CC);
BW2 = ismember(L, find([S.Area] >= 300));
%  figure
%  imshow(BW2)
%clear
BWc1 = imclearborder(BW2,8);
% figure
% imshow(BWc1)



%Phase 2 
stats=regionprops(BWc1,'MajorAxisLength','MinorAxisLength','Perimeter','Area','Eccentricity');
Area= sum( [stats.Area] );
MajorAxisLength=sum([stats.MajorAxisLength]);
MinorAxisLength=sum([stats.MinorAxisLength]);
Perimeter=sum([stats.Perimeter]);
Eccentricity=sum([stats.Eccentricity]);
T5 = table(Area,MajorAxisLength,MinorAxisLength,Perimeter,Eccentricity);
T5.Label=repmat(char('Neut'),size(T,1),1);
%end of phase 1 first iteration

for i=2:50
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
w=Iblur1<35;
%oppening
se=strel('disk',3);
X=imopen(w,se);
%comp conn
CC = bwconncomp(X);
S = regionprops(CC, 'Area');
L = labelmatrix(CC);
BW2 = ismember(L, find([S.Area] >= 300));
%clear
BWc1 = imclearborder(BW2,8);


%Phase 2 
stats=regionprops(BWc1,'MajorAxisLength','MinorAxisLength','Perimeter','Area','Eccentricity');
Area= sum( [stats.Area] );
MajorAxisLength=sum([stats.MajorAxisLength]);
MinorAxisLength=sum([stats.MinorAxisLength]);
Perimeter=sum([stats.Perimeter]);
Eccentricity=sum([stats.Eccentricity]);
newRow = {Area,MajorAxisLength,MinorAxisLength,Perimeter,Eccentricity, repmat(char('Neut'),size(T,1),1)};
C5=vertcat(T1,T2,T3,T4,T5);

T5 = [T5;newRow];
% %end of phase 2
% subplot(3,3,1), imshow(c{i}), title ('original');
% subplot(3,3,2), imshow(im), title ('gray');
% subplot(3,3,3), imshow(pout_imadjust), title ('contrast');
% subplot(3,3,4), imshow(Iblur1), title ('guassian');
% subplot(3,3,5), imshow(w), title ('threshold');
% subplot(3,3,6), imshow(X), title ('strech');
% subplot(3,3,7), imshow(BW2), title ('Component connected');
% subplot(3,3,8), imshow(BWc1), title ('clear');
% subplot(3,3,9), imshow(er), title ('dilate');
end
T5