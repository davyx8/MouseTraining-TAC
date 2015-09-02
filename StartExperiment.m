function varargout = StartExperiment(varargin)

% look for zehBest function
% STARTEXPERIMENT MATLAB code for StartExperiment.fig
%      STARTEXPERIMENT, by itself, creates a new STARTEXPERIMENT or raises the existing
%      singleton*.
%
%      H = STARTEXPERIMENT returns the handle to a new STARTEXPERIMENT or the handle to
%      the existing singleton*.
%
%      STARTEXPERIMENT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STARTEXPERIMENT.M with the given input arguments.
%
%      STARTEXPERIMENT('Property','Value',...) creates a new STARTEXPERIMENT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before StartExperiment_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to StartExperiment_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help StartExperiment

% Last Modified by GUIDE v2.5 16-Mar-2015 07:09:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @StartExperiment_OpeningFcn, ...
    'gui_OutputFcn',  @StartExperiment_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before StartExperiment is made visible.
function StartExperiment_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to StartExperiment (see VARARGIN)

% Choose default command line output for StartExperiment
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
global mouseObj
global str
answer = inputdlg('Enter Mouse Name for experiment')
str=sprintf('%s/%s.mat',answer{1},answer{1})
try
    load(str);
catch err
    obj=levelEntry
    mouseObj=obj;
end
mouseObj=obj;
save(str,'obj')
set(handles.Trial, 'String', num2str(mouseObj.currentValve));


% UIWAIT makes StartExperiment wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = StartExperiment_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Training
ZehBest(handles,hObject)
handles.edit1.String=553;
handles.edit1
hObject
% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton1.
function pushbutton1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global closeTraining
closeTraining=false;

% for i=1:100
% set(handles.Trial, 'String',num2str(i));
% set(handles.Valve, 'String', num2str(var2(mod(i,10)+1)));
% set(handles.Result, 'String', var(mod(i,4)+1));
% pause(0.01)
% end
%closeOlfactometer
%close all
%clear all


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function ZehBest(handles,hObject)

global closeTraining
global mouseObj
global str
global x
closeTraining=true;
global hitA
global hitB
global FAA
global FAB
global miss
global failedTrials
hitA=0;
hitB=0;
FAA=0;
FAB=0;
miss=0;
failedTrials=0;
lev=mouseObj
finalValveLickDelay=0.25;
if (isempty(lev.randomValves))
    randomValves=generateRandOdor2(lev.noRewardValve,lev.rewardValve,lev.numberofTrials);
    [a,b]=hist(randomValves,unique(randomValves));
    valveCount=0;
    lev.randomValves=randomValves;
    dlmwrite(lev.valveSequencePath,randomValves');
else
    randomValves=lev.randomValves;
    valveCount=lev.currentValve;
end

%%ni session init.
x=daq.createSession('ni');
x.IsContinuous = true;
%Beam
x.addDigitalChannel('Dev1','port0/line2' , 'InputOnly');
%Lick
x.addDigitalChannel('Dev1','port0/line5' , 'InputOnly');
%Lick 2
x.addDigitalChannel('Dev1','port0/line6' , 'InputOnly');
% valve 1
x.addDigitalChannel('Dev1','port0/line0' , 'OutputOnly');
% valve 2
x.addDigitalChannel('Dev1','port0/line1' , 'OutputOnly');


%%timers and time constants, lick and valve most important ones
lickTimer=0; %timer for lick ocunting (time-window)
valveTimer=0; %timer for closing the final valve
valveOpeningTime=lev.valveOpeningTime;
loggingThresh=lev.timeWindow;

%%logging , data results holds the info about the valve #
dataResults=[valveCount;valveCount;valveCount;valveCount];
if(valveCount==0)
    dataResults=ones(4,1);
end

%juist overhead, dont delete
vopen=1;
vclose=0;
slave=1;


delay=lev.delay;
lickCounter=0;

%%booleans
disconnA=true; %disconnect booleans, for proper lick counting
disconnB=true;
trialInit=true; %boolean to indicate trial initialization
valveopen=false; %boolean to indicate whether final valve is open
waterWasGiven=false; %boolean to indicate whether water was given for logging
samplingTimer=tic; %boolean to track logging timing , explaine later
falseTrial=false; %on 2AC false trials exist, ask lena for criteria , ex
wateropen = false; %self explanatory
insideInterTrial=false;
firsLick=true; %indicates whther this is the first lick of the trial
notWrriten=true; %logging boolean , so not to duplicate
firstBeam=true; %indicates whether this is the first beam breaking in the trial
headIn=false; %boolean to indicate the mouse head is currently breaking the beam

%olfactometer initialization
traileID=sprintf('pelegLOG_%d_%d_%d_%d_%d_%d.csv',fix(clock()));
logger = Logger(traileID,...
    @(h2) invoke(h2, 'SetDigOut', 1 ,1 ,0),...
    @(h2) invoke(h2, 'SetDigOut', 1 ,0 ,0));
[ h2, resultOpen, resultLastError, resultID]= olfactometerConnect(logger);
olfactometerSetOder(h2, slave, logger, 2, vopen);
olfactometerSetFinalValve(h2, slave, logger, vopen);
olfactometerSetOder(h2, slave, logger, 2, vclose);
olfactometerSetFinalValve(h2, slave, logger, vclose);
valveLock=0;

while (true & closeTraining)
    % ok this is the main loop data aquisition, its amateur but easy to code
    %a bit clumsy too, but it works.
    % closeTraining is the
    
    if(insideInterTrial)
        %if we are in the intertrial interval we dont even start
        continue
    end
    
    if(valveCount>lev.numberofTrials)
        closeEvs(h2); %closes the gui and olf.
        obj=lev;
        save(str,'obj');
        return % :) end of experiment
    end
    
    %THIS IS THE AQUISITION, BEGIN DEBUGGING HERE, make sure there are no
    %hardware issues before blaming the code
    data=x.inputSingleScan();
    
    %used for logging
    dataVec=[];
    
    if(valveTimer~=0)
        %% this is used for logging
        %% we store up data untill we reach loggingthresh
        %% then we writ to the file
        %% we sample every 10 milisec. as can be seen
        if(toc(valveTimer)<loggingThresh)
            notWrriten=true;
            if(toc(samplingTimer)>=0.01)
                dataVec=[data(2); toc(valveTimer) ; data(1); data(3)];
                dataResults=[dataResults dataVec];
                samplingTimer=tic;
            end
            
            if (get(handles.pushbutton3,'Value')==1)
                pushbutton3_Callback(hObject,[],handles);
            end
        else
            if(notWrriten)
                %   if(intersect(valveNumber,lev.rewardValve)==valveNumber)
                dlmwrite(lev.lickFirstPath,dataResults(1,:),'-append');
                dlmwrite(lev.beamPath,dataResults(3,:),'-append');
                dlmwrite(lev.lickSecondPath,dataResults(4,:),'-append');
                %  end
                dlmwrite(lev.timePath,dataResults(2,:),'-append');
                LogResultsWhenPausing(lev,valveCount,valveNumber,lickCounter,waterWasGiven,handles,falseTrial);
                valveLock=0;
                lickCounter=0;
                dataResults=[valveCount+1;valveCount+1; valveCount+1;valveCount+1];
                notWrriten=false;
            else
                % there has to be a way to remove this and optimize the
                % code.
                pause(0.001);
            end
        end
        
    end
    
    
    
    if (data(1)==1 && ~headIn)
        
        if( valveTimer==0 || toc(valveTimer)>lev.interTrialInterval)
            % we get here when beam (data(1)) is broken AND it wasnt already
            % broken before (headIn)
            %lickcount is reinit, and the olfact. is opened
            headIn=true;
            firstBeam=false;
            lickCounter=0;
            firsLick=true;
            time=fix(clock);
            valveLock = 0;
            falseTrial=false;
            if(~valveopen)
                %notice that of the valve is alreday open we dont get in here
                valveCount=valveCount+1;
                waterWasGiven=false;
                if (valveCount>lev.numberofTrials)
                    %% this is for the end of the training session, everything will be closed
                    closeEvs(h2);
                    if(notWrriten)
                        LogResultsWhenPausing(lev,valveCount,valveNumber,lickCounter,waterWasGiven,handles,falseTrial);
                        valveLock=0;
                        falseTrial=false;
                    end
                    obj=lev
                    obj.mouseName='fuckyourmama2'
                    save(str,'obj');
                    return;
                end
                %update gui
                set(handles.Trial, 'String', num2str(valveCount));
                % updatoing which valve will be opened
                valveNumber=randomValves(valveCount);
                
                if(valveCount+1<=numel(randomValves))
                    nextValve=randomValves(valveCount+1);
                else
                    nextValve=999;%last trial
                end
                %gui
                set(handles.Valve, 'String', num2str(valveNumber));
                set(handles.nextValve, 'String', num2str(nextValve));
                if(intersect(valveNumber,lev.rewardValve)==valveNumber)
                    set(handles.Reward, 'String', 'Choice A');
                else
                    set(handles.Reward, 'String', 'Choice B');
                end
                if(intersect(nextValve,lev.rewardValve)==nextValve)
                    set(handles.nextRewarded, 'String', 'Choice A');
                else
                    set(handles.nextRewarded, 'String', 'Choice B');
                end
                
                % the moment we all waited for , opening olf.
                olfactometerSetOder(h2, slave, logger, valveNumber, vopen);
                
                openingTimer=tic;
                
                while(delay-toc(openingTimer) > 0.01)
                    %busy wait loop till ododr reaches FV
                end
                olfactometerSetFinalValve(h2, slave, logger, vopen);
                valveTimer=tic;
                samplingTimer=tic;
                valveopen=true;
            end
        end
    elseif (data(1)==0 && ~firstBeam)
        %if beam is unbroken (==0) AND beam was broken before  (first beam)
        headIn=false;
        %we want to signal that a trial has been re-initiated
        trialInit=true;
    end
    
    if ( (data(3)==1 && valveLock==2)  || (data(2)==1 && valveLock==3))
        %% the logic here is: if the valveLock is on one valve, and mouse licked the other
        %% then trial is falsified
        falseTrial=true;
    end
    
    
    %% alternative choice -- second valve
    
    if (data(3)==1 && ~wateropen && disconnB && trialInit && ...
            toc(valveTimer)<lev.interTrialInterval & ~waterWasGiven & toc(valveTimer)>finalValveLickDelay & valveLock~=2 &...
            ~falseTrial)
        %here we check if lick was preformed AND THAT:
        
        %~wateropen- water ISNT open
        
        % disconnB - the mouse disconnected the tongue from B-lickometer
        % trialInit - that a new trial started 
        % toc(valveTimer) etc. - that intertrial didnt pass. 
        % waterWasGiven-water wasnt given yet
        % valveTimer- checking time window didnt pass 
        % valveLock isnt set on the alternative 
        % trial wasnt falsified 
        %trial has been reinitialized after time window passed
        %see below
        disconnB=false;
        
        if firsLick
            %if this is the first lick in the trial we want to start the
            %clock for the time window (to ocunt the licks)
            display('licktimer has been reinit')
            lickTimer=tic;
            wasntLogged=true;
            firsLick=false;
            valveLock=3
            
        end
        if toc(lickTimer)<=lev.timeWindow
            lickCounter=lickCounter+1
        end
        set(handles.Licks, 'String', num2str(lickCounter));
        guidata(hObject, handles);
        if (lickCounter>=lev.lickThresh & intersect(valveNumber,lev.noRewardValve)==valveNumber & ~waterWasGiven)
            %% this is the stage where we give water if all conditions were
            %% met 
            % we check wether:
            %  the mouse did enough licks
            %  the licks were all done in the specified time window
            %  this is the correct valve 
            
            %giving water
            wateropen=true;
            display('water was given')
            time=fix(clock);
            
            %we open the water for the specified giving period
            x.outputSingleScan([0 1]); %we open the B tap
            %pause(lev.waterGivePeriod);
            waterTimer=tic;
            while(toc(waterTimer)<lev.waterGivePeriod && toc(valveTimer)<loggingThresh )
                [samplingTimer dataResults] =LogDataWhenPausing(x,samplingTimer,dataResults,valveTimer);
            end
            x.outputSingleScan([0 0]);
            
            waterWasGiven=true;
            wateropen=false;
            %at the end of water giving we have to make an inter trial
            %interval, is done with the specific function
            insideInterTrial=true;
            %lickCounter=0;
            firsLick=true;
            
            trialInit=false;
            %dataResults=[]
            insideInterTrial=false;
            
        end
    elseif (data(3)==0)
        % mouse discon. tongue from b
        disconnB=true;
    end
    %alternative choice second valve
    
    if (data(2)==1 && ~wateropen && disconnA && trialInit && ...
            toc(valveTimer)<lev.interTrialInterval & ~waterWasGiven & toc(valveTimer)>finalValveLickDelay & valveLock~=3 &...
            ~falseTrial)
        %see docs for B 
        disconnA=false;
        
        if firsLick
            %if this is the first lick in the trial we want to start the
            %clock for the time window (to ocunt the licks)
            display('licktimer has been reinit')
            lickTimer=tic;
            wasntLogged=true;
            firsLick=false;
            valveLock=2
        end
        if toc(lickTimer)<=lev.timeWindow
            lickCounter=lickCounter+1
        end
        set(handles.Licks, 'String', num2str(lickCounter));
        guidata(hObject, handles);
        if (lickCounter>=lev.lickThresh & intersect(valveNumber,lev.rewardValve)==valveNumber & ~waterWasGiven)
            %%see docs for B 
            wateropen=true;
            display('water was given')
            time=fix(clock);
            %we open the water for the specified giving period
            x.outputSingleScan([1 0]);
            %pause(lev.waterGivePeriod);
            waterTimer=tic;
            while(toc(waterTimer)<lev.waterGivePeriod && toc(valveTimer)<loggingThresh )
                [samplingTimer dataResults] =LogDataWhenPausing(x,samplingTimer,dataResults,valveTimer);
            end
            x.outputSingleScan([0 0]);
            waterWasGiven=true;
            wateropen=false;
            %at the end of water giving we have to make an inter trial
            %interval, is done with the specific function
            insideInterTrial=true;
            firsLick=true;
            trialInit=false;
            insideInterTrial=false;
        end
    elseif (data(2)==0)
        disconnA=true;
    end
    
    if (valveopen)
        %%here we want to close the olfactometer after 1sec
        
        
        if (toc(valveTimer)>valveOpeningTime)
            olfactometerSetOder(h2, slave, logger, valveNumber, vclose);
            olfactometerSetFinalValve(h2, slave, logger, vclose);
            valveopen=false;
        end
    end
    guidata(hObject, handles);
end

%%we exited the loop, either because of end of trials or 
lev.currentValve=valveCount
obj=lev
obj.mouseName='example1'
save(str,'obj');
helpdlg('Thanks for Your participation!')
helpdlg(sprintf('mouse reached trial number: %d out of %d trials',valveCount,lev.numberofTrials));
closeOlfactometer
close all


function valveopen = pauseWithOlfactionClosing(valveTimer,h2,logger,valveNumber,...
    interTrialInterval,valveOpeningTime,lev,dataResults,lickTimer,valveCount,handles,notWritten);
%%this function is an artifical delay in order to close olfactometer during
%%intertrial interval
loopTic=tic;
tmp=true;
tmp2=true;
while (toc(loopTic)<interTrialInterval)
    if (toc(valveTimer)>valveOpeningTime && tmp)
        olfactometerSetOder(h2, 1, logger, valveNumber, 0);
        olfactometerSetFinalValve(h2, 1, logger, 0);
        valveopen=false;
        
        tmp=false;
    end
    if(notWritten && toc())
        if(intersect(valveNumber,lev.rewardValve)==valveNumber)
            dlmwrite(lev.lickRewardedPath,dataResults(1,:),'-append');
            dlmwrite(lev.beamRewardedPath,dataResults(3,:),'-append');
        else
            dlmwrite(lev.lickUnrewardedPath,dataResults(1,:),'-append');
            dlmwrite(lev.beamUnrewardedPath,dataResults(3,:),'-append');
        end
        dlmwrite(lev.timePath,dataResults(2,:),'-append');
    end
end

function [samplingTimer dataResults] =LogDataWhenPausing(x,samplingTimer,dataResults,valveTimer)
data=x.inputSingleScan();
if(toc(samplingTimer)>=0.01)
    dataVec=[data(2); toc(valveTimer) ; data(1); data(3)];
    dataResults=[dataResults dataVec];
    samplingTimer=tic;
end
%this logs the trial info (valve, and mouse reaction classification)
% ask lena for details about criteria 
function[waterWasGiven,firsLick...
    lickCounter,trialInit ] =...
    LogResultsWhenPausing(lev,valveCount,valveNumber,lickCounter,waterWasGiven,handles,falseTrial)
global hitA
global hitB
global FAA
global FAB
global miss
global failedTrials
display('lickcounter zerored')
if (waterWasGiven)
    if(intersect(valveNumber,lev.rewardValve)==valveNumber)
        set(handles.Result, 'String', 'HIT CHOICE A');
        hitA=hitA+1;
        dlmwrite(lev.trialPath,[valveCount,valveNumber,1,0,0,0],'-append');
    elseif (intersect(valveNumber,lev.noRewardValve)==valveNumber)
        set(handles.Result, 'String', 'HIT CHOICE B');
        hitB=hitB+1;
        dlmwrite(lev.trialPath,[valveCount,valveNumber,0,0,1,0],'-append');
    end
else
    if (falseTrial)
        failedTrials=failedTrials+1;
        
        set(handles.Result, 'String', 'FAILED TRIAL');
        
        
        dlmwrite(lev.trialPath,[valveCount,valveNumber,0,0,0,0,1],'-append');
        pause(lev.timeOut)
    elseif(intersect(valveNumber,lev.rewardValve)==valveNumber & lickCounter>0)
        dlmwrite(lev.trialPath,[valveCount,valveNumber,0,1,0,0],'-append');
        set(handles.Result, 'String', 'FALSE ALARM CHOICE A');
        
        FAA=FAA+1;
        pause(lev.timeOut)
    elseif (intersect(valveNumber,lev.noRewardValve)==valveNumber & lickCounter>0)
        set(handles.Result, 'String', 'FALSE ALARM CHOICE B ');
        FAB=FAB+1;
        dlmwrite(lev.trialPath,[valveCount,valveNumber,0,0,0,1],'-append');
        pause(lev.timeOut)
    elseif (lickCounter==0)
        set(handles.Result, 'String', 'MISS ');
        miss=miss+1;
        dlmwrite(lev.trialPath,[valveCount,valveNumber,0,0,0,0],'-append');
    end
end
display(sprintf('hit A: %d',hitA))
display(sprintf('hit B: %d',hitB))
display(sprintf('False Alarm A: %d',FAA))
display(sprintf('False Alarm B: %d',FAB))
display(sprintf('failed trials: %d',failedTrials))
display(sprintf('misses: %d',miss))
if(waterWasGiven)
    dlmwrite(lev.waterPath,[valveCount 1],'-append');
else
    dlmwrite(lev.waterPath,[valveCount 0],'-append');
end
waterWasGiven=false;
firsLick=true;
lickCounter=0;
trialInit=false;

function closeEvs(h2)
for i=2:10
    invoke(h2, 'SetOdorValve', 1, i, 0);
end
invoke(h2, 'SetGateValve2', 1, 31, 0, 0);


% --- Executes during object creation, after setting all properties.
function Licks_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Licks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global x
x.outputSingleScan(1);
pause(0.3)
x.outputSingleScan(0);
