%Author: Brandon Tippings

clear all; close all; clc
%The precision is determine by this command
digits(10000);
format longg

%%%%%%%%%%%%
%parameters%
%%%%%%%%%%%%
%lower and upper determine what points in the orbit will be plotted
%the initial condition starts at n=2
N=vpa(1);
lower=input('Input the lower for n>1: ');
upper=input('Input the upper for n: ');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%zeta%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
z=vpa(input('Input the value for the parameter zeta: '));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%g%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
g=vpa(input('Input the value for the parameter g>0: '));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%color coding%%%%%%%%%%%%%%%%%%%%%%%%%
c=input('Input 1 for color coded orbit (colored n mod 3): ');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Asymptotic Expansion%%%%%%%%%%%%%%%%%
expan=input('Input 1 for asymptotic expansion plot: ');



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%computes the initial condition%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
syms y
fun=exp(-N*((z/2 * y.^2)+ (g/4*y.^4)));
func=(y.^2).*exp(-N*(z/2 * y.^2+ g/4*y.^4));
funct=(y.^4).*exp(-N*(z/2 * y.^2+ g/4*y.^4));
mu0=vpaintegral(fun, 0,Inf, 'RelTol', 1e-307, 'AbsTol', 0, 'MaxFunctionCalls', Inf);
mu2=vpaintegral(func, 0,Inf, 'RelTol', 1e-307, 'AbsTol', 0, 'MaxFunctionCalls', Inf);
mu4=vpaintegral(funct, 0,Inf, 'RelTol', 1e-307, 'AbsTol', 0, 'MaxFunctionCalls', Inf);
inity=vpa(mu2/mu0);
initx=vpa((mu0*mu4-mu2^2)/(mu0*mu2));
%inity=vpa(-3);
%initx=vpa(1);
%plot(initx,inity,'b*','MarkerSize',15)


%%%%%%%%%%%%%%%%
%computes orbit%
%%%%%%%%%%%%%%%%
currentx=vpa(initx);
currenty=vpa(inity);

X=vpa(zeros(1,upper-lower+1));
Y=vpa(zeros(1,upper-lower+1));
if isequal(lower,2)
    X(1)=currentx;
    Y(1)=currenty;
end

a=vpa(-z/g);
b=vpa(1/(g*N));
n=upper; 


for k=2:n-1
    tempx=vpa(currentx);
    tempy=vpa(currenty);
    currentx=vpa(a+(b*k)/(tempx)-tempx-tempy);
    currenty=vpa(tempx);
    if k>(lower-2)
        X(k-lower+2)=currentx;
        Y(k-lower+2)=currenty;
          
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%plots orbit, color coded or not%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
if isequal(c,1)
   for k=1:upper-lower+1
        if isequal(mod(k,3),1)
            plot(X(k),Y(k), '.', 'MarkerSize',7+13*(k)/(upper-lower), 'Color',[0 0.9 0])            
        elseif isequal(mod(k,3),2)
            plot(X(k),Y(k), '.', 'MarkerSize',7+13*(k)/(upper-lower), 'Color',[1 0.9 0])
        else 
            plot(X(k),Y(k), '.', 'MarkerSize',7+13*(k)/(upper-lower), 'Color',[1 0 0])
        end
   end 
else
    for k=1:upper-lower+1
        plot(X(k),Y(k), '.', 'MarkerSize',7+13*(k)/(upper-lower), 'Color',[1 0 0])
     
        %change          ^  to '*' 
        % if you have points hiding behind the asymptotic expansion points   
        
        %text(X(k),Y(k),num2str(lower+k-1));
        %uncommenting the above line will plot n beside (x_n,y_n)
    
    end
end
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%computes and plots truncated asymptotic expansion%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isequal(expan,1)
   asymp=vpa(zeros(1,upper-lower+1));
   hold on
   for j=lower:upper
        s=vpa(-(j/N)*(g/4));
        z0=vpa((1-sqrt(1-48*s))/(24*s));
        z1=vpa((2*z0*(z0-1)^2)/(3*(2-z0)^4));
        z2=vpa(z0*(z0-1)*(56-294*z0+546*z0^2-434*z0^3+126*z0^4)/(9*(2-z0)^9));
        z3=(z0*(z0-1)*((-592/9)+(35344/27)*z0+(-182468/27)*z0^2+(444340/27)*z0^3+
        (-597400/27)*z0^4+(457976/27)*z0^5+(-188404/27)*z0^6+(10796/9)*z0^7))/(2-z0)^14; 
        asymp(j-lower+1)=vpa((j/N)*(z0+(z1/(j^2))+(z2/(j^4))+0*(z3/(j^6))));
        if  (j-lower)>0
            plot(asymp(j-lower+1),asymp(j-lower), '*', 'MarkerSize',10, 'Color',[0 1 0])
        end 
   end
end







