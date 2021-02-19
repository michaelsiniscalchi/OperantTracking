function [motor_ts, motor_byTrial] = calcLocomotorVars( data, params )

%***For DEVO***
%Notes: 
%   Assume 50 pix/cm...but we'll need to map out the spatial transform later bc of possible distortion
%   Try median filtering the position data as a means of smoothing/removing outliers

plots.speed = true;
%---------------------------------------------------------------------------------------------------

%% Check distance between bodyparts

% Distance from centroid
distance = @(dX,dY) sqrt(sum([dX,dY].^2,2)); %For column vectors dX=X1-X2 and dY=Y1-Y2

objects = ["body","left_ear","right_ear","Scope_1","Scope_2","base_of_tail"];
[posX, posY] = deal(NaN(size(data.DLC.t,1),numel(objects))); %initialize
for i = 1:numel(objects) %Aggregate bodypart positions
    posX(:,i) = data.DLC.(objects(i)).x;
    posY(:,i) = data.DLC.(objects(i)).y;
end

%Median filter x- and y- timeseries (smoothing/outlier reduction)

%Take mean as overall body position
position.centroid.x = mean(posX,2); 
position.centroid.y = mean(posY,2);

for i = 1:numel(objects) %Take distance from centroid
    dx = data.DLC.(objects(i)).x - position.centroid.x;
    dy = data.DLC.(objects(i)).y - position.centroid.y;
    d_centroid.(objects(i)) = distance(dx,dy); %Euclidean norm recentered on centroid
end

%Plot distance of each bodypart from centroid as f(t)
if params.plot_validation
    tiledlayout(2,numel(objects)/2);
    for i = 1:numel(objects)
        nexttile;
        plot(data.DLC.t, d_centroid.(objects(i)));
        title(objects(i),'Interpreter','none');
        xlabel('Time (s)');
        ylabel('Distance from centroid of bodyparts (pixels)');
    end
end

%% Calculate timeseries variables for each tracked object

%Position in cm **requires session-specific scale/transform**

%Speed **in PIX until scaled to cm**
%May require some downsampling to reduce error from tracking jitter (ask Julia)
dt = [0; diff(data.DLC.t)];

%Take average position across spec bodyparts
objects = ["body","base_of_tail"];
[posX, posY] = deal(NaN(size(data.DLC.t,1),numel(objects)));
for i = 1:numel(objects)
    posX(:,i) = data.DLC.(objects(i)).x;
    posY(:,i) = data.DLC.(objects(i)).y;
end
posX = mean(posX,2);
posY = mean(posY,2);

%Calculate speed
dx = [0; diff(posX)]; %Instantaneous change in x,y position
dy = [0; diff(posY)]; 
motor_ts.speed = distance(dx,dy)./dt; %Euclidean distance from last point/dt

%Calculate view angle
%Set center nosepoke to 0 deg
%Use body axis (tail, body, something on head)
%P = atan2(Y,X) and then convert to degrees
%Beware of the range of atan and figure out how to get all quadrants accurately!

%Validation Plots
if params.plot_validation
    figure('Name','Speed_Timeseries');
    plot(motor_ts.speed);
    title('Full-Body Speed');
    xlabel('Time (s)');
    ylabel("Speed avg across all body parts (pixels/s)");
end

%% Trial-by-Trial Spatial Trajectories

%% Trial-by-Trial Locomotor Variables
%Total Distance traveled
%Also by trial epoch