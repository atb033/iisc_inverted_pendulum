movement = 'l';
amp = 155;
reply = 1;
while (isempty(reply)== 0)
    if movement == 'r'
        a.analogWrite(10,0);
        a.analogWrite(9,amp);
        reply = input('');
    else
        a.analogWrite(9,0);
        a.analogWrite(10,amp);
        reply = input('');
    end
    
end

a.analogWrite(9,0);
a.analogWrite(10,0);