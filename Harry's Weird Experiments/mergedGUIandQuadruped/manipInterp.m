desiredState=[1,1,1,1,1,1,1];
currentAngles=[0,0,0,0,0,0,0];
time=0;
function [angleRangeOut,timeRangeOut]  = manipInter(desiredAngles,currentAngles,time)

persistent beginState
persistent justChanged
% persistent interval
persistent startTime
persistent angleRange
persistent timeRange

if isempty(beginState)
    beginState=transpose(currentAngles);
end
if isempty(justChanged)
    justChanged=0;
end
% if isempty(interval)
%     interval=0.01;
% end
if isempty(startTime)
    startTime=10;
end
if isempty(angleRange)
    angleRange=[transpose(currentAngles),transpose(currentAngles)];
end
if isempty(startTime)
    timeRange=[0,600];
end
%timeSteps=0.01;
transferTime=3;
%calcTime=timeSteps/transferTime;

if beginState~=transpose(desiredAngles)
    if justChanged==0
        beginState=transpose(currentAngles);
        %interval=((desiredAngles-beginState)./calcTime);
        startTime=time;
        justChanged=1;
        endTime=transferTime+startTime;
        timeRange=[startTime,endTime];
        angleRange=[beginState,transpose(desiredAngles)];
    end
else
    justChanged=0;
    timeRange=[0,600];
    angleRange=[transpose(currentAngles),transpose(currentAngles)];
end
angleRangeOut=angleRange;
timeRangeOut=timeRange;
end