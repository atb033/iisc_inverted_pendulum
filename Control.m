% pause(2);
a.encoderReset(0);
pause();
Kp = 15;
% Ki = 0.005;
Ki=0;
Kd = 0;
dt = 0.05;
Time = 10;
n = round(Time/dt);
Prop(1:n+1) = 0; Der(1:n+1) = 0; Int(1:n+1) = 0; I(1:n+1) = 0;
PID(1:n+1) = 0;
flag = 0;
for i = 1:n
    tic
   Error(i+1) = a.encoderRead(0);
  
%    if flag == 0
%        if Error(i+1)~=0
%            start_error = Error(i+1);
%            flag = 1;
%        end
%    end

   Prop(i+1) = Error(i+1);
   Der(i+1) = (Error(i+1) - Error(i))/dt;
   Int(i+1) = (Error(i+1)+Error(i))*dt/2;
   I(i+1) = sum(Int(end-10:end));
   [ Kp*Prop(i)   Ki*I(i)    Kd*Der(i)  Error(i+1)]
   PID(i+1) = Kp*Prop(i)+Ki*I(i)+Kd*Der(i);
   e = PID(i+1);
   amp = min(round(abs(e)+110),255);
   if(e>0)
       a.analogWrite(9,0);
       a.analogWrite(10,amp);
   else
       a.analogWrite(10,0);
       a.analogWrite(9,amp);
   end
   toc
   pause(dt-toc);
end
a.analogWrite(10,0);
a.analogWrite(9,0)

% while(1)
%     error = a.encoderRead(0);
%     kP = 2;
%     amp = min(255,abs(error*kP));
%     if(error<0)
%         a.analogWrite(9,0);
%         a.analogWrite(10,amp);
%     else
%         a.analogWrite(9,amp);
%         a.analogWrite(10,0);        
%     end
%     pause(0.08);
% end