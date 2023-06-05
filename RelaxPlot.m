function RelaxPlot(Realxation_Data)

time = Realxation_Data(:,1);
samples = size(Realxation_Data,2)-1;

figure;
hold on
for i = 1:samples
    plot(time,Realxation_Data(:,i+1),'.','MarkerSize',10);
end

temp = Realxation_Data(:,2:samples+1);
temp = reshape(temp,1,[])';
fullTime = repmat(time,samples,1);

[xData, yData] = prepareCurveData( fullTime, temp );
ft = fittype( 'a*exp(b*x)+c', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [-30 -0.01 30];
[fitresult, gof] = fit( xData, yData, ft, opts );

plot( fitresult)


legend('GEL 1','GEL 2','GEL 3', 'Fitted Trend')
xlabel("Time (s)")
ylabel("Change in Angle (deg)")
title(["Change in Bending Angle From" "Stimulated Position Over Time"])
ylim([0 40])
disp(fitresult)


end

