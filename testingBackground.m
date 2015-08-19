function WDF
x=daq.createSession('ni');
x.IsContinuous = true;
x.addDigitalChannel('Dev1','port1/line1' , 'InputOnly');
lh = addlistener(x,'DataAvailable', @plotData); 
 x.Rate=-10
counter=0;
function plotData(src,event)
     counter=counter+1;
     counter
     event
end
tmp=0
t=0
while(true)   
tmp=t;
[data t]=x.inputSingleScan();
tmp-t
end

end