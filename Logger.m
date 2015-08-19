classdef Logger < handle
    %LOGGER holds reference to log file and buffers log;
    %   
    
    properties
        filePath;
        h2;
    end
    
    
    properties(SetAccess = private)
        bufferLength = 1000;
        niBufferLength = 5000;
        niBufferWidth = 5000;
        logBuffer = zeros(1000,4);
        niLogBuffer;
        niBufferIndex = 1;
        bufferIndex = 2;
        logClock;
        niSession;
        niChannels;
        prelogTic = [];
        lastSyncSignalStopTic = [];
        syncSignalStart; 
        syncSignalStop;
        isINFirstLog = false;
        
    end
    
    methods
        function L = Logger(path, syncSignalStart, syncSignalStop)
            L.filePath = path;
            L.logClock = tic;
            L.logBuffer(1,1) = now;
            if(nargin>1)
                L.syncSignalStart = syncSignalStart;
                if(nargin>2)
                    L.syncSignalStop = syncSignalStop;
                end
            end
        end
        
        function prelog(L)
            if(~isempty(L.syncSignalStart))
                if(~isempty(L.lastSyncSignalStopTic))
                    dur = toc(L.lastSyncSignalStopTic);
                    if(dur<0.003)
                        pause(0.003-dur);
                    end
                end
                L.syncSignalStart(L.h2);
            end
            L.prelogTic = tic();
        end
        
        function log(L, type, value)
            if(isempty(L.prelogTic))
                duration = -1;
            else
                duration = toc(L.prelogTic);
                
                if(~isempty(L.syncSignalStop))
                    L.lastSyncSignalStopTic = tic();
                    L.syncSignalStop(L.h2);
                end
            end
            
            
            L.prelogTic = [];
            
            L.logBuffer(L.bufferIndex,:) = [toc(L.logClock),...  
                                        type.code,...
                                        value,...
                                        duration];

            L.bufferIndex = L.bufferIndex+1;
            if(L.bufferIndex > L.bufferLength-2)
                L.flush();
            end
        end  
        
        function [session, channels_h] = initNILog(L, devices, channels, measurementTypes) 
            if(~isempty(L.niSession))
                error('ni log session can be created only once');
            end
            display('REACHED')
            L.niBufferWidth = length(channels)+1;
            L.niLogBuffer = zeros(L.niBufferLength,L.niBufferWidth);
            
            session = daq.createSession('ni');
            session.IsContinuous = true;
            
            if(ischar(channels))
                channels = {channels};                
            end
            if(isnumeric(channels))
                channels = mat2cell(channels);
            end 
            for i=1:length(channels)
                getCellOrSelf(devices,i)
                channels_h(i) = session.addAnalogInputChannel(...
                                    getCellOrSelf(devices,i),...
                                    channels{i},... 
                                    getCellOrSelf(measurementTypes,i));
            end
            
            session.addlistener('DataAvailable', @niHandler);
            
            function niHandler(src, event)
                if(L.niBufferIndex+length(event.TimeStamps)>=L.niBufferLength)
                    L.flush();
                end
                
                if(L.isINFirstLog)
                    toc(L.logClock)
                    event.TriggerTime
                    now
                     L.niLogBuffer(L.niBufferIndex,1) = event.TriggerTime;
                     L.niBufferIndex = L.niBufferIndex+1;
                     L.isINFirstLog = false;
                end
                L.niLogBuffer(L.niBufferIndex:(L.niBufferIndex+length(event.TimeStamps)-1),:) = ...
                                [event.TimeStamps event.Data];
                
                L.niBufferIndex = L.niBufferIndex+length(event.TimeStamps);
            end
            
            L.niSession = session;
            L.niChannels = channels_h;
        end
        
        function startNILog(L)
            if(isempty(L.niSession))
                error('Logger.initNILog must be called before Logger.startNILog');
            end
            L.isINFirstLog = true;
            L.niSession.startBackground();
        end
        
        function stopNILog(L)
            if(isempty(L.niSession))
                error('Logger.initNILog must be called before Logger.stopNILog');
            end
            L.niSession.stop();
        end
        
        function close(L)
            if(~isempty(L.niSession))
                L.stopNILog();
            end
            L.flush();
        end
        
        function flush(L)
            dlmwrite([L.filePath '\eventLog.csv'],...
                L.logBuffer(1:(L.bufferIndex-1),:),'-append','precision', '%.8f');
            L.bufferIndex = 1;
            
            
            dlmwrite([L.filePath '\niLog.csv'],...
                L.niLogBuffer(1:(L.niBufferIndex-1),:),'-append','precision', '%.8f');
            L.niLogBuffer = zeros(L.niBufferLength, L.niBufferWidth);
            L.niBufferIndex = 1;
        end
    end
    
end

