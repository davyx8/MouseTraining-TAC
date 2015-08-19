function [ h, resultOpen, resultLastError, resultID ] = olfactometerConnect( logger, lasomID )
%OLFACTOMETERCONNECT obtain a handle to the olfactometer
%   [ h resultOpen resultLastError resultID ] = olfactometerConnect( lasomID )
%   in:
%   lasomID - (optinal default=0) olfactometer ID
%   out:
%   h - olfactometer handle
%   resultOpen - result of open operation 
%   resultLastError - last error
%   resultID - board ID

    if(nargin <= 1)
        lasomID = 0;
    end 
    
    h = actxcontrol('LASOMX.LASOMXCtrl.1');
    resultOpen = invoke(h, 'DevOpen', lasomID, 1);
    resultLastError = invoke(h, 'GetLastError');
    resultID = invoke(h, 'GetID');
    logger.h2=h;
    logger.prelog();
    pause(0.2);
    logger.log(LogEvents.connect, resultOpen);
    
    'connected to olfactometer'
end

