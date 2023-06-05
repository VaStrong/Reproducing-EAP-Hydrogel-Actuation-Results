function StimPlot(RateData)

time = RateData{1,1};
data = RateData{1,2};
samples = size(data,2);

figure;
hold on
for i = 1:samples
    plot(time,data(:,i),'.','MarkerSize',10);
end

temp = reshape(data,1,[])';
fullTime = repmat(time,samples,1);

[xData, yData] = prepareCurveData( fullTime, temp );
ft = fittype( '(a/(1+exp((x-b)/c)))-(a/(1+exp(-b/c)))', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [-30 100 10];
[fitresult, gof] = fit( xData, yData, ft, opts );

plot( fitresult)


legend('GEL 1','GEL 2','GEL 3', 'Fitted Trend')
legend('Location','southeast')
xlabel("Time (s)")
ylabel("Bending (deg)")
title(["Gel Bending Over Time With Stimulation"])
%ylim([0 45])
disp(fitresult)


end

