%% Ali KhosraviPour - 99101502 - HW2 Neuroscience
%%
headNumber = 0;
closeBodyNumber = 0;
mediumBodyNumber = 0;
farBodyNumber = 0;

% Psychtoolbox Setup
PsychDefaultSetup(2);
Screen('Preference', 'SkipSyncTests', 1);
Screen('Preference', 'VisualDebugLevel', 0);
[window, windowRect] = PsychImaging('OpenWindow', max(Screen('Screens')), BlackIndex(window), []);
Screen('TextSize', window, 50);
Screen('TextStyle', window, 1 + 8); % Bold & Outline around characters
Screen('TextFont', window, 'Helvetica');


% Instruction Window
DrawFormattedText(window, '1. Look at the White Dot at Center.', 'center', 'center', [256, 256, 256]);
Screen('Flip', window);
WaitSecs(5);  % Wait for 5s
DrawFormattedText(window, '2. Press A for Animals, N for Non-Animals.', 'center', 'center', [256, 256, 256]);
Screen('Flip', window);
WaitSecs(5);  % Wait for 5s
DrawFormattedText(window, 'Press Space to start the task, good luck!', 'center', 'center', [256, 0, 0]);
HideCursor;
Screen('Flip', window);

% Pathways of Images of Different Categories
datasetPaths = {
    'C:\Users\ASUS\Desktop\HW2_myDataset\myDataset2_B', 
    'C:\Users\ASUS\Desktop\HW2_myDataset\myDataset2_D', 
    'C:\Users\ASUS\Desktop\HW2_myDataset\myDataset2_F', 
    'C:\Users\ASUS\Desktop\HW2_myDataset\myDataset2_H', 
    'C:\Users\ASUS\Desktop\HW2_myDataset\myDataset2_M'
};

train = 0;
imagesPerCategory = 15;
allImages = cell(1, numel(datasetPaths) * imagesPerCategory);
count = 1;

for pathIdx = 1:numel(datasetPaths)
    folderPath = datasetPaths{pathIdx};
    images = dir(fullfile(folderPath, '*.jpg'));
    
    if numel(images) >= imagesPerCategory
        randomIndex = randperm(numel(images), imagesPerCategory);
        selectedImages = images(randomIndex);
        
        for imgIdx = 1:imagesPerCategory
            allImages{count} = fullfile(folderPath, selectedImages(imgIdx).name);
            count = count + 1;
        end
    end
end

randomIndexAll = randperm(numel(allImages));

% Wait for participant to press 'Space'
RT = zeros(1, 240);
keyQ = KbName('q');
keySpace = KbName('space');
key = nhKeyResp(-1, keyQ, keySpace);

% Define the number of trials & Initialize arrays for 'participant' and 'true answers'
trialNumber = 75;  % 15 images from each category
subjectAnswer = zeros(1, trialNumber);
trueAnswer = zeros(1, trialNumber);

for i = 1: trialNumber
    trueAnswer(i) = setTrueAnswer(allImages{randomIndexAll(i)});
end

% Accuracies
accuracyHead = 0;
accuracyCloseBody = 0;
accuracyFarBody = 0;
accuracyMediumBody = 0;
group = nan;

% Start of the Task:
for i = 1:trialNumber

    % Display White Dot 
    drawFixationDot(window, 10);
    
    % Display Images
    img = loadAndDisplayImage(allImages{randomIndexAll(i)}, window);

    % Extracting the correct answer for the image (from file's name)
    trueAnswer(i) = setTrueAnswer(allImages{randomIndexAll(i)});

    % Determine Category (Close Body, Far Body, Head, Medium Body).
    [group, closeBodyNumber, farBodyNumber, headNumber, mediumBodyNumber] = determineCategory(allImages{randomIndexAll(i)}, closeBodyNumber, farBodyNumber, headNumber, mediumBodyNumber);

    % Display Masked Image for 0.08s
    displayMaskedImage(window, img, 0.03, 0.08);

    % Display White Dot for 0.5s
    drawFixationDot(window, 10);

    % Collecting participant response & RT(reaction time)
    [subjectAnswer, RT] = collectResponse(window, keySpace, keyQ, subjectAnswer, trueAnswer, i, group);

    % Feedback Based on Response.
    provideFeedback(window, subjectAnswer, trueAnswer, i);

    % Updating Counters & Accuracies for each Category
    [accuracyCloseBody, accuracyFarBody, accuracyHead, accuracyMediumBody] = updateAccuracyCounters(subjectAnswer, trueAnswer, i, group, accuracyCloseBody, accuracyFarBody, accuracyHead, accuracyMediumBody);

    key = nhKeyResp(-1, keyQ, keySpace);
end

[accuracyCloseBody, accuracyFarBody, accuracyHead, accuracyMediumBody, totalAcc] = calculateAccuracyPercentages(closeBodyNumber, farBodyNumber, headNumber, mediumBodyNumber, accuracyCloseBody, accuracyFarBody, accuracyHead, accuracyMediumBody);
saveParticipantData(totalAcc, accuracyCloseBody, accuracyFarBody, accuracyHead, accuracyMediumBody, RT);
thankYouMessage(window);
KbStrokeWait;
sca;

trialNumbers = 1:trialNumber;

% Plotting the accuracies
% figure;
% plot(trialNumbers, accuracyHead, 'o-', 'DisplayName', 'Head');
% hold on;
% plot(trialNumbers, accuracyCloseBody, 's-', 'DisplayName', 'Close Body');
% plot(trialNumbers, accuracyFarBody, '^-', 'DisplayName', 'Far Body');
% plot(trialNumbers, accuracyMediumBody, 'p-', 'DisplayName', 'Medium Body');
% 
% % Set category labels on the x-axis
% xticks(trialNumbers);
% xticklabels({'Head', 'Close Body', 'Far Body', 'Medium Body'});
% 
% % Add labels and title
% xlabel('Category');
% ylabel('Accuracy');
% title('Accuracy Across Different Categories');
% legend('Location', 'Best');
% grid on;

