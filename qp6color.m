clear all; close all; clc

n = 5;
initial = [1,2,3];
vecxy = initial/initial(1);
vecty = initial/initial(2);
vectx = initial/initial(3);

xy0 = [vecxy(2),vecxy(3)];

a=2;

X=zeros(6);
Y=zeros(6);
%Note: This code plots an obrit, with indices colored mod 4. G->Y->B->R
hold on
plot([-1 5], [-1 5], '--');
p=a+a^(-1);

%xy chart
X(1)=xy0(1);
Y(1)=xy0(2);

hold on

plot(X(1),Y(1),'.','MarkerSize',20,'Color',[1 0 0]) 
text(X(1),Y(1),num2str(1),'FontSize',13);
for k=2:n
    X(k)=Y(k-1);
    Y(k)=(Y(k-1)-a)*(Y(k-1)-a^(-1))/(X(k-1)*(Y(k-1)+a)*(Y(k-1)+a^(-1)));
    plot(X(k),Y(k),'.', 'MarkerSize',7+13*(k)/5, 'Color',[1 0 0]);
    text(X(k),Y(k),num2str(k),'FontSize',13);
  
    
end


x=2;
y=3;

c=-18.75;
disp(c);
f=@(x,y) x^2*y^2+p*x^2*y+x^2+p*x*y^2+c*x*y-p*x+y^2-p*y+1;
fimplicit(f, [-5 5 -5 5], 'Color', c);



