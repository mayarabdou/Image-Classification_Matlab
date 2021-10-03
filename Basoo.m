 c=cell(1,53);
 c_1=imread(sprintf('%d.bmp',1));
% % figure
% % imshow(c_1)
 %geyay scale  1
 im = rgb2gray(c_1);
% % figure
% % imshow(im)
 %contrast enhancement   2
 pout_imadjust = imadjust(im);
%  pout_histeq = histeq(im);
%  pout_adapthisteq = adapthisteq(im);
% % figure
% % imshow(pout_imadjust)
% %guassian filter   3
 Iblur1 = imgaussfilt(pout_imadjust,2);
 % figure
 % imshow(Iblur1)
 %threshold filter   4
 w=Iblur1<50;
% % figure
% % imshow(w)
% %oppening
 se=strel('disk',7);
 X=imopen(w,se);
% % figure
% % imshow(X)
% %dilate
 er=imdilate(X, se);
% % figure
% % imshow(er)
% %clear
 BWc1 = imclearborder(er,8);
% % figure
% % imshow(BWc1)
% 
% %Phase 2 
 stats=regionprops(BWc1,'MajorAxisLength','MinorAxisLength','Perimeter','Area','Eccentricity');
 Area= sum( [stats.Area] );
 MajorAxisLength=sum([stats.MajorAxisLength]);
 MinorAxisLength=sum([stats.MinorAxisLength]);
 Perimeter=sum([stats.Perimeter]);
 Eccentricity=sum([stats.Eccentricity]);
 T1 = table(Area,MajorAxisLength,MinorAxisLength,Perimeter,Eccentricity);
 T1.Label=repmat(char('Baso'),size(T,1),1);
 
%c=cell(1,53);
for i=2:53
c{i}=imread(sprintf('%d.bmp',i));
%gray scale  1
im = rgb2gray(c{i});
%contrast enhancement   2
pout_imadjust = imadjust(im);
% pout_histeq = histeq(im);
% pout_adapthisteq = adapthisteq(im);
%guassian filter   3
Iblur1 = imgaussfilt(pout_imadjust,2);
%threshold filter   4
w=Iblur1<50;
%oppening
se=strel('disk',7);
X=imopen(w,se);
er=imdilate(X, se);
BWc1 = imclearborder(er,8);

%  figure
%  imshow(er);
%Phase 2 
stats=regionprops(BWc1,'MajorAxisLength','MinorAxisLength','Perimeter','Area','Eccentricity');
Area= sum( [stats.Area] );
MajorAxisLength=sum([stats.MajorAxisLength]);
MinorAxisLength=sum([stats.MinorAxisLength]);
Perimeter=sum([stats.Perimeter]);
Eccentricity=sum([stats.Eccentricity]);
newRow = {Area,MajorAxisLength,MinorAxisLength,Perimeter,Eccentricity, repmat(char('Baso'),size(T,1),1)};
C1=vertcat(T1);
T1 = [T1;newRow];

end
T1

