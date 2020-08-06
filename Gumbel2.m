clear
clc
rng(01223445);
%r = (100)*rand(2,1) %Generating random numbers between 1,100
%alpha12=-r(1)-r(2)+2*sum(r)*rand(1,1)%Lower bound for alpha12 is -u1-u2 and upper bound is u1+u2.)
%baseline=diag(r)
%baseline(1,2)=alpha12
%baseline(2,1)=alpha12
%baseline
N=20; %assortment size
u=(10)*rand(N,1); %Randomly created utilities of the products between 1-100.
baseline=zeros(length(u),length(u)); 
for i=1:length(u)
    for j=1:length(u)
        if i~=j
            alphaij=-u(i)-u(j)+2*(u(i)+u(j))*rand(1,1);
            baseline(i,j)=alphaij;
            baseline(j,i)=baseline(i,j);
        else
            baseline(i,i)=u(i);
        end
    end
end
[mostbaseline,inbaseline]=max(u);
mostbaseline
inbaseline %most popular product
%baseline is constant
%creating gumbels
mu=1;
a=-mu*psi(1);
epsilon=zeros(1,N);
Utility=zeros(1,N);
sim=1000;
in=zeros(1,sim);
m=zeros(1,sim);
for i=1:sim
r=Gumbelgenerator(a,mu,N);
    for j=1:N
        epsilon(j)=r(j);
        Utility(j)=baseline(j,j)+epsilon(j);
    end
[maxval,indexval] = max(Utility);
in(i)=indexval;
m(i)=maxval;
end
histogram(in)