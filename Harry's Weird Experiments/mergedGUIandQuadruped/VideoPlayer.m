% Create a GUI window
fig = uifigure('Name', 'Video Player', 'Position', [100 100 800 600]);

% Create a video player object
vid = VideoReader('movingBall.avi');

% Create a UIAxes object to display the video
ax = uiaxes(fig, 'Position', [100 100 600 400]);

% Create a play button
playBtn = uibutton(fig, 'push', 'Text', 'Play', 'Position', [100 550 100 30]);

% Create a close button
closeBtn = uibutton(fig, 'push', 'Text', 'Close', 'Position', [600 550 100 30]);

% Set the callback function for the play button
playBtn.ButtonPushedFcn = @(~, ~) playVideo(vid, ax);

% Set the callback function for the close button
closeBtn.ButtonPushedFcn = @(~, ~) closeGUI(vid, fig);

function playVideo(vid, ax)
    % Read the first frame of the video
    frame = readFrame(vid);

    % Display the first frame in the UIAxes object
    image(ax, frame);

    % Loop through the video frames and display them in the UIAxes object
    while hasFrame(vid)
        frame = readFrame(vid);
        image(ax, frame);
        drawnow;
    end
end

function closeGUI(vid, fig)
    % Delete the video object and close the GUI window
    delete(vid);
    delete(fig);
    delete('movingBall.avi')
end