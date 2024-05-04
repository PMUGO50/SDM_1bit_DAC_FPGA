function postcheck()
    fs = 25e6; %drived by main freq = 25MHz
    A = 30000; %digital gain of quantified signal
    x_origin = readmatrix("tbwave.csv", 'OutputType', 'string');
    x_origin = signhex2dec(x_origin)./A;
    pdmout = readmatrix("pdmout.csv");
    fb = 2e4; %fb = omega_b/(2pi) = 1/(2pi*tau) = RC/(2pi)
    x_lpf = lowpass(pdmout, fb, fs);
    specploter(pdmout, fs);
    waveploter(x_origin, x_lpf, fs);
end

function y = signhex2dec(x)
    y = [];
    for i=1:length(x)
        sign = extract(x(i),1);
        switch sign %positive
            case {'0', '1', '2', '3', '4', '5', '6', '7'}
                y(i) = hex2dec(x(i,:));
            otherwise
                y(i) = hex2dec(x(i,:)) - 2^16;
        end
    end
end

function x_lpf = lowpass(pdmout, fb, fs)
    pdmout = pdmout.*2 - 1;
    x_lpf = [];
    x_lpf(1) = 0; %initial condition
    for n=2:length(pdmout)
        x_lpf(n) = (fs*x_lpf(n-1) + (2*pi*fb).*pdmout(n)) / (fs+2*pi*fb);
    end
end

function specploter(pdmout, fs)
    N = length(pdmout);
    f = 0:(N/2-1);
    f = f./N.*fs;
    pdmfft = abs(fft(pdmout));
    %pdmfft = mag2db(pdmfft);
    pdmfft = pdmfft(1:N/2);

    figure(1);
    % subplot(2,1,1);
    ax = gca;
    plot(f, pdmfft, '-', 'LineWidth', 1, 'Color', '#FF8C00');
    grid on;
    ax.Title.String = 'SDM FFT';
    ax.XLabel.String = 'freq/Hz';
    ax.XScale = 'log';
    %ax.YLabel.String = 'dB';
    ax.YAxis.Exponent = 3;

    ax.XGrid = 'on';
    ax.YGrid = 'on';
    ax.GridLineStyle = '--';
    saveas(gcf,'SDM1st_FFT.png');
end

function waveploter(x_origin, x_lpf, fs)
    t1 = 0:(length(x_origin)-1);
    t1 = t1./fs;
    figure(2);
    % subplot(2,1,2);
    ax = gca;
    plot(t1.*1e6, x_origin, '-', 'LineWidth', 1, 'Color', '#228B22');
    hold on;

    t2 = 0:(length(x_lpf)-1);
    t2 = t2./fs;
    plot(t2.*1e6, x_lpf, '-', 'LineWidth', 1, 'Color', '#4169E1');
    legend("Origin", "SDM-DAC");
    ax.Title.String = 'Origin/DAC Wave';
    ax.XLabel.String = 't/us';
end