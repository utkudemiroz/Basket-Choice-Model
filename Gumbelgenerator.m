function r= Gumbelgenerator(a,mu,s)
rng shuffle
r=zeros(1,s);
for i=1:s
        r(i)= evrnd(a,mu);
end