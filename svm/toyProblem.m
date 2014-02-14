% toyProblem.m
% Written by Matthew Boutell, 2006.
% Feel free to distribute at will.

clear all;
clc;

% We fix the seeds so the data sets are reproducible
seedTrain = 137;
seedTest = 138;
% This tougher data set is commented out.
%[xTrain, yTrain] = GenerateGaussianDataSet(seedTrain);
%[xTest, yTest] = GenerateGaussianDataSet(seedTest);

% This one isn't too bad at all
[xTrain, yTrain] = GenerateClusteredDataSet(seedTrain);
[xTest, yTest] = GenerateClusteredDataSet(seedTest);


% Add your code here.
% KNOWN ISSUE: the linear decision boundary doesn't work 
% for this data set at all. Don't know why...
net = svm(size(xTrain, 2), 'rbf', [80], 100);
net = svmtrain(net, xTrain, yTrain);

[detectedClasses, distances] = svmfwd(net, xTest);
truePositives = 0;
trueNegatives = 0;
falsePositives = 0;
falseNegatives = 0;
for i = 1:length(yTrain)
    fprintf('Point %d, True class: %d, detected class: %d, distance: %0.2f\n', i, yTrain(i), detectedClasses(i), distances(i))

    if yTest(i) == detectedClasses(i)
        if yTrain(i) == 1
            truePositives = truePositives + 1;
        else
            trueNegatives = trueNegatives + 1;
        end
    else
        if yTest(i) == 1
            falseNegatives = falseNegatives + 1;
        else
            falsePositives = falsePositives + 1;
        end
    end
end

fprintf('True positives: %d.\n', truePositives);
fprintf('True negatives: %d.\n', trueNegatives);
fprintf('False positives: %d.\n', falsePositives);
fprintf('False negatives: %d.\n', falseNegatives);

tpr = truePositives / (truePositives + falsePositives);
fpr = falsePositives / (falsePositives + truePositives);

fprintf('True positive rate: %d.\n', tpr);
fprintf('False positive rate: %d.\n', fpr);

% Run this on a trained network to see the resulting boundary 
% (as in the demo)
plotboundary(net, [0,20], [0,20]);


