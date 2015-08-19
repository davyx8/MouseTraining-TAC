function varargout = StartExperiment(varargin)
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

% Last Modified by GUIDE v2.5 18-Aug-2015 21:09:54

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
closeOlfactometer
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
display('dudeeee')
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
% x.addDigitalChannel('Dev1','port0/line1' , 'InputOnly');
% valveopen=false;
lickTimer=0;
valveTimer=0;
valveOpeningTime=lev.valveOpeningTime;
loggingThresh=lev.timeWindow;
wateropen = false;
%x=dev;

headIn=false;
%stuff to count


insideInterTrial=false;
attempts=0;
firsLick=true;
firstBeam=true;
dataResults=[valveCount;valveCount;valveCount;valveCount];
if(valveCount==0)
    dataResults=ones(4,1);
end
vopen=1;
vclose=0;
slave=1;

notWrriten=true;
wasntLogged=true;
%diffrence=diff([a' ones(length(a),1)*max(a)]')

delay=lev.delay;
lickCounter=0;
disconnA=true;
disconnB=true;
trialInit=true;
valveopen=false;
breaking=false;
waterWasGiven=false;
samplingTimer=tic;
falseTrial=false;
%olf init
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
    if(insideInterTrial)
        continue
    end
    
    % loop is broken only when successCount>=lev.successesNeeded
    if(valveCount>lev.numberofTrials)
        closeEvs(h2);
        %LogResultsWhenPausing(lev,valveCount,valveNumber,lickCounter,waterWasGiven,handles);
        obj=lev;
        save(str,'obj');
        return
    end
    %scanning to get data from electronic box
    
    data=x.inputSingleScan();
    
    dataVec=[];
    
    if(valveTimer~=0)
       
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
                %  guidata()
                pause(0.001);
            end
        end
        
    end
    
    
    
    if (data(1)==1 && ~headIn)
        
        if( valveTimer==0 || toc(valveTimer)>lev.interTrialInterval)
            % we get here when beam (data(1)) is broken AND it wasnt already
            % broken before (headIn)
            %we increase the number of trials every time beam is re-broken
            %currTrials=currTrials+1;
            headIn=true;
            firstBeam=false;
            lickCounter=0;
            firsLick=true;
            time=fix(clock);
            valveLock = 0;
            falseTrial=false;
            if(~valveopen)
                % if we are in levels 7-8 we open the desired valve
                % and final valve (with specified delay)
                %notice that of the valve is alreday open we dont get in here
                valveCount=valveCount+1;
                waterWasGiven=false;
                if (valveCount>lev.numberofTrials)
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
                set(handles.Trial, 'String', num2str(valveCount));
                valveNumber=randomValves(valveCount);
                if(valveCount+1<=numel(randomValves))
                    nextValve=randomValves(valveCount+1);
                else
                    nextValve=999;
                end
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
                olfactometerSetOder(h2, slave, logger, valveNumber, vopen);
                
                openingTimer=tic;
                
                while(delay-toc(openingTimer) > 0.01)
                    
                end
                olfactometerSetFinalValve(h2, slave, logger, vopen);
                valveTimer=tic;
                samplingTimer=tic;
                valveopen=true;
            end
        end
    elseif (data(1)==0 && ~firstBeam)
        %if beam is unbroken (==0) AND beam was broken before  (first beam)
        %if we didnt give water we count it as a miss
        headIn=false;
        %we want to signal that a trial has been re-initiated
        trialInit=true;
        %   lickCounter=0;
        %we save the data from this trial to the vector
        % and add it to the data results
    end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    if ( (data(3)==1 && valveLock==2)  || (data(2)==1 && valveLock==3))
        falseTrial=true;
    end
    
    
    
    
    
    
    %%alternative choice -- second valve
    
    if (data(3)==1 && ~wateropen && disconnB && trialInit && ...
            toc(valveTimer)<lev.interTrialInterval & ~waterWasGiven & toc(valveTimer)>finalValveLickDelay & valveLock~=2 &...
            ~falseTrial)
        %here we check if lick was preformed AND THAT:
        %~wateropen- water ISNT open
        %disconn -the mouse disconnected the tongue completly
        %so as not to count continous engagements as one lick
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
        lev.lickThresh
        if (lickCounter>=lev.lickThresh & intersect(valveNumber,lev.noRewardValve)==valveNumber & ~waterWasGiven)
            %%this is the stage wqe were all waitiing for
            %we check wether:
            %   A.the mouse did enough licks
            %   B. the licks were all done in the specified time window
            %giving water
            wateropen=true;
            
            
            display('water was given')
            time=fix(clock);
            %we open the water for the specified giving period
            x.outputSingleScan([0 1]);
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
        disconnB=true;
    end
    %alternative choice second valve
    
    if (data(2)==1 && ~wateropen && disconnA && trialInit && ...
            toc(valveTimer)<lev.interTrialInterval & ~waterWasGiven & toc(valveTimer)>finalValveLickDelay & valveLock~=3 &...
        ~falseTrial)
        %here we check if lick was preformed AND THAT:
        %~wateropen- water ISNT open
        %disconn -the mouse disconnected the tongue completly
        %so as not to count continous engagements as one lick
        %trial has been reinitialized after time window passed
        %see below
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
            %%this is the stage wqe were all waitiing for
            %we check wether:
            %   A.the mouse did enough licks
            %   B. the licks were all done in the specified time window
            %giving water
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
            %lickCounter=0;
            firsLick=true;
            
            trialInit=false;
            %dataResults=[]
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
            
            %we pause for two seconds after closing
            %  pause(2)
        end
    end
    %if(lickTimer~=0)
    %         %we want to reinit the trial in case the time window passed
    %         % we also want to zero the lickcounter
    %         %also make sure the firstlick is set to true
    %    if (toc(lickTimer) >lev.timeWindow )
    %             [waterWasGiven,firsLick,lickCounter,trialInit ] =...
    %                 LogResultsWhenPausing(lev,valveCount,valveNumber,lickCounter,waterWasGiven,handles);
    %                 wasntLogged=false;
    
    %    end
    %end
    guidata(hObject, handles);
end
lev.currentValve=valveCount
obj=lev
obj.mouseName='fuckyourmama'
save(str,'obj');
helpdlg('Thanks for Your participation!')
helpdlg(sprintf('mouse reached trial number: %d out of %d trials',valveCount,lev.numberofTrials));
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
    %     if (toc(lickTimer) >lev.timeWindow && notWritten && tmp2)
    %         [waterWasGiven,firsLick,lickCounter,trialInit ] =...
    %             LogResultsWhenPausing(lev,valveCount,valveNumber,lev.lickThresh,true,handles);
    %         tmp2=false;
    %     end
end

function [samplingTimer dataResults] =LogDataWhenPausing(x,samplingTimer,dataResults,valveTimer)
data=x.inputSingleScan();
if(toc(samplingTimer)>=0.01)
    dataVec=[data(2); toc(valveTimer) ; data(1); data(3)];
    dataResults=[dataResults dataVec];
    samplingTimer=tic;
end

function[waterWasGiven,firsLick...
    lickCounter,trialInit ] =...
    LogResultsWhenPausing(lev,valveCount,valveNumber,lickCounter,waterWasGiven,handles,falseTrial)

display('lickcounter zerored')
if (waterWasGiven)
    if(intersect(valveNumber,lev.rewardValve)==valveNumber)
        set(handles.Result, 'String', 'HIT CHOICE A');
        dlmwrite(lev.trialPath,[valveCount,valveNumber,1,0,0,0],'-append');
    elseif (intersect(valveNumber,lev.noRewardValve)==valveNumber)
        set(handles.Result, 'String', 'HIT CHOICE B');
        dlmwrite(lev.trialPath,[valveCount,valveNumber,0,0,1,0],'-append');
    end
else
    if (falseTrial)
        set(handles.Result, 'String', 'FAILED TRIAL');
    elseif(intersect(valveNumber,lev.rewardValve)==valveNumber & lickCounter>0)
        dlmwrite(lev.trialPath,[valveCount,valveNumber,0,1,0,0],'-append');
        set(handles.Result, 'String', 'FALSE ALARM CHOICE A');
    elseif (intersect(valveNumber,lev.noRewardValve)==valveNumber & lickCounter>0)
        set(handles.Result, 'String', 'FALSE ALARM CHOICE B ');
        dlmwrite(lev.trialPath,[valveCount,valveNumber,0,0,0,1],'-append');
    elseif (lickCounter==0)
        set(handles.Result, 'String', 'MISS ');
        dlmwrite(lev.trialPath,[valveCount,valveNumber,0,0,0,0],'-append');
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


% --- Executes when selected cell(s) is changed in uitable1.
function uitable1_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
set(handles.uitable1, 'Data', zeros(2,20));
