function TransformObject(regionProps, regionInds, image)

close all

while true
    img = imread(image);

    %imNew = zeros(size(img, 1), size(img, 2));
    %imNew(:, :, 1) = zeros(size(img, 1), size(img, 2));
    %imNew(:, :, 2) = zeros(size(img, 1), size(img, 2));
    %imNew(:, :, 3) = zeros(size(img, 1), size(img, 2));
    %figure; imshow(imNew);

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

    for z=1:n
        %calculate euclidian distance to find centroid of selected object
        objectSelected = regionInds(1); %objectSelected is the index of the selected object in regionProps; at first the selected object is the first one in regionProps
        dist = sqrt((cp(z) - (regionProps(regionInds(1)).Centroid(1))).^2 + (lp(z) - (regionProps(regionInds(1)).Centroid(2))).^2);

        %now, we will compare the distance from [col, lin] to every centroid
        for i=2:length(regionInds)
            tmp = sqrt((cp(z) - (regionProps(regionInds(i)).Centroid(1))).^2 + (lp(z) - (regionProps(regionInds(i)).Centroid(2))).^2);
            if (tmp < dist) %if dist to this centroid is smaller than the previous smaller distance
                dist = tmp;
                objectSelected = regionInds(i);
            end
        end

        i = imcrop(img, regionProps(objectSelected).BoundingBox);
        
        %red = i(:,:,1);
        %thr = graythresh(red)*255; %calculate threshold
        %red = red > thr; % we only keep the pixels with intensity levels > thr, which are the 'colored' pixels (aka are 1); everything below is zero
        %green = i(:,:,2);
        %thr = graythresh(green)*255; %calculate threshold
        %green = green > thr;

        %bw = red | green;
        %bw(:,:,2) = bw;
        %bw(:,:,3) = bw(:,:,1);
        %i(bw == 0) = 0;

        i = imrotate(i, 180);
        box = regionProps(objectSelected).BoundingBox;
        img((box(2)-0.5):(box(2)-0.5+box(4)), (box(1)-0.5):(box(1)-0.5+box(3)), :) = i(1:size(i,1),1:size(i,2),:);
        %imNew((box(2)-0.5):(box(2)-0.5+box(4)), (box(1)-0.5):(box(1)-0.5+box(3)), 2) = i(1:size(i,1),1:size(i,2),2);
        %imNew((box(2)-0.5):(box(2)-0.5+box(4)), (box(1)-0.5):(box(1)-0.5+box(3)), 3) = i(1:size(i,1),1:size(i,2),3);
        %figure; imshow(img), hold on
        %title('Rotation of 180º was applied to the object');

        %'Scaling'
        %i = imresize(i, 2); %2 times bigger
        %box = regionProps(objectSelected).BoundingBox;
        %xmin = round((box(1)-0.5)-((1/0.75)*box(3)));
        %xmax = xmin+size(i,2)-1;
        %ymin = round((box(2)-0.5)-((1/0.75)*box(4)));
        %ymax = ymin+size(i,1)-1;
        %img(ymin:ymax, xmin:xmax, :) = i(1:size(i,1),1:size(i,2),:);
        %imNew(ymin:ymax, xmin:xmax, 2) = i(1:size(i,1),1:size(i,2),2);
        %imNew(ymin:ymax, xmin:xmax, 3) = i(1:size(i,1),1:size(i,2),3);
        %figure; imshow(img), hold on
        %title('Object was scaled to twice its size');

    end
    
    figure; imshow(img), hold on
    title('Rotation of 180º was applied to the object');

    answer2 = questdlg('Would you like to apply a new transformation?', 'New transformation', 'Yes', 'No', 'No');

    switch answer2
        case 'No'
            break;
        case 'Yes'
            close all;
    end
    
end

end