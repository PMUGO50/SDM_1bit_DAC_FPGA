# SDM_1bit_DAC_FPGA

This repo is an implementation of 1-bit sigma-delta DAC (SDDAC) on FPGA with Verilog.

1-bit SDDAC is a kind of Pulse Density Modulation (PDM). Sigma-delta modulator (SDM) will output a signal jumping between 1 and 0 (that is 1-bit). Then this signal will be sent to an Analog Low Pass Filter (LPF) and finally generate an analog signal.

- [X] 1st-order SDDAC simulink simulation

- [X] 1st-order SDDAC Verilog behavioural simulation

- [X] 1st-order SDDAC Verilog RTL Systhesis

- [ ] 1st-order SDDAC Verilog board test

- [X] Adaptive SDDAC (1st and 2nd order) simulink simulation

- [ ] Adaptive SDDAC (1st and 2nd order) Verilog behavioural simulation

- [ ] Adaptive SDDAC (1st and 2nd order) Verilog RTL Systhesis

Note that **when adaptive method is applied, the output of SDM will not be 1-bit**.

本仓库是用 Verilog 对 1 位 sigma-delta DAC 在 FPGA 上的实现。

1 位 SDDAC 是脉冲密度调制的一种方式，Sigma-delta 调制器将输出一个在 1 和 0 之间跳变的信号 (即 1 位的信号) 。该信号接下来被输入到一个模拟的低通滤波器中并得到最终的输出。

- [X] 一阶 SDDAC simulink 仿真

- [X] 一阶 SDDAC Verilog 行为仿真

- [X] 一阶 SDDAC Verilog RTL 逻辑综合

- [ ] 一阶 SDDAC Verilog 上板测试

- [X] 自适应 SDDAC (一阶与二阶) simulink 仿真

- [ ] 自适应 SDDAC (一阶与二阶) Verilog 行为仿真

- [ ] 自适应 SDDAC (一阶与二阶) Verilog RTL 逻辑综合

注意**当采用自适应方法后，SDM 的输出就不再是 1 位的了**。

## Simulink

Simulink files are in 'simulink', in whcih 'simumod.slx' describes a commonly-seen SDM model, also with adaptive feedback. And 'simu_hdl_1st.slx' is a simulink model which describes SDM's Verilog implementaion and following LPF. It's not very similar to a commonly-seen SDM model, but shares a same priciple.

About adaptive method, see *Clemens M. Zierhofer, Adaptive Sigma–Delta Modulation With One-Bit Quantization*.

Simulink 文件在 'simulink' 中，'simumod.slx'描述了一个常见的 SDM 模型，并采用了自适应反馈。而 'simu_hdl_1st.slx' 这个 simulink 模型描述的是 SDM 的 Verilog 实现以及紧随其后的 LPF 。它与常见的 SDM 模型并不是很相似，但是原理是一致的。

关于自适应反馈，参照 *Clemens M. Zierhofer* 的 *Adaptive Sigma–Delta Modulation With One-Bit Quantization*.

## Verilog

### 1st-order 1-bit SDDAC

Verilog implementation of 1st-order 1-bit SDDAC is in 'first_order', where 'SDmodu.v' is SDDAC module, 'top_tb.v' is testbench.

'wavegen.m' will generate a testwave 'tbwave.csv', for now the wave is $\sin(2 \pi f_0 t)$ with f0 = 10kHz, which is between 20Hz and 20kHz (voice range).

Run testbench will give a PDM signal 'pdmout.csv', 'postcheck.m' will plot FFT of this PDM signal, which is 'SDM1st_FFT.png', and also a comparison of origin input signal and final output signal.

一阶 1 位 SDDAC 的 Verilog 实现在 'first_order' 中，'SDmodu.v' 是 SDDAC 主模块，'top_tb.v' 是 testbench。

'wavegen.m' 将产生一个测试波形 'tbwave.csv', 目前该波形是 $\sin(2 \pi f_0 t)$ ，这里 f0 = 10kHz ，该频率位于 20Hz 到 20kHz 之间 (即音频范围)。

运行 testbench 将给出 PDM 信号 'pdmout.csv'，'postcheck.m' 将绘制出该 PDM 信号的 FFT ，即这里的 'SDM1st_FFT.png' ，同时还将画出原输入信号和最终输出的信号对比图。