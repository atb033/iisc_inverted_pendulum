clc
S = serial('COM5','BaudRate',9600);
fopen(S);
% fprintf(S,'%s', ' \n')
for i = 1:4
txt = fscanf(S);
display(txt)
end
fprintf(S,'%s', '2\n');

for i = 1:100
    txt = fscanf(S);
    Val = sscanf(txt,'%*s %f %f %f');
    display(txt)
    fwrite(S,1);
    pause(1);

end

fclose(S)
delete(S)