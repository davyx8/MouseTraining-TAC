function olfactometerSetFinalValve( h2, slave, logger, open )
%OLFACTOMETERSETFINALVALVE opens or closes final valve
%   

    %logger.prelog();

    invoke(h2, 'SetGateValve2', slave, 31, open, 0);

%     logger.log(LogEvents.setFinalValve, open);
% 
%     oc={'close','open'};
%     ['final valve ' oc{open+1}]
    
end

