X = [0 30 30 30 10 20];
Y = [-3 -2 -1 -2 -3];

Xatt = [1640 1660];
Yatt = [-12];

for i=1:length(X)
    if i==1
       X(i)=1420
    else
       X(i) = X(i-1) + X(i)
    end  
end
figure
stairs(X, [Y Y(end)], 'LineWidth', 2);
hold on
stairs(Xatt,[Yatt Yatt],'LineWidth', 2);
xlim([1400 1700])
grid