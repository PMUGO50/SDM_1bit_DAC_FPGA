function [sys,x0,str,ts,simStateCompliance] = s_ADP(t,x,u,flag, fs,b,q)
    switch flag
      case 0
        [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes(fs);
      case 1
        sys=mdlDerivatives(); %this block is for continous
      case 2
        sys=mdlUpdate(x,u, b,q);
      case 3
        sys=mdlOutputs(x,u, b,q);
      case 4
        sys=mdlGetTimeOfNextVarHit(t);
      case 9
        sys=mdlTerminate();
      otherwise
        DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));
    end

function [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes(fs)
    sizes = simsizes;
    
    sizes.NumContStates  = 0;
    sizes.NumDiscStates  = 3;
    sizes.NumOutputs     = 1;
    sizes.NumInputs      = 1;
    sizes.DirFeedthrough = 0;
    sizes.NumSampleTimes = 1; % at least one sample time is needed
    
    sys = simsizes(sizes);
    x0  = [0, 0, 0]; %two internal states, one out state
    str = []; %always set empty
    ts  = [1/fs 0];
    simStateCompliance = 'UnknownSimState';

function dx_dt=mdlDerivatives() %continous derivative definition
    dx_dt = [];

function x_next=mdlUpdate(x,u, b,q)
    x_next(1) = u;
    x_next(2) = x(1); %two internal states
    s = round(x(1)+ x(2) + u);
    if s==3 %one out state
        x_next(3) = x(3) + b*q;
    elseif s==-3
        x_next(3) = x(3) - b*q;
    else
        x_next(3) = x(3);
    end

function y=mdlOutputs(x,u, b,q)
    s = round(x(1)+ x(2) + u);
    if s==3 %here y==x_next(3)
        y = x(3) + b*q;
    elseif s==-3
        y = x(3) - b*q;
    else
        y = x(3);
    end

function sys=mdlGetTimeOfNextVarHit(t)
    sampleTime = 1;    %  Example, set the next hit to be one second later.
    sys = t + sampleTime;

function sys=mdlTerminate()
    sys = [];
