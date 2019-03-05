clc
clear all
close all
%% Basic SVDD
x = oc_set(gendatb([50,10]),'1') 
figure;
scatterd(x,'legend')  
[w,res] = svdd(target_class(x),0.1,8);
plotc(w) 
 
 %% Proposed SVDD with f(e)
 alpha = res.a;
 J= res.J;
 sv = res.sv;
 for i=1:length(x)
     %ans = sum(alpha.*(x(J)))
     to = (x(i))*sv'
     E(i) = abs(sum((alpha.*(ones(size(J,1),1)))'*to'))
 end

[n, m]=size(x);
F = zeros(n,1);
c = 1;
Sigma = 1;

for i = 1 : n
    sumi = 0;
    for j = 1 : n
        temp1 = (1/(n*sqrt(2*pi)*Sigma));
        temp2 = -(E(i)-E(j))^2 / (2*Sigma^2);
        sumi = sumi + temp1 * exp(temp2);
    end
    F(i) = sumi;
end
figure
c = c*F; 

scatterd(x,'legend')  
[w,res] = svddf(target_class(x),0.1,8,c);
plotc(w) 
%%
 
 