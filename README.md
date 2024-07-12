# SDM_1bit_DAC_FPGA

本仓库是用 Verilog 对 1 位 sigma-delta DAC 的数字部分在 FPGA 上的实现，即 sigma-delta 调制器。

1 位 SDM 是脉冲密度调制的一种方式。它将输出一个在 1 和 0 之间跳变的信号 (即 1 位的信号) 。该信号接下来可以被送入一个模拟 LPF 中并得到模拟信号。

- [X] 一二阶 SDDAC simulink 仿真

- [X] 一二阶 SDDAC Verilog 行为仿真

- [X] 一二阶 SDDAC Verilog RTL 逻辑综合

- [ ] 一二阶 SDDAC Verilog 上板测试

## Verilog_SDM

一阶 1 位 SDM 的 Verilog 实现是 'SDM1st.v' ，二阶的则是 'SDM2nd.v' 。

'top_tb.v' 是 testbench ，运行 testbench 将得到一个 PDM 信号 'pdmout.csv' 。'tbwave.csv' 是 testbench 仿真时的输入信号。这个信号是

$$
x[n] = 2000\sin[(2\pi f_0) nT_s] + 1500\sin[(2\pi \times 0.3f_0) nT_s] + 500\sin[(2\pi \times 5f_0) nT_s]
$$

这里 $f_0 = 20\mathrm{kHz}$ , 采样周期则是 $T_s=1/f_s=1/25\mathrm{MHz}$ 。 这个信号是正弦波的叠加，由于输入是一个 16 位的符号数，所以这是个相对小的信号。

## Verilog_PWM

这里也有一个 8 位 PWM 的 Verilog 实现 'pwmer.v' 。 'top_tb.v' 是 testbench ，其输入测试信号和 SDM 的相似。