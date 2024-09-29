%% Ali KhosraviPour - 99101502 - HW1 Neuroscience
%%
useSVM = 1;     
READPATCHESFROMFILE = 0; 
patchSizes = [4 8 12 16]; 	  
numPatchSizes = length(patchSizes);

% Pathways of Train & Test Grayed Images (Both Target & Distractor)
train_set.pos   = 'C:\Users\ASUS\Desktop\HW1_Dataset\Train\Target_Gray';
train_set.neg   = 'C:\Users\ASUS\Desktop\HW1_Dataset\Train\Distractor_Gray';
test_set.pos    = 'C:\Users\ASUS\Desktop\HW1_Dataset\Test\Target_Gray';
test_set.neg    = 'C:\Users\ASUS\Desktop\HW1_Dataset\Test\Distractor_Gray';

cI = readAllImages(train_set,test_set); 

if isempty(cI{1}) | isempty(cI{2})
  error(['No training images were loaded -- did you remember to' ...
	' change the path names?']);
end
  
if ~READPATCHESFROMFILE
  tic
  numPatchesPerSize = 250; %more will give better results, but will
                           %take more time to compute
  cPatches = extractRandC1Patches(cI{1}, numPatchSizes, ...
      numPatchesPerSize, patchSizes); %fix: extracting from positive only 
                                      
  totaltimespectextractingPatches = toc;
else
  fprintf('reading patches');
  cPatches = load('PatchesFromNaturalImages250per4sizes','cPatches');
  cPatches = cPatches.cPatches;
end

%----Settings for Testing --------%
rot = [90 -45 0 45];
c1ScaleSS = [1:2:18];
RF_siz    = [7:2:39];
c1SpaceSS = [8:2:22];
minFS     = 7;
maxFS     = 39;
div = [4:-.05:3.2];
Div       = div;
%--- END Settings for Testing --------%

fprintf(1,'Initializing gabor filters -- full set...');
%creates the gabor filters use to extract the S1 layer
[fSiz,filters,c1OL,numSimpleFilters] = init_gabor(rot, RF_siz, Div);
fprintf(1,'done\n');

%The actual C2 features are computed below for each one of the training/testing directories
tic
for i = 1:4,
  C2res{i} = extractC2forcell(filters,fSiz,c1SpaceSS,c1ScaleSS,c1OL,cPatches,cI{i},numPatchSizes);
  toc
end
totaltimespectextractingC2 = toc;

%Simple classification code
XTrain = [C2res{1} C2res{2}]; %training examples as columns 
XTest =  [C2res{3},C2res{4}]; %the labels of the training set
ytrain = [ones(size(C2res{1},2),1);-ones(size(C2res{2},2),1)];%testing examples as columns
ytest = [ones(size(C2res{3},2),1);-ones(size(C2res{4},2),1)]; %the true labels of the test set

% Using Support Vector Machine as Classifier
% Fitting to Train 
svmModel = fitcsvm(XTrain', ytrain);

% Predicting on Test
predictedLabels = predict(svmModel, XTest');

% Calculating Total Accuracy 
accuracy = sum(predictedLabels == ytest) / numel(ytest);

% Accuracy for Head/ Close-Body/ Medium-Body/ Far-Body
[head_Accuracy, closeBody_Accuracy, mediumBody_Accuracy, farBody_Accuracy] = accuracy_each_category(ytest, predictedLabels);

% Create a linear plot
categories = {'Head', 'Close-Body', 'Medium-Body', 'Far-Body'};
accuracies = [head_Accuracy, closeBody_Accuracy, mediumBody_Accuracy, farBody_Accuracy];

figure;
plot(1:numel(categories), accuracies, 'o-', 'LineWidth', 2, 'MarkerSize', 8);
xlabel('Categories');
ylabel('Accuracy');
title('Accuracy for Different Categories');
set(gca, 'xtick', 1:numel(categories), 'xticklabel', categories);
grid on;


function [head_Accuracy, closeBody_Accuracy, mediumBody_Accuracy, farBody_Accuracy] = accuracy_each_category(ytest, predictedLabels)
    categories = {'F', 'M', 'H', 'B'};
    numSamples = 75;
    numCategories = numel(categories);

    for i = 1:numCategories
        startIndex = (i - 1) * numSamples + 1;
        endIndex = i * numSamples;

        testIndex = (i - 1) * 150 + 1;
        testdIndex = i * 150;

        test = ytest(testIndex:testdIndex);
        test_pred = predictedLabels(testIndex:testdIndex);

        result = [test; ytest(startIndex:endIndex)];
        result_pred = [test_pred; predictedLabels(startIndex:endIndex)];

        accuracy = sum(result_pred == result) / numel(result);
        switch categories{i}
            case 'B'
                closeBody_Accuracy = accuracy ;
            case 'F'
                farBody_Accuracy = accuracy;
            case 'H'
                head_Accuracy = accuracy;
            case 'M'
                mediumBody_Accuracy = accuracy;
        end
    end
end











