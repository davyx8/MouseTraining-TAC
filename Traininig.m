function Training
x=daq.createSession('ni');
x.IsContinuous = true;
%Beam
x.addDigitalChannel('Dev1','port1/line0' , 'InputOnly');
%Lick
x.addDigitalChannel('Dev1','port1/line1' , 'InputOnly');
% valve 1
x.addDigitalChannel('Dev1','port0/line0' , 'OutputOnly');
% valve 2
% x.addDigitalChannel('Dev1','port0/line1' , 'InputOnly');
% valveopen=false;

lev=Level;
%path=sprintf('mouse1_%d_%d_%d_%d_%d_%d.csv',fix(clock()));
lev.lickPath=sprintf('mouseTrainingLICKlog.csv');
lev.trialPath=sprintf('mouseTrainingTRIALLog.csv');
lev.waterPath=sprintf('mouseTrainingWATERLog.csv');
lev.lickThresh=3;
lev.interTrialInterval=10;
lev.levelNumber=7;
lev.timeWindow = 4000;

lickTimer=0;
valveTimer=0;

lev.rewardValve=[1 2 3 4];
lev.noRewardValve=[5 6 7 8];
lev.numberOfTrials=160;
%[randomSeq indi]=generateRandOdor(lev.rewardValve,lev.noRewardValve,lev.numberOfTrials);
valveOpeningTime=2;
loggingThresh=2.5;
wateropen = false;
%x=dev;
currTrials=0;
headIn=false;
%stuff to count
crCount=0;
falarmCount=0;
successCount=0;
missCount=0;

insideInterTrial=false;
trialNumber=1;
attempts=0;
firsLick=true;
firstBeam=true;
dataResults=[];
vopen=1;
vclose=0;
slave=1;
randomValves=generateRandOdor(lev.rewardValve,lev.noRewardValve,lev.numberOfTrials);
[a,b]=hist(randomValves,unique(randomValves))
bar(b,a)
diffrence=diff([a' ones(length(a),1)*max(a)]')
valveCount=1;
delay=0.5;
lickCounter=0;
disconn=true;
trialInit=true;
valveopen=false;
breaking=false;
waterWasGiven=false;
samplingTimer=tic;

%%only in levels 7-8 we want to initialize olfactometer
%% we are opening and closing just proper initialization
%%so olf. will be ready for action
traileID=sprintf('pelegLOG_%d_%d_%d_%d_%d_%d.csv',fix(clock()));
logger = Logger(traileID,...
    @(h2) invoke(h2, 'SetDigOut', 1 ,1 ,0),...
    @(h2) invoke(h2, 'SetDigOut', 1 ,0 ,0));
[ h2, resultOpen, resultLastError, resultID]= olfactometerConnect(logger);
olfactometerSetOder(h2, slave, logger, 2, vopen);
olfactometerSetFinalValve(h2, slave, logger, vopen);
olfactometerSetOder(h2, slave, logger, 2, vclose);
olfactometerSetFinalValve(h2, slave, logger, vclose);
while (true)
    if(insideInterTrial)
        continue
    end
    % loop is broken only when successCount>=lev.successesNeeded
    if(valveCount>lev.numberOfTrials)
        break
    end
    %scanning to get data from electronic box
    data=x.inputSingleScan();
    
    dataVec=[];
    %     dataResults=[dataResults;dataVec];
    if(valveTimer~=0)
        if(toc(valveTimer)<loggingThresh)
            if(toc(samplingTimer)>=0.01)
                dataVec=[data(2); toc(valveTimer)];
                dataResults=[dataResults dataVec];
                samplingTimer=tic;
                %             else
                %                 dataVec=data(2);
                %                 dataResults=[dataResults dataVec];
                
            end
        else
            dlmwrite(lev.filePath,dataResults,'-append');
            dataResults=[];
        end
    end
    if (data(1)==1 && ~headIn)
        
        if( valveTimer==0 || toc(valveTimer)>lev.interTrialInterval)
            % we get here when beam (data(1)) is broken AND it wasnt already
            % broken before (headIn)
            %we increase the number of trials every time beam is re-broken
            currTrials=currTrials+1;
            headIn=true;
            firstBeam=false;
            %       display('beam was broken')
            time=fix(clock);
            if(~valveopen)
                % if we are in levels 7-8 we open the desired valve
                % and final valve (with specified delay)
                %notice that of the valve is alreday open we dont get in here
                valveNumber=randomValves(valveCount)
                olfactometerSetOder(h2, slave, logger, valveNumber, vopen);
                % activePause(delay, logger, h2, slave);
                openingTimer=tic;
                while(delay-toc(openingTimer) > 0.009)
                    [samplingTimer dataResults] =...
                        LogDataWhenPausing(x,samplingTimer,dataResults,valveTimer);
                end
                
                
                olfactometerSetFinalValve(h2, slave, logger, vopen);
                valveCount=valveCount+1;
                
                % pause(delay)
                valveTimer=tic;
                %while(toc(valveTimer)<0.2)
                samplingTimer=tic;
                %end
                valveopen=true;
            end
        end
    elseif (data(1)==0 && ~firstBeam)
        %if beam is unbroken (==0) AND beam was broken before  (first beam)
        %if we didnt give water we count it as a miss
        headIn=false;
        if (~waterWasGiven)
            if(intersect(valveNumber,lev.rewardValve)==valveNumber)
                missCount=missCount+1;
            elseif (intersect(valveNumber,lev.noRewardValve)==valveNumber)
                crCount=crCount+1;
            end
            
        end
        %we want to signal that a trial has been re-initiated
        trialInit=true;
        %   lickCounter=0;
        %we save the data from this trial to the vector
        % and add it to the data results
    end
    
    if (data(2)==1 && ~wateropen && disconn && trialInit && toc(valveTimer)<lev.interTrialInterval)
        %here we check if lick was preformed AND THAT:
        %~wateropen- water ISNT open
        %disconn -the mouse disconnected the tongue completly
        %so as not to count continous engagements as one lick
        %trial has been reinitialized after time window passed
        %see below
        
        
        
        %display(lev.levelNumber)
        disconn=false;
        lickCounter=lickCounter+1;
        time=fix(clock);
        display(lickCounter)
        display(sprintf('%d:%d:%d',time(4:6)))
        attempts=attempts+1;
        if firsLick
            %if this is the first lick in the trial we want to start the
            %clock for the time window (to ocunt the licks)
            
            lickTimer=tic;
            firsLick=false;
        end
        if (lickCounter>=lev.lickThresh & toc(lickTimer)<=lev.timeWindow & intersect(valveNumber,lev.rewardValve)==valveNumber)
            %%this is the stage wqe were all waitiing for
            %we check wether:
            %   A.the mouse did enough licks
            %   B. the licks were all done in the specified time window
            %giving water
            wateropen=true;
            
            
            display('water was given')
            time=fix(clock);
            display(lickCounter)
            %we open the water for the specified giving period
            x.outputSingleScan(1);
            %pause(lev.waterGivePeriod);
            waterTimer=tic;
            while(toc(waterTimer)<lev.waterGivePeriod)
                [samplingTimer dataResults] =LogDataWhenPausing(x,samplingTimer,dataResults,valveTimer)
            end
            %pause(lev.waterGivePeriod)
            x.outputSingleScan(0);
            successCount=successCount+1;
            lickCounter=0;
            waterWasGiven=true;
            %             if (successCount>=lev.successesNeeded)
            %                 %this is the loop breaking condition
            %                 % we ereach here if mouse succceeded enough times to move
            %                 % to next level
            %                 passed=true;
            %                 dataVec=[currTrials attempts successCount missCount passed];
            %                 dataResults=[dataResults;dataVec];
            %
            %                     %it ok that mouse is finished but we still need to
            %                     %close olfactometer
            %                     olfactometerSetOder(h2, slave, logger, valveNumber, vclose);
            %                     olfactometerSetFinalValve(h2, slave, logger, vclose);
            %
            %                 return;
            %             end
            
            wateropen=false;
            % pause(0.05);
            
            %at the end of water giving we have to make an inter trial
            %interval, is done with the specific function
            
            insideInterTrial=true;
            valveopen = pauseWithOlfactionClosing(valveTimer,h2,logger,...
                valveNumber,lev.interTrialInterval,valveOpeningTime,lev,dataResults);
            waterWasGiven=false;
            firsLick=true;
   
            trialInit=false;
            %dataResults=[]
            insideInterTrial=false;
            
            %pause(lev.interTrialInterval)
            
        end
    elseif (data(2)==0)
        disconn=true;
    end
    if (valveopen)
        %%here we want to close the olfactometer after 1sec
        clockVec=fix(clock());
        timeData=sprintf('%d:%d:%d',clockVec(4:6));
        
        attempts=0;
        
        if (toc(valveTimer)>valveOpeningTime)
            olfactometerSetOder(h2, slave, logger, valveNumber, vclose);
            olfactometerSetFinalValve(h2, slave, logger, vclose);
            valveopen=false;
            
            %we pause for two seconds after closing
            %  pause(2)
        end
    end
    if(~firsLick)
        %we want to reinit the trial in case the time window passed
        % we also want to zero the lickcounter
        %also make sure the firstlick is set to true
        if (toc(lickTimer) >lev.timeWindow)
            [waterWasGiven,firsLick,lickCounter,trialInit ] =...
                LogResultsWhenPausing(lev,valveCount,valveNumber,lickCounter,waterWasGiven);
        end
    end
end

end

function valveopen = pauseWithOlfactionClosing(valveTimer,h2,logger,valveNumber,...
    interTrialInterval,valveOpeningTime,lev,dataResults,lickTimer,valveCount);
%%this function is an artifical delay in order to close olfactometer during
%%intertrial interval
loopTic=tic;
tmp=true;

while (toc(loopTic)<interTrialInterval)
    if (toc(valveTimer)>valveOpeningTime && tmp)
        olfactometerSetOder(h2, 1, logger, valveNumber, 0);
        olfactometerSetFinalValve(h2, 1, logger, 0);
        valveopen=false;
        dlmwrite(lev.filePath,dataResults,'-append');
        tmp=false;
    end
    
     if (toc(lickTimer) >lev.timeWindow)
            [waterWasGiven,firsLick,lickCounter,trialInit ] =...
                LogResultsWhenPausing(lev,valveCount,valveNumber,lev.lickThresh,true);
        end
end

end
function [samplingTimer dataResults] =LogDataWhenPausing(x,samplingTimer,dataResults,valveTimer)
data=x.inputSingleScan();
if(toc(samplingTimer)>=0.01)
    dataVec=[data(2); toc(valveTimer)];
    dataResults=[dataResults dataVec];
    samplingTimer=tic;
end
end

function[waterWasGiven,firsLick...
    lickCounter,trialInit ] =...
    LogResultsWhenPausing(lev,valveCount,valveNumber,lickCounter,waterWasGiven)

display('lickcounter zerored')
if (lickCounter>=lev.lickThresh)
    if(intersect(valveNumber,lev.rewardValve)==valveNumber)
        dlmwrite(lev.filePath,[valveCount,valveNumber,1,0,0,0],'-append');
    elseif (intersect(valveNumber,lev.noRewardValve)==valveNumber)
        dlmwrite(lev.filePath,[valveCount,valveNumber,0,0,1,0],'-append');
    end
else
    if(intersect(valveNumber,lev.rewardValve)==valveNumber)
        dlmwrite(lev.filePath,[valveCount,valveNumber,0,1,0,0],'-append');
    elseif (intersect(valveNumber,lev.noRewardValve)==valveNumber)
        dlmwrite(lev.filePath,[valveCount,valveNumber,0,0,0,1],'-append');
    end
end
if(waterWasGiven)
    dlmwrite(lev.waterPath,[valveCount 1],'-append');
else
    dlmwrite(lev.waterPath,[valveCount 0],'-append');
end
waterWasGiven=false;
firsLick=true;
lickCounter=0;
trialInit=false;

end
