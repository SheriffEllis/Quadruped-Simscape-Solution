% Create x and y values for the heart shape
t = linspace(0, 2*pi);
x = 16*sin(t).^3;
y = 13*cos(t)-5*cos(2*t)-2*cos(3*t)-cos(4*t);

% Plot the heart shape
plot(x,y,'r','LineWidth',2);

% Add text to the center of the heart
text(0,0,'W+O','HorizontalAlignment','center','VerticalAlignment','middle','FontSize',20);

% Add axis labels and a title
xlabel('x-axis');
ylabel('y-axis');
title('Heart shape with W+O');
