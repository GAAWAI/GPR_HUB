function Round_DIN1333(Value,Uncertainty)


% Calculate the position of the FSB
if abs(Value) > 1
    va_PosiFSB = floor(log10(Value))+1;
else
    va_PosiFSB = floor(log10(Value));
end
if abs(Uncertainty) > 1
    un_PosiFSB = floor(log10(Uncertainty))+1;
else
    un_PosiFSB = floor(log10(Uncertainty));
end

if un_PosiFSB < 0
    un_FirstNum = fix(abs(Uncertainty)*10^(-un_PosiFSB));
else
    un_FirstNum = fix(abs(Uncertainty)*10^(-un_PosiFSB+1));
end


% Round the number by DIN1333
if un_FirstNum < 3
    va_Print = round(Value,-un_PosiFSB,'decimals');
    un_Print = round(Uncertainty,2,'significant');
else
    va_Print = round(Value,-un_PosiFSB+1,'decimals');
    un_Print = round(Uncertainty,1,'significant');
end

fprintf('%f +/- %f\n',va_Print,un_Print)

end