classdef Level
    properties
        
      
%         filePath='';
%         trialPath='';
%         waterPath='';
        waterGivePeriod=0.03; %seconds
        rewardValve=[2];
        noRewardValve=[9];
        numberOfTrials
        %in order to determine if consecutive licks are counted
        %together for threshold satistfaction timewindow is defined
        timeWindow=100; %ms
        
        %number of successes needed to pass to next level
        successesNeeded=10;
        %nubmer of licks needed in order to consoder it a reall "lick"
        lickThresh=0;
        %odor valve to open
        Valve=0;
        %how long ot waut between each trial
        interTrialInterval=5;
        numberofTrials=20;
        
        odorPeriod=1;
        %for training only
        NumberOfLicksPerTimeWindow=4;
        levelNumber=1;
        minWindowsBeforeFirstLick
        lengthOfWindow;
        
    end
end
