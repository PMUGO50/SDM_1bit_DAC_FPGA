function wavegen()
    fs = 25e6; %drived by main freq = 25MHz
    f0 = 1e4; %voice freq: 20Hz-20kHz
    N = round(3*fs/f0);
    t = 0:(N-1);
    t = t./fs;
    A = 30000; %digital gain of quantified signal must be less than 32767

    x = round(A.*xgen(t, f0));
    waveploter(t, x, fs, N);
    x = dec2hex(x, 4);
    writematrix(x, "tbwave.csv");
    fprintf("sampnum = %d;\n", N);
end

function x = xgen(t, f0)
    x = sin(2*pi*f0*t);
end

function waveploter(t, x, fs, N)
    figure();
    subplot(2,1,1);
    ax = gca;
    plot(t.*1e6, x, '-', 'LineWidth', 1, 'Color', '#228B22');
    ax.Title.String = 'Wave';
    ax.XLabel.String = 't/us';

    subplot(2,1,2);
    ax = gca;
    f = (0:(N-1))./N.*fs./1e6;
    plot(f, fft(x), '-', 'LineWidth', 1, 'Color', '#FF8C00');
    ax.Title.String = 'FFT';
    ax.XLabel.String = 'freq/MHz';
end