%% Setup for Manipulator
clearvars
addpath(genpath('U:/Manipulator'))

manipulatorModel = importrobot('sm_kinovaGen3.urdf');

grabPositionBody = rigidBody('grabPositionBody');
grabPosition = rigidBodyJoint('grabPosition','fixed');
setFixedTransform(grabPosition,[1 0 0 0;0 1 0 0;0 0 1 0.14;0 0 0 1]);
grabPositionBody.Joint = grabPosition;
addBody(manipulatorModel,grabPositionBody,'EndEffector_Link')

%% Define manipulators Home Position:
homePose = [0 0 -1 0.0575;-1 0 0 -0.0248595866020535;0 1 0 0.4;0 0 0 1];
inverseKinematicWeights = [1 1 1 1 1 1];
ik = inverseKinematics('RigidBodyTree',manipulatorModel);
[configSoln,solInfo] = ik('EndEffector_Link',homePose,inverseKinematicWeights,manipulatorModel.homeConfiguration)
homeAngles = vertcat(configSoln.JointPosition)

manipulatorModel.Bodies{1, 1}.Joint.HomePosition = homeAngles(1);
manipulatorModel.Bodies{1, 2}.Joint.HomePosition = homeAngles(2);
manipulatorModel.Bodies{1, 3}.Joint.HomePosition = homeAngles(3);
manipulatorModel.Bodies{1, 4}.Joint.HomePosition = homeAngles(4);
manipulatorModel.Bodies{1, 5}.Joint.HomePosition = homeAngles(5);
manipulatorModel.Bodies{1, 6}.Joint.HomePosition = homeAngles(6);
manipulatorModel.Bodies{1, 7}.Joint.HomePosition = homeAngles(7);

%show(manipulatorModel,manipulatorModel.homeConfiguration);

manipulatorAngles = homeAngles;
manipulatorGripperAngles = [0;0;0];

%% Raise Manipulator to 'ready' position

readyPose = [0 0 -1 0;-1 0 0 -0.0248595866020535;0 1 0 0.5;0 0 0 1];
[configSoln,solInfo] = ik('EndEffector_Link',readyPose,inverseKinematicWeights,manipulatorModel.homeConfiguration)
readyAngles = vertcat(configSoln.JointPosition)

manipulatorAngles = readyAngles;

%% Find transform matrix of object position

%for now the objects position will be random
randConfig = manipulatorModel.randomConfiguration;

objectPosition = getTransform(manipulatorModel,randConfig,'EndEffector_Link','base_link');

%% Find inverse kinematics solution
[configSoln,solInfo] = ik('EndEffector_Link',objectPosition,inverseKinematicWeights,manipulatorModel.homeConfiguration)
manipulatorAngles = vertcat(configSoln.JointPosition);
while max(manipulatorAngles) > pi || min(manipulatorAngles) < -pi
    if max(manipulatorAngles) > pi
        [ManipulatorAngleValue,ManipulatorAngleIndex] = max(manipulatorAngles);
        manipulatorAngles(ManipulatorAngleIndex) = ManipulatorAngleValue - pi;
    end
    if min(manipulatorAngles) < -pi
        [ManipulatorAngleValue,ManipulatorAngleIndex] = min(manipulatorAngles);
        manipulatorAngles(ManipulatorAngleIndex) = ManipulatorAngleValue + pi;
    end
end
grabObjectAngles = manipulatorAngles;