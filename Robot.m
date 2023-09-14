% This program is used to help a Line-Following Robot follow the line.  
% The first several sections set up the constants used in the communcation
% between this program and the arduino.   

% This program assumes that a connection has been established to the
% arduino using the program Robot_Connect. 
% The variable 'a' must be established in the command window.

%% Warns user that connection with ARDUINO must be established prior to 
% running this code
display('Have you run Robot_Connect?')
display('If you do not see the variable "a" in your workspace quit this')
display('program, run Robot_Connect, and try again')

%% Constants for reading sensors - do not change statements in this block 
% unless there is a change to the physical robot
sensorpin = 13;     % sensor control pin (all sensors)
leftsensorpin = 0;  % pin to read left sensor values from
centersensorpin = 2;% pin to read center sensor values from
rightsensorpin = 4; % pint to read right sensor values from
a.pinMode(sensorpin,'OUTPUT');  % preparing to turn sensors on and off

%% Constants for motor control
leftmotor = 5;      % set pin 5 as the pin to control the left motor 
rightmotor = 6;     % set pin 6 as the pin to control the right motor 
off = 50;            % motor speed of 0, 0 is off
lmhigh = 170;       % left motor speed, range of acceptable values 0-255
rmhigh = 255;       % right motor speed, range of acceptable values 0-255

%% Control Code

format compact;

%the number of times readings will be taken
testLength = 1000;

%The threshold value we determined from our setup runs
threshold = 250;

%iterator
 i = 1;
 
%holds the number of times the line is not recoginzed by the sensors
%consecutively
white = 0;

%instantiates the variables that will hold the readings from the sensors
leftSensor = 0;
rightSensor = 0;
centerSensor = 0;

%loops throught the code that will control the Arduino as long as it has
%not surpased the number of readings that are suppose to be taken or if the
%number of consecutive white readings is below 15.
while white < 15
    
    %Turns on the sensors
    a.digitalWrite(sensorpin,1);
    
    %reads the sensor readings from the arduino
    leftSensor = a.analogRead(leftsensorpin);
    centerSensor = a.analogRead(centersensorpin);
    rightSensor = a.analogRead(rightsensorpin);
    
    %Turns off the sensor so it does not burn out
    a.digitalWrite(sensorpin,0)
    
    %if the left sensor reads above the threshold, then the left motor
    %needs to be off and the right motor needs to be on.  It also sets the
    %number of consecutive white readings back to zero.
    if leftSensor >= threshold
        
        a.analogWrite(leftmotor,off);
        a.analogWrite(rightmotor,rmhigh); 
        white = 0;
        
    %if the right sensor reads above the threshold, then the right motor
    %needs to be off and the right motor needs to be on.  It also sets the
    %number of consecutive white readings back to zero.
    elseif rightSensor >= threshold
            
         a.analogWrite(leftmotor,lmhigh);
         a.analogWrite(rightmotor,off); 
         white = 0;
    
    %if only the center sensor reads above the threshold or all the sensors
    %read above the threshold, then both motors need to be on.  It also sets the
    %number of consecutive white readings back to zero.
    elseif ((centerSensor >= threshold && leftSensor < threshold && rightSensor < threshold) || (centerSensor >= threshold && leftSensor >= threshold && rightSensor >= threshold))
            
        a.analogWrite(leftmotor,lmhigh)
        a.analogWrite(rightmotor,rmhigh);   
        white = 0;
    
    %if the sensors do not read anything, then increment white and display
    %no line
    else
        disp('No Line');
        white = white + 1;
    
    end
    
    %iterator
    i = i + 1;
end

a.analogWrite(leftmotor, 0);
a.analogWrite(rightmotor, 0);

leftSensor = 0;
rightSensor = 0;
centerSensor = 0;
k = 1;

disp('Start second loop');

while rightSensor < threshold && leftSensor < threshold && centerSensor < threshold

     %Turns on the sensors
    a.digitalWrite(sensorpin,1);
    
    %reads the sensor readings from the arduino
    leftSensor = a.analogRead(leftsensorpin);
    centerSensor = a.analogRead(centersensorpin);
    rightSensor = a.analogRead(rightsensorpin);
    
    %Turns off the sensor so it does not burn out
    a.digitalWrite(sensorpin,0)
    
    a.analogWrite(rightmotor, 100);
    a.analogWrite(leftmotor, 255);
    
    k = k + 1;
    
end

leftSensor = 0;
rightSensor = 0;
centerSensor = 0;

a.analogWrite(leftmotor, 0);

disp('start third loop');

while centerSensor < threshold
    
     %Turns on the sensors
    a.digitalWrite(sensorpin,1);
    
    %reads the sensor readings from the arduino
    leftSensor = a.analogRead(leftsensorpin);
    centerSensor = a.analogRead(centersensorpin);
    rightSensor = a.analogRead(rightsensorpin);
    
    %Turns off the sensor so it does not burn out
    a.digitalWrite(sensorpin,0)
    
    a.analogWrite(rightmotor, 255);
    
    k = k + 1;
    
end

white = 0;

disp('Start 4 loop');

while white < 15
    
    %Turns on the sensors
    a.digitalWrite(sensorpin,1);
    
    %reads the sensor readings from the arduino
    leftSensor = a.analogRead(leftsensorpin);
    centerSensor = a.analogRead(centersensorpin);
    rightSensor = a.analogRead(rightsensorpin);
    
    %Turns off the sensor so it does not burn out
    a.digitalWrite(sensorpin,0)
    
    %if the left sensor reads above the threshold, then the left motor
    %needs to be off and the right motor needs to be on.  It also sets the
    %number of consecutive white readings back to zero.
    if leftSensor >= threshold
        
        a.analogWrite(leftmotor,off);
        a.analogWrite(rightmotor,rmhigh); 
        white = 0;
        
    %if the right sensor reads above the threshold, then the right motor
    %needs to be off and the right motor needs to be on.  It also sets the
    %number of consecutive white readings back to zero.
    elseif rightSensor >= threshold
            
         a.analogWrite(leftmotor,lmhigh);
         a.analogWrite(rightmotor,off); 
         white = 0;
    
    %if only the center sensor reads above the threshold or all the sensors
    %read above the threshold, then both motors need to be on.  It also sets the
    %number of consecutive white readings back to zero.
    elseif ((centerSensor >= threshold && leftSensor < threshold && rightSensor < threshold) || (centerSensor >= threshold && leftSensor >= threshold && rightSensor >= threshold))
            
        a.analogWrite(leftmotor,lmhigh)
        a.analogWrite(rightmotor,rmhigh);   
        white = 0;
    
    %if the sensors do not read anything, then increment white and display
    %no line
    else
        disp('No Line');
        white = white + 1;
    
    end
    
    %iterator
    i = i + 1;
end

%End of Run
disp('Run Done');
a.analogWrite(leftmotor,off)
a.analogWrite(rightmotor,off); 



%% The section makes sure the motor and sensors are off when the program stops.
a.analogWrite(leftmotor,off) %to turn left motor off 
a.analogWrite(rightmotor,off) %to turn left motor off 
a.digitalWrite(sensorpin,0) %output to turn off sensors

