a = arduino('COM3')
a.pinMode(8,'output');
a.pinMode(9,'output');
a.encoderAttach(0,2,3)
i =0;
amp = 150
% while(i<3)
%     a.digitalWrite(9,0)
%     a.digitalWrite(10,1)
%     pause(1);
%     a.digitalWrite(10,0);
%     a.digitalWrite(9,1);
%     pause(1);
%     i = i+1;
% end
while(i<3)
    a.analogWrite(9,0)          %counter clockwise rotation
    a.analogWrite(10,amp)
    pause(1);
    a.analogWrite(10,0);        %cloclwise rotation
    a.analogWrite(9,amp);
    pause(1);
    i = i+1;
end
a.digitalWrite(9,0);