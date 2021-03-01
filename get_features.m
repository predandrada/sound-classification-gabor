function [filters, result_mat] = get_features(sounds, fs, method, plot_figs)

M = 12;
samples = size(sounds, 1);
dataset_sz = size(sounds, 2);


sz = 1102; % changed name due to conflict with size()
freq = [0.0027, 0.0089, 0.0173, 0.0284, 0.0433, 0.0632, 0.0898, 0.1254, 0.1730, 0.2365, 0.3215, 0.4350];
sigma = [187.2109, 140.0663, 104.7939, 78.4041, 58.6599, 43.8878, 32.8357, 24.5668, 18.3803, 13.7516, 10.2886, 7.6977];

cos_filters = zeros(M, sz);
sin_filters = zeros(M, sz);
exp_filters = zeros(M, sz);

%  Ex 2 -- creating the filter set
for i = 1:M
    [comp, cos_i, sin_i] = gabor_filter(sz, sigma(i), freq(i));
    exp_filters(i, :) = comp;
    cos_filters(i, :) = cos_i;
    sin_filters(i, :) = sin_i;
end

if plot_figs == true
    % plotting the results of the first parameters
    figure;
    plot(1:sz, cos_filters(1, :));
    title("Gabor filter - cos");
    
    figure;
    plot(1:sz, sin_filters(1, :));
    title("Gabor filter - sin");

    
    % Ex 3 -- plotting the spectrum of the filters
    % for cos
    figure;
    for i = 1:M
        hold on;
        spectrum = fft(cos_filters(i, :));
        spectrum = spectrum(1:sz/2);
        plot(1:sz/2, abs(spectrum));
    end
    
    xlabel("Frequency component");
    ylabel("Magnitude");
    title("Gabor Filters - cos");
    
    % for sin
    figure;
    for i = 1:M
        hold on;
        spectrum = fft(sin_filters(i, :));
        spectrum = spectrum(1:sz/2);
        plot(1:sz/2, abs(spectrum));
    end
    
    xlabel("Frequency component");
    ylabel("Magnitude");
    title("Gabor Filters - sin");
end

% applying the filters
if method == 0
    result_mat = get_result_conv(sounds, cos_filters, dataset_sz, M);
    
elseif method == 1
    result_mat = get_stride_conv(sounds, cos_filters, sin_filters, exp_filters, dataset_sz, fs, samples, M);
end

% returning all the filters
filters = [cos_filters; sin_filters; exp_filters];
end
