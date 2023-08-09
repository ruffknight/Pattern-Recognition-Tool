function [penny, indsPenny] = CountMoney(regionProps, regionBoundaries, regionInds, image)

close all

img = imread(image);

money = 0;
count = 1;
penny = zeros(1, 50);
indsPenny = zeros(1, 50);

for i=1:length(regionInds)
    perimeter = regionProps(regionInds(i)).Perimeter;
    area = regionProps(regionInds(i)).Area;
	circularity = (perimeter  .^ 2) ./ (4 * pi* area);
    
    if circularity < 1.1
        if regionProps(regionInds(i)).Area > 9000 && regionProps(regionInds(i)).Area < 12000
            money = money + 0.01;
            penny(1, count) = 0.01;
            indsPenny(1, count) = regionInds(i);
            count = count + 1;

        elseif regionProps(regionInds(i)).Area > 13000 && regionProps(regionInds(i)).Area < 14700
            money = money + 0.02;
            penny(1, count) = 0.02;
            indsPenny(1, count) = regionInds(i);
            count = count + 1;

        elseif regionProps(regionInds(i)).Area > 14700 && regionProps(regionInds(i)).Area < 16500
            money = money + 0.1;
            penny(1, count) = 0.10;
            indsPenny(1, count) = regionInds(i);
            count = count + 1;

        elseif regionProps(regionInds(i)).Area > 16500 && regionProps(regionInds(i)).Area < 18500
            money = money + 0.05;
            penny(1, count) = 0.05;
            indsPenny(1, count) = regionInds(i);
            count = count + 1;

        elseif regionProps(regionInds(i)).Area > 18500 && regionProps(regionInds(i)).Area < 20500
            money = money + 0.2;
            penny(1, count) = 0.20;
            indsPenny(1, count) = regionInds(i);
            count = count + 1;

        elseif regionProps(regionInds(i)).Area > 20500 && regionProps(regionInds(i)).Area < 22300 && regionProps(regionInds(i)).Perimeter > 5e+02 && regionProps(regionInds(i)).Perimeter < 5.2e+02 
            money = money + 1;
            penny(1, count) = 1;
            indsPenny(1, count) = regionInds(i);
            count = count + 1;

        elseif regionProps(regionInds(i)).Area > 22300 && regionProps(regionInds(i)).Area < 24000
            money = money + 0.5;
            penny(1, count) = 0.50;
            indsPenny(1, count) = regionInds(i);
            count = count + 1;

        end
    end
end

penny = penny(1,1:count-1);
indsPenny = indsPenny(1,1:count-1);

%fprintf('%s%d\n', 'The total amount of money is ', money)

figure; imshow(image); hold on %start plot

for i=1:length(indsPenny) %for each penny:
    title(strcat('Total amount of money: ', strcat(num2str(money), ' euros'))); 
    plot(regionBoundaries{indsPenny(i)}(:,2),regionBoundaries{indsPenny(i)}(:,1),'Color', 'w','LineWidth',4); %print perimeter in the plot
    text(regionProps(indsPenny(i)).Centroid(1)-30, regionProps(indsPenny(i)).Centroid(2), strcat(num2str(penny(i)), '€'), 'Color', 'b','FontSize', 20); %print area in the plot
end

end