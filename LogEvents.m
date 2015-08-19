classdef LogEvents
    %LOGEVENTS enum for log events
    %   
    properties
        code=-1;
    end
    
    methods
        function LE = LogEvents(c)
            LE.code = c;
        end
    end
    
    methods(Static)
        function LE = setMFC(MFC)
            if(MFC == 1)
                LE=LogEvents.setMFC1;
            else
                LE=LogEvents.setMFC2;
            end
        end
        function LE = sampleMFC(MFC)
            if(MFC == 1)
                LE=LogEvents.sampleMFC1;
            else
                LE=LogEvents.sampleMFC2;
            end
        end
    end
    
    enumeration
        connect(1)
        setMFC1(2)
        setMFC2(3)
        sampleMFC1(4)
        sampleMFC2(5)
        setOderValve(6)
        setFinalValve(7)
        stimulusStage(8)
        trigger(9)
        setSolenoid(10)
    end
end

