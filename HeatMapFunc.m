function HeatMapFunc(regionProps, regionInds, image)

img = imread(image);

n = 0; but = 1;

imshow(img); hold on; %hold on retains plots in the current axes so that new plots added to the axes do not delete existing plots
title ('Select as many objects as you would like and, in the end, press Enter');

while (but == 1) %button = 1 means we are left-clicking the mouse
    [col, lin, but] = ginput(1); %ginput to identify the coordinates of 1 point by moving the cursor to the desired location and clicking on it; to stop, press Return key
    if (but == 1)
        n = n+1;
        cp(n) = col; %x-coordinate 'array'
        lp(n) = lin; %y-coordinate 'array'
        plot(col, lin, 'r.', 'MarkerSize', 18); drawnow; % red dots of size 18
    end
end

nlin = size(img,1);
ncol = size(img,2);
img = rgb2gray(img);

imNew = zeros(nlin, ncol);

for z=1:n
    %calculate euclidian distance to find centroid of selected object
    objectSelected = regionInds(1); %objectSelected is the index of the selected object in regionProps; at first the selected object is the first one in regionProps
    dist = sqrt((cp(z) - (regionProps(regionInds(1)).Centroid(1))).^2 + (lp(z) - (regionProps(regionInds(1)).Centroid(2))).^2);

    %now, we will compare the distance from [col, lin] to every centroid
    for i=1:length(regionInds)
        tmp = sqrt((cp(z) - (regionProps(regionInds(i)).Centroid(1))).^2 + (lp(z) - (regionProps(regionInds(i)).Centroid(2))).^2);
        if (tmp < dist) %if dist to this centroid is smaller than the previous smaller distance
            dist = tmp;
            objectSelected = regionInds(i);
        end
    end

    for i=1:nlin
        for j=1:ncol
            dist = sqrt((j - (regionProps(objectSelected).Centroid(1))).^2 + (i - (regionProps(objectSelected).Centroid(2))).^2);
            if z == 1
                imNew(i, j) = dist;
            else
                if imNew(i, j) > dist
                    imNew(i, j) = dist;
                end
            %imNew(i,j) = imNew(i,j) + dist;
            end
        end
    end
    
end

v_min = min(imNew(:));
v_max = max(imNew(:));

figure; imshow(imNew); hold on
title('Heatmap');
colormap(flipud(jet)); colorbar; hold on
caxis([v_min v_max]);

end
