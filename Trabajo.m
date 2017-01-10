%Trabajo
%
%%
% TO BE EXECUTED IN COMMAND LINE: (MATLAB R2014a)
% addpath(genpath('\\vmisalabos\Practicas\MAII\CPR\Robotica y Vision\rvctools'))
% addpath(genpath('\\vmisalabos\Practicas\MAII\CPR\Robotica y Vision\vstoolbox_R13'))
%
 addpath(genpath('C:\Users\Maria\Documents\Alex\1UNI\MUAII\CPR\CPR\rvctools'))
 addpath(genpath('C:\Users\Maria\Documents\Alex\1UNI\MUAII\CPR\CPR\vstoolbox_R13'))
%
% Other option faster
% addpath(genpath('F:\CPR\rvctools'))
% addpath(genpath('F:\CPR\vstoolbox_R13'))
%
%There is a demostrator named "rtbdemo" that uses:
%   - homogeneous transformations: 'rotation' and 'trans'
%   - trajectories: 'traj' and 'robot'
%   - forward kinematics: 'fkine'
%   - inverse kinematics: 'ikine'
%   - robot animation: 'graphics'
%   - inverse dynamics: 'idyn
%   - forward dynamics
% 'jacob', 'symbolic', 'codegen', 'drivepose',  'quadrotor', 'braitnav'
% 'bugnav', 'dstarnav', 'prmnav', 'slam', 'particlefilt', 'Children'
%% TRABAJO
clear all
close all
clf % remove previous figures
cla % remove previous axes
clc
%
%**************************************************************************
%% Information about IRB140
% Axis movement
% Axis Working range
% 1, C Rotation 360�
% 2, B Arm 200�
% 3, A Arm 280�
% 4, D Wrist Unlimited (400� default)
% 5, E Bend 240�
% 6, P Turn Unlimited (800� default)
% -----------------------------------
% Movement on ISO test plane,
% all axes in movement
% Max. TCP velocity 2.5 m/s
% Max. TCP acceleration 20 m/s2
% Acceleration time 0-1 m/s 0.15 sec.

%% Ejemplo de plot3d para visualizar por debajo del limite
% xmn=-1;
% xmx=1;
% ymn=-1;
% ymx=1;
% zmn=-1;
% zmx=3;
% W = [xmn, xmx ymn ymx zmn zmx];
% figure(1)
% IRB140.plot3d(q,'workspace', W );

%% CIRCLE trayectoria

%% Define IRB140 robot.
L(1) = Link([0 0.352 0.070 -pi/2], 'standard');
L(2) = Link([-pi/2 0 0.360 0], 'standard');
L(3) = Link([0 0 0 -pi/2], 'standard');
L(4) = Link([0 0.380 0 pi/2], 'standard');
L(5) = Link([0 0 0 -pi/2], 'standard');
L(6) = Link([pi 0.065 0 0], 'standard');
q=[0 -pi/2 0 0 0 0];
IRB140 = SerialLink(L);
IRB140.model3d='ABB\IRB140';
figure(1)
IRB140.plot3d(q);

title('ABB IRB140')

pause
clf

%% Define workspace ej: IRB140.plot3d(q,'workspace', W)
xmn=-1;
xmx=1;
ymn=-1;
ymx=1;
zmn=-0.2;
zmx=1.2;
W = [xmn, xmx ymn ymx zmn zmx];

% %% fkine
% qz=[0 0 0 0 0 0];
% qr=[0 -pi/2 -pi/2 0 0 0];
% qs=[0 0 -pi/2 0 0 0];
% qn=[0 -pi/4 -pi 0 pi/4 0];
% %
% % Plotear robot con qz
% clf
% figure(1)
% IRB140.plot3d(qz, 'workspace', W);
% title('QZ')
% pause
% clf
% % Plotear robot en qr
% 
% figure(1)
% IRB140.plot3d(qr);
% title('QR')
% pause
% clf
% % Treyectoria de qz a qr
% q1=jtraj(qz,qr,50);
% IRB140.plot3d(q1, 'workspace', W);
% pause
% clf
% % Definir otros puntos
% qz=[pi 0 0 0 0 0];
% qr=[0 -pi/2 -pi/2 0 0 0];
% q1=jtraj(qz,qr,50);
% clf
% IRB140.plot3d(q1, 'workspace', W);
% pause



%% Plotear cuadrado
% t = 0:pi/50:10*pi; % Ejemplo
% st = sin(t);
% ct = cos(t);
% pause
% clf
% figure(1)
% plot3(st,ct,t)

%% Para el ejercicio de las letras: fkine6s no funciona!
% fkine para obtener el punto segun los angulos y obtienes T
% con ikine(T) te generar� el angulo

% left or right handed          'l', 'r'
% elbow up or down              'u', 'd'
% wrist flipped or not flipped  'f', 'n'

% help
% qi = p560.ikine(T, 'pinv'); para cuando sale NaN

clf
figure(1)

q=[0 -pi/2 0 0 0 0];
clf
IRB140.plot3d(q, 'workspace', W)
title('ABB IRB140')
pause

%% A
T1=IRB140.fkine(q)

T2=T1*transl(-0.4, 0.4, 0.05) % Transl para posteriormente modificar la posicion                    
q2=IRB140.ikine(T2)
qq1=jtraj(q,q2,50);

T3=T2*transl(0, 0,0.05)     % Acercamiento punto        
q3=IRB140.ikine(T3)
qq2=jtraj(q2,q3,50);

T4=T3*transl(0.15, -0.05, 0)   % Primer palo  /        
q4=IRB140.ikine(T4)
qq3=jtraj(q3,q4,50);

T5=T4*transl(-0.15, -0.05, 0)    % Segundo palo   \  
q5=IRB140.ikine(T5)
qq4=jtraj(q4,q5,50);

T6=T5*transl(0, 0, -0.05)   % Alejamiento          
q6=IRB140.ikine(T6)
qq5=jtraj(q5,q6,50);

T7=T6*transl(0.075, 0.075, 0)    %posicion al palo -       
q7=IRB140.ikine(T7)
qq6=jtraj(q6,q7,50);

T8=T7*transl(0, 0, 0.05)  % Acercamiento palito A           
q8=IRB140.ikine(T8)
qq7=jtraj(q7,q8,50);

T9=T8*transl(0, -0.05, 0)  % Acercamiento palito A           
q9=IRB140.ikine(T9)
qq8=jtraj(q8,q9,50);

T10=T9*transl(0, 0, -0.05)   % Alejamiento          
q10=IRB140.ikine(T10)
qq9=jtraj(q9,q10,50);

%% L
T11=T10*transl(0.075, -0.045, 0)   % Ir al punto        
q11=IRB140.ikine(T11)
qq10=jtraj(q10,q11,50);

T12=T11*transl(0, 0, 0.05)   % Acercar        
q12=IRB140.ikine(T12)
qq11=jtraj(q11,q12,50);

T13=T12*transl(-0.15, 0, 0)   % linea |    
q13=IRB140.ikine(T13)
qq12=jtraj(q12,q13,50);

T14=T13*transl(0, -0.1, 0)   % linea _   
q14=IRB140.ikine(T14)
qq13=jtraj(q13,q14,50);

T15=T14*transl(0, 0, -0.05)   % linea _   
q15=IRB140.ikine(T15)
qq14=jtraj(q14,q15,50);

%% Letra E
T16=T15*transl(0.15, -0.12, 0)   % punto -
q16=IRB140.ikine(T16)
qq15=jtraj(q15,q16,50);

T17=T16*transl(0, 0, 0.05)   % acercamiento - 
q17=IRB140.ikine(T17)
qq16=jtraj(q16,q17,50);

T18=T17*transl(0, 0.1, 0)   % linea - 
q18=IRB140.ikine(T18)
qq17=jtraj(q17,q18,50);

T19=T18*transl(-0.15, 0, 0)   % linea | 
q19=IRB140.ikine(T19)
qq18=jtraj(q18,q19,50);

T20=T19*transl(0, -0.1, 0)   % linea _
q20=IRB140.ikine(T20)
qq19=jtraj(q19,q20,50);

T21=T20*transl(0, 0, -0.05)   % alejo _
q21=IRB140.ikine(T21)
qq20=jtraj(q20,q21,50);

T22=T21*transl(0.075, 0.1, 0)   % punto -
q22=IRB140.ikine(T22)
qq21=jtraj(q21,q22,50);

T23=T22*transl(0, 0, 0.05)   % acerco punto -
q23=IRB140.ikine(T23)
qq22=jtraj(q22,q23,50);

T24=T23*transl(0, -0.1, 0)   % linea -
q24=IRB140.ikine(T24)
qq23=jtraj(q23,q24,50);

T25=T24*transl(0, 0, -0.05)   % alejo -
q25=IRB140.ikine(T25)
qq24=jtraj(q24,q25,50);

%% X
T26=T25*transl(-0.075, -0.02, 0)   % ir a punto /
q26=IRB140.ikine(T26)
qq25=jtraj(q25,q26,50);

T27=T26*transl(0, 0, 0.05)   % acercar /
q27=IRB140.ikine(T27)
qq26=jtraj(q26,q27,50);

T28=T27*transl(0.15, -0.1, 0)   % linea /
q28=IRB140.ikine(T28)
qq27=jtraj(q27,q28,50);

T29=T28*transl(0, 0, -0.05)   % alejar /
q29=IRB140.ikine(T29)
qq28=jtraj(q28,q29,50);

T30=T29*transl(0, 0.1, 0)   % ir a punto \
q30=IRB140.ikine(T30)
qq29=jtraj(q29,q30,50);

T31=T30*transl(0, 0, 0.05)   % acercar \
q31=IRB140.ikine(T31)
qq30=jtraj(q30,q31,50);

T32=T31*transl(-0.15, -0.1, 0)   % linea \
q32=IRB140.ikine(T32)
qq31=jtraj(q31,q32,50);

T33=T32*transl(0, 0, -0.05)   % alejar \
q33=IRB140.ikine(T33)
qq32=jtraj(q32,q33,50);


qtot=[qq1;qq2;qq3;qq4;qq5;qq6;qq7;qq8;qq9;              % A
    qq10;qq11;qq12;qq13;qq14;                           % L
    qq15;qq16;qq17;qq18;qq19;qq20;qq21;qq22;qq23;qq24;  % E
    qq25;qq26;qq27;qq28;qq29;qq30;qq31;qq32];           % X

%% transponer para facil representacion
Tt1=transpose(T1);  % A
Tt2=transpose(T2);  
Tt3=transpose(T3);
Tt4=transpose(T4);
Tt5=transpose(T5);
Tt6=transpose(T6);
Tt7=transpose(T7);
Tt8=transpose(T8);
Tt9=transpose(T9);

Tt10=transpose(T10); % B
Tt11=transpose(T11);
Tt12=transpose(T12);
Tt13=transpose(T13);
Tt14=transpose(T14);

Tt15=transpose(T15);  % E
Tt16=transpose(T16);  
Tt17=transpose(T17);
Tt18=transpose(T18);
Tt19=transpose(T19);
Tt20=transpose(T20);
Tt21=transpose(T21);
Tt22=transpose(T22);
Tt23=transpose(T23);
Tt24=transpose(T24);
Tt25=transpose(T25);

Tt26=transpose(T26); % X
Tt27=transpose(T27);
Tt28=transpose(T28);
Tt29=transpose(T29);
Tt30=transpose(T30);
Tt31=transpose(T31);
Tt32=transpose(T32);
Tt33=transpose(T33);


%% Dibujar
drw=[Tt2(4,1:3); Tt3(4,1:3); Tt4(4,1:3); Tt5(4,1:3); Tt6(4,1:3); Tt7(4,1:3); Tt8(4,1:3); Tt9(4,1:3);    % A
     Tt10(4,1:3); Tt11(4,1:3); Tt12(4,1:3); Tt13(4,1:3); Tt14(4,1:3);                                   % L
     Tt15(4,1:3); Tt16(4,1:3); Tt17(4,1:3); Tt18(4,1:3); Tt19(4,1:3); Tt20(4,1:3); Tt21(4,1:3); Tt22(4,1:3); Tt23(4,1:3); Tt24(4,1:3); Tt25(4,1:3); % E
     Tt26(4,1:3); Tt27(4,1:3); Tt28(4,1:3); Tt29(4,1:3); Tt30(4,1:3); Tt31(4,1:3); Tt32(4,1:3); Tt33(4,1:3); % X
     ];

pause
clf
figure(1)
plot3(drw(:,1), drw(:,2), drw(:,3), 'color', 'r', 'LineWidth', 1)
title('ABB IRB140')
hold on
IRB140.plot3d(qtot, 'workspace', W)

