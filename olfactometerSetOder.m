function olfactometerSetOder( h2, slave, logger, oder, open )
%OLFACTOMETERSETODER opens or closes oder valve



    logger.prelog();
    
    invoke(h2, 'SetOdorValve', slave, oder, open);   
    
    logger.log(LogEvents.setOderValve, oder*open);
    %                                      ^-if open=1 logs oder otherwise 0

%     oc={'closed','opened'};
%     [oc{open+1} ' oder valve number: ' num2str(oder)]
%     
end

