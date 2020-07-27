function showcolorhist(I,fig)
% function showcolorhist(I,fig)
% Visar separat histogram för R, G och B-kanalerna. Figurnummer kan anges,
% annars väljs defaultvärdet 27.
% Benny L., BTH, Aug 2016

if nargin==1 fig = 27;end % Gives possibility to specify figure number
    
r=imhist(I(:,:,1));
g=imhist(I(:,:,2));
b=imhist(I(:,:,3));
len=1:length(r);

figure(fig)
plot(len,r,'ro-',len,g,'go-',len,b,'bo-')
axis([1 length(r) 1 max([r;g;b])])
