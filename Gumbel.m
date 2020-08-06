gran=0.001;
x=-20:gran:20;
lmode=2;
hmode=6;
lscale=5;
hscale=10;
fx1 = evpdf(x,lmode,lscale);
fx2 = evpdf(x,hmode,lscale);
figure(1)
plot(x,fx1)
hold on;
plot(x,fx2)
title('same scale with different mode')
xlabel('x')
ylabel('f(x)')
legend('a=2,mu=5','a=6,mu=5')
grid
figure(2)
fx3=evpdf(x,lmode,lscale);
fx4=evpdf(x,lmode,hscale);
plot(x,fx3)
hold on;
plot(x,fx4)
title('same mode with different scale')
xlabel('x')
ylabel('f(x)')
legend('a=2,mu=5','a=2,mu=10')
grid

