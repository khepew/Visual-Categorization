# Visual-Categorization
# README

## Overview

This repository contains two main components related to visual processing and psychophysics experiments using MATLAB. The first file details the implementation of the HMAX model, a computational model inspired by the hierarchical processing of the primate visual system. The second file describes a psychophysical task designed to test visual categorization abilities, implemented using MATLAB’s Psychtoolbox.

---

## 1. **Feedforward HMAX Model**

### Description
The HMAX model is a biologically inspired computational framework developed by Thomas Serre, Maximilian Riesenhuber, and Tomaso Poggio to simulate the hierarchical structure of the primate visual cortex. This model is particularly useful for visual object recognition tasks, capturing features such as orientation, scale, and spatial invariance through a layered feedforward architecture.

### Key Components:
- **S1 Layer**: Mimics the early stages of the primary visual cortex (V1), using Gabor filters to extract basic visual features such as edges and orientations.
- **C1 Layer**: Implements max-pooling over S1 units, enhancing spatial invariance.
- **S2 Layer**: Combines outputs from C1 units to detect more complex patterns across different spatial locations and scales.
- **C2 Layer**: Further enhances invariance and selectivity, consolidating information for classification tasks.

### Implementation:
- **Training and Testing Dataset**: Uses the CBCL MIT dataset, consisting of 1200 grayscale images equally divided between animal and non-animal categories.
- **Support Vector Machine (SVM)**: Employed as a classifier to categorize images based on the features extracted by the HMAX model.

### MATLAB Code:
- Converts RGB images to grayscale using a custom function (`RGBtoGray.m`).
- Uses `fitcsvm` for training and testing the SVM classifier.
- Plots accuracy for different categories (head, close-body, medium-body, far-body) using the `plot` function.

### Results:
The model shows promising performance in object recognition tasks, with distinct accuracies for various body parts of animals. The hierarchical structure allows for robust feature extraction and classification.

---

## 2. **Psychophysical Task Design Using Psychtoolbox**

### Description
This task is designed to investigate visual categorization in human subjects using MATLAB's Psychtoolbox. Participants are presented with images from different categories (Head, Close Body, Far Body, Medium Body) and asked to categorize them rapidly while reaction times and accuracy are measured.

### Key Components:
- **Fixation Dots and Masked Images**: Used to control timing and reduce afterimage effects.
- **Stimuli**: Images are presented randomly from distinct categories, and participants must classify them as either animal or non-animal.
- **Data Collection**: The task stores data such as accuracy and reaction times, saved with a unique timestamp for each session.

### MATLAB Code:
- The code consists of 14 functions and one main script (`myPsycoTask.m`) to execute the experiment.
    - **Main Functions**:
      - `calculateAccuracyPercentages.m`: Computes the accuracy for each category and overall accuracy.
      - `collectResponse.m`: Captures participant responses and reaction times.
      - `displayMaskedImage.m`: Shows masked images between trials.
      - `provideFeedback.m`: Gives feedback on participants' answers (correct or incorrect).
      - `saveParticipantData.m`: Saves the participant’s data to a `.mat` file for further analysis.

### Results:
Participants’ performance is assessed based on the accuracy for different body parts, and reaction times are recorded for each trial. The task provides insights into how humans process and categorize visual information.
