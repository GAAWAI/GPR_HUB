clc,clear
% function Reversionspendel
% P6.1 Grundpraktikum I M9 Reversionspendel
% Jiawei Yu an der Humboldt-Universitaet zu Berlin
% Interpreted by MATLAB R2010a
fprintf('\nM9 Reversionspendel\n\n');

% Part 1 An Overall Measurement

% The intersection of the two t-x curves
syms t11 t12 t21 t22 x1 x2
ts = (t11*t22-t12*t21)/(t11-t12-t21+t22);
xs = ( x1 + (t11-t12)/(t11-t12-t21+t22) * (x2-x1) )*20;

% The uncertainty of coordinate ts
usys_t = 0.001+0.000001*[t11 t12 t21 t22];
diff_ts = [diff(ts,t11,1) diff(ts,t12,1) diff(ts,t21,1) diff(ts,t22,1)];
u_ts = sqrt(sum(diff_ts.*usys_t).^2);

% Data of 4 periodic time [s] by different ringmarks
x = [3 4 5 6 7]; % Ringmarke
t_Sch1 = [8.146 8.090 8.034 7.981 7.926]; % Schneide 1
t_Sch2 = [8.061 8.027  7.994 7.966 7.939]; % Schneide 2
% A diagramm of the two t-x curves
plot(x,t_Sch1,'r');hold on
plot(x,t_Sch2,'b') % use 'LineSmoothing','on' to smooth the plot
axis square
xlabel('Abstand von Schneide 2 [mm]');
ylabel('Periodendauer T[s]');
legend('Schneide 1','Schneide 2');

t11 = t_Sch1(4); % Index t_"Ringmarke,Schneide"
t12 = t_Sch2(4);
t21 = t_Sch1(5);
t22 = t_Sch2(5);
x1 = x(4); % Index "Ringmarke" (before intersect)
x2 = x(5); % (After intersect)

% Calculate the intersection and its uncertainty
ts = subs(ts);
xs = subs(xs);
u_ts = subs(u_ts);
fprintf('The intersection (xs,ts) is (%f , %f+/-%f) \n',xs,ts,u_ts);


% Part 2 The Precise Measurement

% Data of 40 periodic time [s]
T1_40 = [79.527 79.549 79.531 79.531 79.549 79.535 79.550 79.552 79.542 79.541];
T2_40 = [79.520 79.516 79.523 79.522 79.522 79.540 79.538 79.533 79.527 79.519];

% Confidence interval
confi40_T1 = std(T1_40)/sqrt(length(T1_40));
confi40_T2 = std(T2_40)/sqrt(length(T2_40));
% Systematic uncertainty
usys40_T1 = 0.001+0.000001*mean(T1_40);
usys40_T2 = 0.001+0.000001*mean(T2_40);

% Total uncertainty of T1 and T2 und the final results
u40_T1 = sqrt(sumsqr([confi40_T1 usys40_T1]));
u40_T2 = sqrt(sumsqr([confi40_T2 usys40_T2]));
fprintf('40 Perioden T1 = %f+/-%f s \n',mean(T1_40),u40_T1);
fprintf('40 Perioden T2 = %f+/-%f s \n',mean(T2_40),u40_T2);
fprintf('1 Perioden T1 = %f+/-%f s \n',eval('mean(T1_40)/40'),eval('u40_T1/40'));
fprintf('1 Perioden T2 = %f+/-%f s \n',eval('mean(T2_40)/40'),eval('u40_T2/40'));


% Part 3 Length between the two axises

% Original data of the length [mm]
lm = [973.10 973.15 973.12 973.13 973.12 973.16 973.15 973.18 973.17 973.13];
a1 = 335;
u_a1 = 2;

% Uncertainty of the axises distance
confi_lm = std(lm)/sqrt(length(lm)); % Confidence interval
usys_lm = 0.02+0.00005*mean(lm); % Systematic uncertainty
u_lm = sqrt(sumsqr([confi_lm usys_lm]));

% Final result of lr (lm + thickness of the caliper folk) in [mm]
lr = mean(lm)+10.03;
u_lr = u_lm+0.03;
fprintf('Distance between axises lr = %f+/-%f mm \n',lr,u_lr);
fprintf('Distance between axis 1 and center of mass a1 = %f+/-%f mm \n',a1,u_a1);


% Part 4 Calculating the gravitational acceleration

syms T1 T2 a1 lr T_squ
TT = (T1^2*a1 - T2^2*(lr-a1)) / (a1-(lr-a1));
g = 4*pi^2/T_squ * lr *(1 + 0.002096386/8 + 1.29/7850);

% The uncertainty of T-squared and g
diff_TT = [diff(TT,T1,1) diff(TT,T2,1) diff(TT,a1,1) diff(TT,lr,1)];
diff_g = [diff(g,T_squ,1) diff(g,lr,1) diff(g,a1,1)];


% u_TTPart = [u40_T1/40 u40_T2/40 u_a_1 u_lr];
% u_TT = sqrt(sum(diff_TT.*u_TTPart).^2);
% 
% T1 = mean(T1_40)/40;
% T2 = mean(T2_40)/40;
% lr = mean(lm)+10.03; % in [m]
% a1 = a_1;
% 
% TT = subs(TT)
% u_TT = subs(u_TT)







% TT = ((T1^2+T2^2)/2 - (T1^2-T2^2)/2 * (lr/(2*a1-lr)))


% syms T1 T2 lr a1
% 
% % 
% gg = 4*pi^2/((T1^2+T2^2)/2 - (T1^2-T2^2)/2 * (lr/(2*a1-lr))) * lr *(1 + 0.002096386/8 + 1.29/7850);
% % gg = compose(g,TT);  % Composition der Funktion
% 
% T1 = 1.988518;
% T2 = 1.988150;
% lr = 0.98317;       % lr = 983.17mm
% a1 = 0.335;         % a1 = 335mm
% sqrt(subs(TT))
% subs(gg)
% 
% % Differenzial berechnet und auswerten
% Dgg_T1 = diff(gg,T1,1);
% Dgg_T2 = diff(gg,T2,1);
% Dgg_lr = diff(gg,lr,1);
% Dgg_a1 = diff(gg,a1,1);
% 
% A(1) = subs(Dgg_T1);
% A(2) = subs(Dgg_T2);
% A(3) = subs(Dgg_lr);
% A(4) = subs(Dgg_a1);
% Unsich = [0.000073 0.000066 0.00011 0.002];    % Unsicherheit in Vektor
% U_ges = sqrt(sum((A.*Unsich).^2))



% Part 5 Amplitude dependence of periodes



