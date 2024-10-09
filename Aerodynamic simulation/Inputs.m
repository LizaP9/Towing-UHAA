clear;clc;
x0 = [0; 0; 0; 0; 0; 0; 0; 0; -20; 0; 0; 0];
u = [20; 0/57.3 ; 0/57.3; 0/57.3; 0];
d = [0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0];    

M = 997;
Ixx = 180698.23;
Iyy =  323903.72;
Izz = 500412.38;
Ixz = 0;
rho = 0.8891; %kg/m^3
Sref = 6515.77; %m2
Lref = 7.8; %m
Vol = 13958; %m3
g = 9.81; %m/s2
out = sim('Airship_Model_2.slx')
%%
X = out.X.Data/15; Y = out.Y.Data; Z = out.Z.Data*20; Psi_y = out.psi.Data*57.3; Psi_x = out.psi.Time; 
psi_trajectory = plot(Psi_x, Psi_y, '-', 'LineWidth', 1.5);

figure(1);
for i = 11894:length(Psi_x)
    plot(Psi_x(1:i), Psi_y(1:i), '-', 'LineWidth', 1.5); 
    xlabel('Time');    ylabel('Heading Angle');    title('Heading Trajectory');
    grid on; grid minor;
    pause(0.001);
end
%%
figure();
h_trajectory = plot3(X, Y, Z, '-', 'LineWidth', 1.5); % Adjust the line width as needed
xlabel('X - (km)');ylabel('Y - (km)');zlabel('Z - (km)');
title('Towing Mechanism');

hold on;

circle_radius1 = 1; circle_color1 = 'r'; % Towing Airship
h_circle1 = plot3(X(1), Y(1), Z(1), 'o', 'MarkerSize', circle_radius1 * 10, 'MarkerFaceColor', circle_color1);

circle_radius2 = 1; circle_color2 = 'b'; % Service Airship
initial_position_index = 15000; 
h_circle2 = plot3(X(initial_position_index), Y(initial_position_index), Z(initial_position_index), 'o', 'MarkerSize', circle_radius2 * 10, 'MarkerFaceColor', circle_color2);
final_position_index = 20000;
hold on;
plot3(X(initial_position_index), Y(initial_position_index),Z(initial_position_index), 'x', 'MarkerSize', 15, 'Color', 'k');
hold on;
plot3(X(final_position_index), Y(final_position_index),Z(final_position_index), 'x', 'MarkerSize', 15, 'Color', 'k');

hold off;
axis([min(X), max(X), min(Y), max(Y), min(Z), max(Z)]);
legend('Trajectory','Towing Airship','Service Airship','SA - Initial Point','SA - Final Point')
grid on; grid minor;

for i = 2:length(X)
    set(h_trajectory, 'XData', X(1:i), 'YData', Y(1:i), 'ZData', Z(1:i));
    set(h_circle1, 'XData', X(i), 'YData', Y(i), 'ZData', Z(i));
    
    if i > initial_position_index && i < final_position_index
        set(h_trajectory, 'XData', X(1:i), 'YData', Y(1:i), 'ZData', Z(1:i));
        set(h_circle2, 'XData', X(i), 'YData', Y(i), 'ZData', Z(i));
    end
    pause(0.001);
end
