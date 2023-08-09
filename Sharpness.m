function Sharpness(regionBoundaries, regionInds, image)
close all

    img = imread(image);
    
    f = figure;
    p = uipanel('Parent',f,'BorderType','none'); 
    p.Title = 'Sharpness of each object'; 
    p.TitlePosition = 'centertop'; 
    p.FontSize = 12;
    p.FontWeight = 'bold'; hold on
    
    for i=1:length(regionInds)
        boundaries = regionBoundaries{regionInds(i)};
        x_boundaries = boundaries(:, 2);
        y_boundaries = boundaries(:, 1);

        gradient = zeros(1,length(boundaries)-1);
        counter = 1;
        incr = floor(length(boundaries)/30);
        for j=incr+1:incr:length(boundaries)
            if x_boundaries(j) == x_boundaries(j-incr)
                gradient(1, counter) = 0;
            else
                gradient(1, counter) = (y_boundaries(j)-y_boundaries(j-incr))/(x_boundaries(j)-x_boundaries(j-incr));
            end
            counter = counter + 1;
        end
        
        gradient = gradient(1, 1:counter-1);
        
        gradient2 = zeros(1,length(gradient)-1);
        for j=2:length(gradient)
            gradient2(1, j-1) = abs(gradient(j)-gradient(j-1)); 
        end
        
        subplot(2, ceil(length(regionInds)/2), i, 'Parent', p), plot([1:length(gradient)], gradient, 'b*-'); title(strcat('Obj: ', num2str(i)));
        
    end

end