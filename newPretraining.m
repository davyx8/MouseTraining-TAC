clear all
close all
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

currLevel=Level2AC
%path=sprintf('mouse1_%d_%d_%d_%d_%d_%d.csv',fix(clock()));
path=sprintf('mouse1.csv');
% % % comment: level 1
% % %% lickthreshold is zero
% % % mouse gets water immideatly
currLevel.levelNumber=1;
currLevel.successesNeeded=1;
currLevel.interTrialInterval=0;
pass=false;
currLevel.timeWindow=inf;
while(~pass)
    display( 'Mouse is still on level one');
    [pass data]=LevelHandler(x,currLevel);
    level1=ones(size(data,1),1);
    data=[level1 data];
    dlmwrite(path,data,'-append');
end

    display( 'Mouse is still on level two');
% % % % level 2
% % % % lickthreshold is 2
% % % % mouse gets water after than
currLevel.successesNeeded=1;
pass=false;
currLevel.lickThresh=1;
currLevel.interTrialInterval=0;
currLevel.levelNumber=2;
while(~pass)
    display( 'Mouse is still on level two');
    [pass data]=LevelHandler(x,currLevel);
    level2=2*ones(size(data,1),1);
    data=[level2 data];
    dlmwrite(path,data,'-append');
end

% % %%level 3
% % %%lickthreshold is 3

currLevel.timeWindow = 2000;
currLevel.successesNeeded=3;
pass=false;
currLevel.lickThresh=1;
currLevel.levelNumber=3;
while(~pass)
    display( 'Mouse is still on level three');
    [pass data]=LevelHandlerPRO(x,currLevel);
    level3=3*ones(size(data,1),1);
    data=[level3 data];
    dlmwrite(path,data,'-append');
end
% % % 
% % % % level 4
% % % % lickthreshold is 4
currLevel.successesNeeded=5;
pass=false;
currLevel.lickThresh=1;
currLevel.interTrialInterval=2;
currLevel.levelNumber=4;
currLevel.timeWindow = 2000;
while(~pass)
    display( 'Mouse is still on level four');
    [pass data]=LevelHandlerPRO(x,currLevel);
    level4=4*ones(size(data,1),1);
    data=[level4 data];
    dlmwrite(path,data,'-append');
end
 
 display('the end')
