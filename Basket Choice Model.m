clear
clc
rng(01223445); %the old seed
%rng(1000);
%r = (100)*rand(2,1) %Generating random numbers between 1,100
%alpha12=-r(1)-r(2)+2*sum(r)*rand(1,1)%Lower bound for alpha12 is -u1-u2 and upper bound is u1+u2.)
%baseline=diag(r)
%baseline(1,2)=alpha12
%baseline(2,1)=alpha12
%baseline
N=10; %assortment size
u=(1)*rand(N,1); %Randomly created utilities of the products between 0-1.
baseline=zeros(length(u),length(u)); %empty product utility matrix including the interactions
for i=1:length(u)
    for j=1:length(u)
        if i~=j
            alphaij=-(u(i)-u(j))/2+2*(u(i)+u(j)/2)*rand(1,1); %lower bound is -(u(i)+u(j))/2 upper bound is (u(i)+u(j))/2
            baseline(i,j)=alphaij;
            baseline(j,i)=baseline(i,j);
        else
            baseline(i,i)=u(i);
        end
    end
end
[mostbaseline,inbaseline]=max(u); 
mostbaseline %utility of the most popular product
inbaseline %most popular product
B=1; %basket size
SB=nchoosek(N,B); %possible number of baskets 
combos=combntns(1:length(u),B); %list of all possible baskets
Utility=zeros(1,SB); 
epsilon=zeros(1,SB); 
sim=2000;
mu=1; %scale parameter
a=-mu*psi(1); %mode
in=zeros(1,sim); 
m=zeros(1,sim);
for i=1:sim
r=Gumbelgenerator(a,mu,SB);
meangumbel=mean(r);
Ubasketbaseline=zeros(1,SB);
    for j=1:length(Ubasketbaseline) %this index represents the basket index(column in combos)
        for k=1:B
            for m=k:B
                Ubasketbaseline(j)=Ubasketbaseline(j)+baseline(combos(j,k),combos(j,m));
            end
        end
        epsilon(j)=r(j);
        Utility(j)=Ubasketbaseline(j)+epsilon(j);
    end
    [maxval,indexval] = max(Utility);
    in(i)=indexval; %best basket after simulation i
    m(i)=maxval; 
end
figure(1)
baspur=unique(in)
c = arrayfun(@(x)length(find(in == x)), unique(in), 'Uniform', false);
frebas=cell2mat(c)
b = bar(unique(in),cell2mat(c));
xlabel('Basket Number')
ylabel('Number of times selected')
fretable=zeros(length(baspur),2);
for i=1:length(baspur)
   for j=1:2
       if j==1
           fretable(i,j)=baspur(i);
       else
           fretable(i,j)=frebas(i);
       end
   end
end
fretable

%demand calculation
%price is taken as zero
propdemand=zeros(1,N); %demand based on proposition 1
for k=1:N
    bascontk=find(any(combos==k,2)); %baskets that contain product k
    basdontcontk=find(all(combos~=k,2)); %baskets that do not contain product k
    totalattractiveness=0; %initial attractiveness of product k
    for j=1:length(Ubasketbaseline)
        totalattractiveness=totalattractiveness+exp(Ubasketbaseline(j)/mu);
    end
    kattractiveness=0;
    for j=1:length(bascontk)
        kattractiveness=kattractiveness+exp(Ubasketbaseline(bascontk(j))/mu);
    end
    propdemand(k)=kattractiveness/totalattractiveness;
end
rundemand=zeros(1,N);
for i=1:length(fretable(:,1))
    if i==fretable(i)
        for k=1:B
            rundemand(combos(i,k))=rundemand(combos(i,k))+fretable(i,2);
        end    
    end
end
rundemand
rundemand/sim
propdemand 