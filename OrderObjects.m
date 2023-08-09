function OrderObjects(regionProps, regionBoundaries, regionInds, image)

close all

%order by area, perimeter and value

cont = true;

menu = {'Order by Area', 'Order by Perimeter', 'Order by Value', 'Go back to menu'};

while cont == true
    fprintf('\n');
    for i=1:length(menu)
        fprintf('%d%s%s\n', i, ' - ', menu{i})
    end
    
    option = input('Choose an order criteria: ');
    
    switch option
        case 1
            delete(gcf);
            img = imread(image);
            areas = zeros(1, length(regionInds));

            for i=1:length(regionInds)
                areas(1, i) = regionProps(regionInds(i)).Area;
            end

            [areas, idx] = sort(areas);

            inds = regionInds(idx);
            
            for i=1:length(inds)
                j = imcrop(img, regionProps(inds(i)).BoundingBox);
                subplot(2, ceil(length(inds)/2), i), imshow(j); title({['Area: ']
                    [num2str(regionProps(inds(i)).Area)]});
                hold on
            end

            hold off;
            
        case 2
            delete(gcf);
            img = imread(image);
            perimeters = zeros(1, length(regionInds));

            for i=1:length(regionInds)
                perimeters(1, i) = regionProps(regionInds(i)).Perimeter;
            end

            [perimeters, idx] = sort(perimeters);

            inds = regionInds(idx);

            for i=1:length(inds)
                j = imcrop(img, regionProps(inds(i)).BoundingBox);
                subplot(2, ceil(length(inds)/2), i), imshow(j); title({['Perimeter: ']
                    [num2str(regionProps(inds(i)).Perimeter)]});
                hold on
            end

            hold off;
            
        case 3
            delete(gcf);
            img = imread(image);
            
            [penny, indsPenny] = CountMoney(regionProps, regionBoundaries, regionInds, image); %indsPenny has the indices from regionProps that correspond to coins

            [penny, idx] = sort(penny);

            inds = indsPenny(idx);

            for i=1:length(inds)
                j = imcrop(img, regionProps(inds(i)).BoundingBox);
                subplot(2, ceil(length(inds)/2), i), imshow(j); title({['Value: ']
                    [strcat(num2str(penny(i)), '€')]});
                hold on
            end

            hold off;
        
        case 4
            cont = false;
            break;
            
        otherwise
        
    end
end

end