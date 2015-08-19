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

currLevel=Level;
%path=sprintf('mouse1_%d_%d_%d_%d_%d_%d.csv',fix(clock()));
path=sprintf('mouse1.csv');
currLevel.lickThresh=3;
currLevel.interTrialInterval=10;
currLevel.levelNumber=7;
currLevel.timeWindow = 4000;






wateropen = false;
x=dev;
currTrials=0;
headIn=false;
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

passed=false;

randomValves=generateRanOdor(lev.t,no,lev.)

valveCount=1;
delay=0.5;
lickCounter=0;
disconn=true;
trialInit=true;
valveopen=false;
breaking=false;
waterWasGiven=false;

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
    
    %scanning to get data from electronic box
    data=x.inputSingleScan();
    
    if (data(1)==1 && ~headIn )
        % we get here when beam (data(1)) is broken AND it wasnt already
        % broken before (headIn)
        %we increase the number of trials every time beam is re-broken
        currTrials=currTrials+1;
        headIn=true;
        firstBeam=false;
        display('beam was broken')
        time=fix(clock);
        display(lickCounter)
        
            % if we are in levels 7-8 we open the desired valve
            % and final valve (with specified delay)
            %notice that of the valve is alreday open we dont get in here
            olfactometerSetOder(h2, slave, logger, valveNumber, vopen);
            activePause(delay, logger, h2, slave);
            olfactometerSetFinalValve(h2, slave, logger, vopen);
            
            valveCount=valveCount+1;
    
            if(valveCount>=length(valves))
            valveCount=1;
            randomValves=valves(randperm(length(valves)));
            end
            valveNumber=randomValves(valveCount);
            % pause(delay)
            valveTimer=tic;
            %while(toc(valveTimer)<0.2)
            
            %end
            valveopen=true;

            olfactometerSetFinalValve(h2, slave, logger, vopen);
            pause(0.3)
            olfactometerSetFinalValve(h2, slave, logger, vclose);

    elseif (data(1)==0 && ~firstBeam)
        %if beam is unbroken (==0) AND beam was broken before  (first beam)
        %if we didnt give water we count it as a miss
        headIn=false;
        if (~waterWasGiven)
            missCount=missCount+1;
        end
        %we want to signal that a trial has been re-initiated
        trialInit=true;
        %   lickCounter=0;
        %we save the data from this trial to the vector
        % and add it to the data results
        dataVec=[currTrials attempts successCount missCount passed];
        dataResults=[dataResults;dataVec];
        attempts=0;
        waterWasGiven=false;
    end
    
    if (data(2)==1 && ~wateropen && disconn && trialInit)
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
            
            tic
            firsLick=false;
        end
        if (lickCounter>=lev.lickThresh && toc*1000<=lev.timeWindow)
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
            pause(lev.waterGivePeriod);
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
            pause(0.05);
            
            %at the end of water giving we have to make an inter trial
            %interval, is done with the specific function
            
                insideInterTrial=true;
                valveopen = pauseWithOlfactionClosing(valveTimer,h2,logger,valveNumber,lev.interTrialInterval);
                insideInterTrial=false;
            
                pause(lev.interTrialInterval)
            
        end
    elseif (data(2)==0)
        disconn=true;
    end
    if (lev.levelNumber>6 && valveopen)
        %%here we want to close the olfactometer after 1sec
        if (toc(valveTimer)>1)
            olfactometerSetOder(h2, slave, logger, valveNumber, vclose);
            olfactometerSetFinalValve(h2, slave, logger, vclose);
            valveopen=false;
            %we pause for two seconds after closing
            pause(2)
        end
    end
    if(~firsLick)
        %we want to reinit the trial in case the time window passed
        % we also want to zero the lickcounter
        %also make sure the firstlick is set to true
        if (toc*1000 >lev.timeWindow)
            display('lickcounter zerored')
            
            firsLick=true;
            lickCounter=0;
            trialInit=false;
        end
    end
end

end

function valveopen = pauseWithOlfactionClosing(valveTimer,h2,logger,valveNumber,interTrialInterval)
%%this function is an artifical delay in order to close olfactometer during
%%intertrial interval
loopTic=tic;
tmp=true;
while (toc(loopTic)<interTrialInterval)
    
    if (toc(valveTimer)>1 && tmp)
        olfactometerSetOder(h2, 1, logger, valveNumber, 0);
        olfactometerSetFinalValve(h2, 1, logger, 0);
        valveopen=false;
        tmp=false;
    end
end

end
