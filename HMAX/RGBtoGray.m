% RGB Images Pathways
rgb_images_pathway1 = 'C:\Users\ASUS\Desktop\HW1_Dataset\Train\Target';
rgb_images_pathway2 = 'C:\Users\ASUS\Desktop\HW1_Dataset\Train\Distractor';
rgb_images_pathway3 = 'C:\Users\ASUS\Desktop\HW1_Dataset\Test\Target';
rgb_images_pathway4 = 'C:\Users\ASUS\Desktop\HW1_Dataset\Train\Distractor';

% Gray Images Pathways
gray_images_pathway1 = 'C:\Users\ASUS\Desktop\HW1_Dataset\Train\Target_Gray'; 
gray_images_pathway2 = 'C:\Users\ASUS\Desktop\HW1_Dataset\Train\Distractor_Gray';
gray_images_pathway3 = 'C:\Users\ASUS\Desktop\HW1_Dataset\Test\Target_Gray';
gray_images_pathway4 = 'C:\Users\ASUS\Desktop\HW1_Dataset\Test\Distractor_Gray';

% Converting RBG to Gray
convertRGBtoGrayAndSave(rgb_images_pathway1, gray_images_pathway1);
convertRGBtoGrayAndSave(rgb_images_pathway2, gray_images_pathway2);
convertRGBtoGrayAndSave(rgb_images_pathway3, gray_images_pathway3);
convertRGBtoGrayAndSave(rgb_images_pathway4, gray_images_pathway4);


function convertRGBtoGrayAndSave(rgb_images_pathway, gray_images_pathway)
    % Read RGB images
    image_files = dir(fullfile(rgb_images_pathway, '*.jpg'));
    images = cell(1, numel(image_files));

    for i = 1:numel(image_files)
        images{i} = imread(fullfile(rgb_images_pathway, image_files(i).name));
    end

    % Convert to grayscale
    gray_images = cell(1, numel(images));
    for i = 1:numel(images)
        gray_images{i} = rgb2gray(images{i});
    end

    % Save grayscale images
    for i = 1:numel(gray_images)
        output_file = fullfile(gray_images_pathway, ['grayedByMe_', num2str(i), '.png']);
        imwrite(gray_images{i}, output_file);
    end
end
