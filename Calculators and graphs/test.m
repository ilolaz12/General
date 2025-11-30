syms f(t) p(t);
figure; hold on
for c = 0:0.1:5
    g = @(f, p) 4*f - 3*f*p;
    [f,p] = ode45(g, [0,5], c);
end
for c = 0:0.1:5
     h = @(f,p) -2*p + f*p;
    [f,p] = ode45(h, [0,5], c);
end 
plot(f, p)
axis tight;