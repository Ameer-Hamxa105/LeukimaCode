testingPath = fullfile('E:\Leukemia paper\C-NMC_Leukemia\testing Augm');
 imdsTest = imageDatastore(testingPath, 'IncludeSubfolders',true,'LabelSource','foldernames');

 actual_labels=imdsTest.Labels;

 %% preprocess images
 auimds = augmentedImageDatastore([227 227],imdsTest,'ColorPreprocessing','gray2rgb');

%% Model Load

ModelTest= load('TrainedMInvertedSiri1.mat');
ModelTest=ModelTest.TrainedMInvertedSiri1;
  predicted_labels=classify(ModelTest,auimds);
   % [predicted_labels,posterior] = classify(ModelTest,auimds);
%% Testing Results
figure;
plotconfusion(actual_labels,predicted_labels)
title('Confusion Matrix:');
%% ROC CURVE
 test_labels=double(nominal(actual_labels));
%% Performance

ACTUAL=actual_labels;
PREDICTED=predicted_labels;
idx = (ACTUAL()=='Leukemia blast');
%disp(idx)
p = length(ACTUAL(idx));
n = length(ACTUAL(~idx));
N = p+n;
tp = sum(ACTUAL(idx)==PREDICTED(idx));
tn = sum(ACTUAL(~idx)==PREDICTED(~idx));
fp = n-tn;
fn = p-tp;

tp_rate = tp/p;
tn_rate = tn/n;

accuracy = (tp+tn)/N;
sensitivity = tp_rate;
specificity = tn_rate;
precision = tp/(tp+fp);
recall = sensitivity;
f_measure = 2*((precision*recall)/(precision + recall));
gmean = sqrt(tp_rate*tn_rate);

disp(['accuracy=' num2str(accuracy)])
disp(['sensitivity=' num2str(sensitivity)])
disp(['specificity=' num2str(specificity)])
disp(['precision=' num2str(precision)])
disp(['recall=' num2str(recall)])
disp(['f_measure=' num2str(f_measure)])
disp(['gmean=' num2str(gmean)])
 title={'''accuracy','''sensitivity','''specificity','''precision','''recall','''f_measure','''gmean'};
VALUES=[accuracy,sensitivity,specificity,precision,recall,f_measure,gmean];
filename='performance.xlsx';
xlswrite(filename,title,'Sheet1','A1')
xlswrite(filename,VALUES,'Sheet1','A2')
%winopen(filename);  
%end
winopen(filename);   