function activePause( time, log, h2, slave )
%ACTIVEDELAY Flushes the log and logs MFC's for given time
%   
    t=tic;
    
    %TODO send sync signal

    %sample MFCs
    MFC = 1;
    sw = [2 1];
    
    while(time-toc(t) > 0.55)
        olfactometerSampleMFC(h2, slave, log, MFC);
        MFC = sw(MFC); %switch 1 to 2 and 2 to 1
        drawnow
    end
    
    %flush log
    if(time-toc(t) > 0.5)
        log.flush();
    end
    
    while(time-toc(t) >= 0)
        pause((time-toc(t))*0.5);
    end

end

