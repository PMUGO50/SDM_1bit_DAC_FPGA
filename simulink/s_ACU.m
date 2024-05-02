function [sys,x0,str,ts,simStateCompliance] = s_ACU(t,x,u,flag, fs,k)
    switch flag
      case 0
        [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes(fs);
      case 1
        sys=mdlDerivatives(); %this block is for continous
      case 2
        sys=mdlUpdate(x,u, k);
      case 3
        sys=mdlOutputs(x,u);
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
    sizes.NumDiscStates  = 1;
    sizes.NumOutputs     = 1;
    sizes.NumInputs      = 1;
    sizes.DirFeedthrough = 0;
    sizes.NumSampleTimes = 1;   % at least one sample time is needed
    
    sys = simsizes(sizes);
    x0  = 0;
    str = []; %always set empty
    ts  = [1/fs 0];
    simStateCompliance = 'UnknownSimState';

function dx_dt=mdlDerivatives() %continous derivative definition
    dx_dt = [];

function x_next=mdlUpdate(x,u, k)
    x_next = x + k*u;

function y=mdlOutputs(x,u)
    y = x;

function sys=mdlGetTimeOfNextVarHit(t)
    sampleTime = 1;    %  Example, set the next hit to be one second later.
    sys = t + sampleTime;

function sys=mdlTerminate()
    sys = [];
