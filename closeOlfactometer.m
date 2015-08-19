close all
clear all
traileID=sprintf('pelegLOG_%d_%d_%d_%d_%d_%d.csv',fix(clock()));
logger = Logger(traileID,...
    @(h2) invoke(h2, 'SetDigOut', 1 ,1 ,0),...
    @(h2) invoke(h2, 'SetDigOut', 1 ,0 ,0));
[ h2, resultOpen, resultLastError, resultID]= olfactometerConnect(logger);
for i=2:10
% olfactometerSetOder(h2, 1, logger, i, 1);
% pause(0.1);
olfactometerSetOder(h2, 1, logger, i, 0);

end

olfactometerSetFinalValve(h2, 1, logger, 0);

close all
clear all