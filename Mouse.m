classdef Mouse
    properties
        mouseName='mickey';
        lickFirstPath='';
        lickSecondPath='';
        timePath='';
        trialPath='';
        waterPath='';
        beamPath='';
        beamUnrewardedPath='';
        valveSequencePath='';
        randomValves=[];
        rewardValve=[1 2 3 4];
        noRewardValve=[5 6 7 8];
        currentValve=1;
        waterGivePeriod=0.03; %seconds
        %in order to determine if consecutive licks are counted
        %together for threshold satistfaction timewindow is defined
        timeWindow=100;
        valveOpeningTime=2;
        %number of successes needed to pass to next level
        successesNeeded=10;
        %nubmer of licks needed in order to consoder it a reall "lick"
        lickThresh=0;
        %odor valve to open
        %how long ot waut between each trial
        interTrialInterval=5;
        numberofTrials=20;
        delay=0.4;
        odorPeriod=1;
        %for training only
        NumberOfLicksPerTimeWindow=4;
        
%         minWindowsBeforeFirstLick
%         lengthOfWindow;
    end
end