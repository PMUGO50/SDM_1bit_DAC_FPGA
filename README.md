# SDM_1bit_DAC_FPGA

This repo is an implementation of the digital part of 1-bit sigma-delta DAC (SDDAC) on FPGA with Verilog, which is 1-bit sigma-delta modulator (SDM) .

1-bit SDM is a kind of Pulse Density Modulation (PDM). It will output a signal jumping between 1 and 0 (that is 1-bit). Then this signal can be sent to an Analog LPF and finally generate an analog signal.

- [X] 1st and 2nd order SDDAC simulink simulation

- [X] 1st and 2nd order SDDAC Verilog behavioural simulation

- [X] 1st and 2nd order SDDAC Verilog RTL Systhesis

- [ ] 1st-order SDDAC Verilog board test

本仓库是用 Verilog 对 1 位 sigma-delta DAC 的数字部分在 FPGA 上的实现，即 sigma-delta 调制器。

1 位 SDM 是脉冲密度调制的一种方式。它将输出一个在 1 和 0 之间跳变的信号 (即 1 位的信号) 。该信号接下来可以被送入一个模拟 LPF 中并得到模拟信号。

- [X] 一二阶 SDDAC simulink 仿真

- [X] 一二阶 SDDAC Verilog 行为仿真

- [X] 一二阶 SDDAC Verilog RTL 逻辑综合

- [ ] 一二阶 SDDAC Verilog 上板测试

## Verilog_SDM

Verilog implementation of 1st-order 1-bit SDM is 'SDM1st.v', and that of 2nd-order one is 'SDM2nd.v'.

'top_tb.v' is testbench, run testbench will give a PDM signal 'pdmout.csv'. 'tbwave.csv' is input signal for testbench simulation. This signal is

$$
x[n] = 2000\sin[(2\pi f_0) nT_s] + 1500\sin[(2\pi \times 0.3f_0) nT_s] + 500\sin[(2\pi \times 5f_0) nT_s]
$$

here $f_0 = 20\mathrm{kHz}$ , and sampling period is $T_s=1/f_s=1/25\mathrm{MHz}$ . Of course this is a superposition of sine waves, since input is a 16-bit signed int, this is a relatively small signal.

一阶 1 位 SDM 的 Verilog 实现是 'SDM1st.v' ，二阶的则是 'SDM2nd.v' 。

'top_tb.v' 是 testbench ，运行 testbench 将得到一个 PDM 信号 'pdmout.csv' 。'tbwave.csv' 是 testbench 仿真时的输入信号。这个信号是

$$
x[n] = 2000\sin[(2\pi f_0) nT_s] + 1500\sin[(2\pi \times 0.3f_0) nT_s] + 500\sin[(2\pi \times 5f_0) nT_s]
$$

这里 $f_0 = 20\mathrm{kHz}$ , 采样周期则是 $T_s=1/f_s=1/25\mathrm{MHz}$ 。 这个信号是正弦波的叠加，由于输入是一个 16 位的符号数，所以这是个相对小的信号。

## Verilog_PWM

There is also a verilog implementation of 8-bit PWM, which is 'pwmer.v'. 'top_tb.v' is testbench, whose input test signal is similar to the one of SDM.

这里也有一个 8 位 PWM 的 Verilog 实现 'pwmer.v' 。 'top_tb.v' 是 testbench ，其输入测试信号和 SDM 的相似。