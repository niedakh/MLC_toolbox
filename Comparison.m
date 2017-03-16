%%% Comparison code with fixed parameters 

%% Initial Setting 
addAllpath; rng('default');

%% Datasets to use 
dataNames={'enron','yeast','medical','CAL500','corel5k','scene','genbase'};
numCV=5; numTrial=1; % less than 10


%% Select methods to use
methodNames=cell(2,1);
methodNames{1}={'FScore','BR'};
methodNames{2}={'CCA','BR'};
methodNames{3}={'MDDM','BR'};
methodNames{4}={'MHSL','BR'};
methodNames{5}={'MIFS','BR'};
methodNames{6}={'MLDA','BR'};
methodNames{7}={'MLJMI','BR'};
methodNames{8}={'MLMRMR','BR'};
methodNames{9}={'MLSI','BR'};
methodNames{10}={'NMF','BR'};
methodNames{11}={'NPE','BR'};
methodNames{12}={'OPLS','BR'};
methodNames{13}={'PCA','BR'};
methodNames{14}={'RFS','BR'};
methodNames{15}={'SVP','BR'};
% methodNames{3}={'RAkEL','LP'};
% methodNames{4}={'fRAkEL','LP'};
% methodNames{5}={'HOMER','LP'};
% methodNames{6}={'CBMLC','LP'};

% functionNames will be used for plot
%functionNames={'fRAkEL-LP','COCOA-LP'}; %,'HOMER-LP','CLMLC-LP','CBMLC-LP','fRAkEL-LP','MLCC-LP','TREMLC-LP'};
functionNames={'FScore','CCA','MDDM','MHSL','MIFS','MLDA','MLJMI','MLMRMR','MLSI','NMF','NPE','OPLS','PCA','PCA','RFS','SVP'};
methodSet=cell(2,1);

for countMethod=1:length(methodNames)
    method.name=methodNames{countMethod};
    method=SetALLParams(method);
    %Common base classifier is considered in this script
    %method.base.name='ridge';
    method.base.name='linear_svm';
    %method.base.param.lambda=10;
    method.base.param.svmparam='-s 2 -q';
    method.th.type='SCut';
    method.th.param=0.5;
    methodSet{countMethod}=method;
    method=[];
end

Result=cell(length(dataNames),1);

for countData=1:length(dataNames)
    dataname=dataNames{countData};
    Result{countData}=cell(length(methodSet),1);
    for countMethod=1:length(methodSet)
        method=methodSet{countMethod};
        DispSelection;
        [res,conf,pred]=conductExpriments(method,numTrial,numCV,dataname);
        Result{countData}{countMethod}=res;
    end
end    

criteria={'top1','dcg1','auc','exact','hamming','macroF1','microF1'};
% Visualization of results
for i=1:length(criteria)
    criterion=criteria{i};
    getBarPlot(Result,dataNames,functionNames,criterion);
end

