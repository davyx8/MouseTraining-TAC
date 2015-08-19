function [passed dataResults] = LevelHandler(dev,lev)
wateropen = false;
x=dev;
currTrials=0;
headIn=false;
successCount=0;
successCountB=0;
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
valves=[10];
randomValves=valves(randperm(length(valves)));
valveNumber=randomValves(1);
newValve=valveNumber;
valveCount=1;
delay=0.5;
lickCounter=0;
lickCounterB=0;
disconn=true;
trialInit=true;
valveopen=false;
breaking=false;
waterWasGiven=false;
beamTimer=0;
if(lev.levelNumber>3)
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
end
while (true)
    if(insideInterTrial)
        continue
    end
    % loop is broken only when mnsuccessCount>=lev.successesNeeded
    
    %scanning to get data from electronic box
    data=x.inputSingleScan();
    if(beamTimer==0)
    beamTimer=tic;
    end
    if (data(1)==1 && ~headIn &&toc(beamTimer)<lev.interTrialInterval)
        % we get here when beam (data(1)) is broken AND it wasnt already
        % broken before (headIn)
        %we increase the number of trials every time beam is re-broken
        currTrials=currTrials+1;
        %beamTimer=tic;
        headIn=true;
        firstBeam=false;
        display('beam was broken')
        time=fix(clock);
      
        if (lev.levelNumber>6 && ~valveopen)
            % if we are in levels 7-8 we open the desired valve
            % and final valve (with specified delay)
            %notice that of the valve is alreday open we dont get in here
            display('before')
            valveNumber=newValve
            olfactometerSetOder(h2, slave, logger, valveNumber, vopen);
            activePause(delay, logger, h2, slave);
            olfactometerSetFinalValve(h2, slave, logger, vopen);
            valveCount=valveCount+1;
    
            if(valveCount>=length(valves))
            valveCount=1;
            randomValves=valves(randperm(length(valves)));
            end
            display('after:')
            newValve=randomValves(valveCount);
            % pause(delay)
            valveTimer=tic;
            valveopen=true;
        elseif (lev.levelNumber==4 )
            olfactometerSetFinalValve(h2, slave, logger, vopen);
            pause(0.3)
            olfactometerSetFinalValve(h2, slave, logger, vclose);
        end
    elseif (data(1)==0 && ~firstBeam)
        %if beam is unbroken (==0) AND beam was broken before  (first beam)
        %if we didnt give water we count it as a miss
        headIn=false;
        
       % if (~waterWasGiven)
            missCount=missCount+1;
        %end
        %we want to signal that a trial has been re-initiated
        trialInit=true;
        %   lickCounter=0;
        %we save the data from this trial to the vector
        % and add it to the data results
        %dataVec=[currTrials attempts successCount missCount passed];
        %dataResults=[dataResults;dataVec];
        attempts=0;
        waterWasGiven=false;
      %  pause(lev.interTrialInterval);
%       if (lev.levelNumber>6 && ~valveopen)
%       valveopen = pauseWithOlfactionClosing(valveTimer,h2,logger,valveNumber,lev.interTrialInterval)
%       end
    end
   
    if ((data(2)==1 || (data(3)==1))  && ~wateropen && disconn && trialInit)
        %here we check if lick was preformed AND THAT:
        %~wateropen- water ISNT open
        %disconn -the mouse disconnected the tongue completly
        %so as not to count continous engagements as one lick
        %trial has been reinitialized after time window passed
        %see below
        
        
        
        %display(lev.levelNumber)
        disconn=false;
      
        if(data(2)==1 )
        lickCounter=lickCounter+1;
        end    
        if(data(3)==1 )
             lickCounterB=lickCounterB+1;
        end
        time=fix(clock);
        %display(sprintf('Choice A lick: %d',lickCounter));
        %display(sprintf('Choice B lick: %d',lickCounterB));
        %display(sprintf('%d:%d:%d',time(4:6)))
        attempts=attempts+1;
        if firsLick
            %if this is the first lick in the trial we want to start the
            %clock for the time window (to ocunt the licks)
            
            tic
            firsLick=false;
        end
        if ((lickCounter>lev.lickThresh || lickCounterB>lev.lickThresh) && toc*1000<=lev.timeWindow)
            %%this is the stage wqe were all waitiing for
            %we check wether:
            %   A.the mouse did enough licks
            %   B. the licks were all done in the specified time window
            %giving water
            wateropen=true;
            
            
          
       
            %we open the water for the specified giving period
        if(lickCounterB>lev.lickThresh)
            x.outputSingleScan([1 0]);
            pause(lev.waterGivePeriod);
            %pause(lev.waterGivePeriod)
            x.outputSingleScan([0 0]);
            successCountB=successCountB+1
        elseif(lickCounter>lev.lickThresh)
            
                  x.outputSingleScan([0 1]);
            pause(lev.waterGivePeriod);
            %pause(lev.waterGivePeriod)
            x.outputSingleScan([0 0]);
            successCount=successCount+1
            
        end
         lickCounter
         lickCounterB
            lickCounter=0;
            lickCounterB=0;
              display('water was given')
            display(sprintf('A :%d/%d',successCount,lev.successesNeeded))
            display(sprintf('B :%d/%d',successCountB,lev.successesNeeded))
            time=fix(clock);
            
            waterWasGiven=true;
            if (successCount>=lev.successesNeeded && successCountB>=lev.successesNeeded)
                %this is the loop breaking condition
                % we ereach here if mouse succceeded enough times to move
                % to next level
                passed=true;
                dataVec=[currTrials attempts successCount missCount passed];
                dataResults=[dataResults;dataVec];
                if (lev.levelNumber>6)
                    %it ok that mouse is finished but we still need to
                    %close olfactometer
                    olfactometerSetOder(h2, slave, logger, valveNumber, vclose);
                    olfactometerSetFinalValve(h2, slave, logger, vclose);
                end
                return;
            end
            
            wateropen=false;
            pause(0.05);
            
            %at the end of water giving we have to make an inter trial
            %interval, is done with the specific function
            if (lev.levelNumber>6)
                insideInterTrial=true;
                valveopen = pauseWithOlfactionClosing(valveTimer,h2,logger,valveNumber,lev.interTrialInterval,lev.odorPeriod);
                insideInterTrial=false;
            else
                pause(lev.interTrialInterval)
            end
        end
    elseif (data(2)==0 && (data(3)==0))
        disconn=true;
    end
    
    if(toc(beamTimer)>lev.interTrialInterval)
    beamTimer=tic;
    end
    if (lev.levelNumber>6 && valveopen)
        %%here we want to close the olfactometer after 1sec
        if (toc(valveTimer)>lev.odorPeriod)
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
            toc*1000
            firsLick=true;
            lickCounter=0;
            lickCounterB=0;
            trialInit=false;
        end
    end
end

end

function valveopen = pauseWithOlfactionClosing(valveTimer,h2,logger,valveNumber,interTrialInterval,odorPeriod)
%%this function is an artifical delay in order to close olfactometer during
%%intertrial interval
loopTic=tic;
tmp=true;
while (toc(loopTic)<interTrialInterval)
    
    if (toc(valveTimer)>odorPeriod && tmp)
        olfactometerSetOder(h2, 1, logger, valveNumber, 0);
        olfactometerSetFinalValve(h2, 1, logger, 0);
        valveopen=false;
        tmp=false;
    end
end

end
