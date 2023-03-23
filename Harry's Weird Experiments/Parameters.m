%% dimensions of robot body parts

%dimensions of central robot body
bodyLength=0.7;
bodyWidth=0.5;
bodyThickness=0.15;
body=[bodyLength bodyWidth bodyThickness];

%length of side of shoulder cube
shoulderSize=0.15;
shoudler=[shoulderSize shoulderSize shoulderSize];

%upper arm dimensions
armThickness=shoulderSize;
armWidth=armThickness;
armLength=0.5;
arm=[armThickness armWidth armLength];

%ball foot dimensions
footDiameter=0.1;
beamDiameter=0.1;

%code used to work out the length of the beam that comprises the body of
%the lower arm
%armSkelLength is the length of the kinematic skeleton that connects the
%shoulder and elbow joints
armSkelLength=armLength-shoulderSize;
smallArmLength=armSkelLength-shoulderSize/2;
beamLength=smallArmLength-footDiameter;


%calculations of overall width, height and length of quadruped
OverallLength=bodyLength+2*shoulderSize
OverallWidth=2*(bodyWidth/2+shoulderSize/2+armThickness)
OverallHeight=armLength+smallArmLength

%% calculation of rigid body transforms from central body to first revolute
... joint to second revolute joint

%Front right rigid body transforms
%first transform from centre to revolute joint position on body for first
%shoulder joint
FR1=[bodyLength/2 bodyWidth/2 0];
%second rigid body transform from first revolute joint to shoulder centre
FR2=[shoulderSize/2 0 0];
%third transform from shoulder centre to second revolute joint
FR3=[0 shoulderSize/2 0];

%Front left transforms
FL1=[bodyLength/2 -bodyWidth/2 0];
FL2=[shoulderSize/2 0 0];
FL3=[0 -shoulderSize/2 0];

%Back right transforms
BR1=[-bodyLength/2 bodyWidth/2 0];
BR2=[-shoulderSize/2 0 0];
BR3=[0 shoulderSize/2 0];

%Back left transforms
BL1=[-bodyLength/2 -bodyWidth/2 0];
BL2=[-shoulderSize/2 0 0];
BL3=[0 -shoulderSize/2 0];




%% calculation of rigid body transforms from the shoulder joints to the 
...the bottom of foot

%Right leg rigid body transforms
%First transform from revolute joint to upper arm centre
R1=[0 armWidth/2 -armSkelLength/2];
%Second transform from upper arm centre to elbow revolute joint
R2=[0 -armWidth/2 -armSkelLength/2];
%Third transform from elbow joint to elbow block centre
R3=[0 -shoulderSize/2 0];
%fourth transform from elbow block centre to beam
R4=[0 0 -shoulderSize/2];
%fith transform from beam start to beam centre
R5=[0 0 -beamLength/2];
%sixth transform from beam centre to beam end
R6=[0 0 -beamLength/2];
%seventh transform from beam end to foot centre
R7=[0 0 -footDiameter/2];

%Left leg rigid body transforms
L1=[0 -armWidth/2 -armSkelLength/2];
L2=[0 armWidth/2 -armSkelLength/2];
L3=[0 shoulderSize/2 0];
L4=[0 0 -shoulderSize/2];
L5=[0 0 -beamLength/2];
L6=[0 0 -beamLength/2];
L7=[0 0 -footDiameter/2];

