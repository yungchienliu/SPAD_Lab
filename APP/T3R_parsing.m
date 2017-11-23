%TTTR


fileID = fopen('PD01_20ns_000.out','r');
A = fscanf(fileID,'%s');
fclose(fileID);


fl = 0;
cnt = 1;
num = zeros(1,3e6);
tmp = 0;
len = length(A);


for i = 1:len
    if A(i) == '('
        fl = 1;
    elseif A(i) == '.' && fl
        num(1,cnt) = tmp;
        cnt = cnt+1;
        tmp = 0;
        fl = 0;
    elseif fl
        tmp = tmp*10 + A(i)-'0';
    end    
end

% fileID = fopen('delta_t.txt','w');
delta = zeros(1,3e6);
for i = 2:cnt-1
    delta(1,i-1) = num(1,i)-num(1,i-1);
end
% delta = sort(delta, 'descend');
% dd = delta(1,1:cnt-2);

interval = zeros(1,1005);
for i = 1:cnt-2
%     fprintf(fileID, '%.1f ps\n', delta(1,i));
    th = floor(delta(1,i)/1000);
    if th > 1000 
        continue;
    end
    interval(1, th) = interval(1, th)+1;
end
% fclose(fileID);

fileID = fopen('interval.txt','w');
for i = 1:1000
    fprintf(fileID, '%d %d\n', i, interval(1,i));
end
fclose(fileID);
