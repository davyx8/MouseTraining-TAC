classdef StimulusStages
    %STIMULUSSTAGES Summary of this class goes here
    %   Detailed explanation goes here 
    
    properties
        code=-1;
    end
    
    methods
        function SS = StimulusStages(c)
            SS.code = c;
        end
    end
    
    enumeration
        preSimulus(1)
        stimulus(2)
        postStimulus(3)
        interStimulus(4)
    end
end



