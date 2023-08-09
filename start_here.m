close all, clear all

cont = true;
changeIm = false;

imageMenu = {'Moedas1.jpg', 'Moedas2.jpg', 'Moedas3.jpg', 'Moedas4.jpg'};
menu= {'Number of objects and their area, perimeter, centroid', 'Sharpness of objects', 'Order objects in the image', 'Geometrical transformation of an object', 'Similarities between objects', 'Heat Map', 'Quantity of money', 'Heads and tails detection in coins', 'Change Image', 'Exit program'};

while cont == true
    for i=1:length(imageMenu)
        fprintf('%d%s%s\n', i, ' - ', imageMenu{i})
    end
    fprintf('%d%s%s\n', length(imageMenu)+1, ' - ', 'Chose a new path/image');
    fprintf('%d%s%s\n', length(imageMenu)+2, ' - ', 'Exit program');

    changeIm = false;
    image = input('Please select an image: ');
    switch image
        case 1
            image = imageMenu{1};
        case 2
            image = imageMenu{2};
        case 3
            image = imageMenu{3};
        case 4
            image = imageMenu{4};
        case length(imageMenu)+1
            fprintf('%s', 'To select an image, write its name as ');
            fprintf('''%s''', '<path (optional)>\<name>.<filetype>');
            fprintf('\n');
            image = input('Path and/or image: ');
        case length(imageMenu)+2
            cont = false;
            changeIm = true;
        %otherwise
            %image =input('Wrong input, please try again: ');
    end
    
    while changeIm == false
        fprintf('\n');
        for i=1:length(menu)
            fprintf('%d%s%s\n', i, ' - ', menu{i})
        end
        option = input('Menu action: ');

        switch option
            case 1
                [regionProps, boundaries, inds] = CountObjects(image);
            case 2
                [regionProps, boundaries, inds] = CountObjects(image);
                Sharpness(boundaries, inds, image);
            case 3
                [regionProps, boundaries, inds] = CountObjects(image);
                OrderObjects(regionProps, boundaries, inds, image);
            case 4
                [regionProps, boundaries, inds] = CountObjects(image);
                TransformObject(regionProps, inds, image);
            case 5
                [regionProps, boundaries, inds] = CountObjects(image);
                SelectOneObject(regionProps, boundaries, inds, image);
            case 6
                [regionProps, boundaries, inds] = CountObjects(image);
                HeatMapFunc(regionProps, inds, image);
            case 7
                [regionProps, boundaries, inds] = CountObjects(image);
                [penny, indsPenny] = CountMoney(regionProps, boundaries, inds, image);
            case 8
                fprintf('%s\n%s\n%s\n%s\n', 'For this situation, we can choose to compare it to problems related to pattern recognition and OCR (Optical Character Recognition).',  'Specifically, in OCR, the algorithm tries to find characters (including numbers) in the image. For example, in a coin we can try to find its value`s number and, if we do, we know we are dealing with an image containing heads and not tails. Upon researching, we stumbled upon the Matlab function ocr(), which receives an image as input and returns some properties, including recognized characters. If numbers were recognized, we can assume, in our case, that it`s heads but, if the function doesn`t find any numbers, there`s always the possibility that it is still heads but the fuction couldn`t recognize the characters.', 'We can also use pattern recognition techniques to try and match the patterns of either heads or tails to the image, which can help solve the previous issues. We can start by converting our image to grayscale with rgb2gray(). Then we find a suiting threshold that isolates the pattern that makes a coin either heads or tails. Some options for this could be the Otsu algorithm or using proven, predefined threshold values. After we find a suiting threshold, we separate the pattern from the background by only keeping the pixels with luminance values that are above the threshold. We can further clean up our selection with functions like imclose(). We then label each object in the image so that we can obtain their properties using regionprops(). With this information we can analyse specific characteristics of the heads and tails patterns (like the area, solidity, perimeter) in order to understand if it`s one or the other.', 'Also, another method worth mentioning is Gray-Level Co-Occurrence Matrix (GLCM), in which we can use samples of characteristic parts of the heads and tails patterns and identify them in the grayscale version of the image. Knowing the pattern with more matching samples, we know which side of the coin we are more likely to be dealing with. ');
            case (length(menu)-1)
                changeIm = true;
            case length(menu)
                cont = false;
                changeIm = true;
        end
    end
    fprintf('\n\n');
end