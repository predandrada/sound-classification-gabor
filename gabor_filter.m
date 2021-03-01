% Ex 1 -- implementing a Gabor filter

function [complex_h, cos_h, sin_h] = gabor_filter(size, sigma, freq)
    % computing the gaussian filter
    
    complex_h = zeros(1, size);
    cos_h = zeros(1, size);
    sin_h = zeros(1, size);
    
    g = zeros(1, size);
    u = size/2;
    
    for k = 1:size
        aux = ((k-u)*(k-u))/(2*(sigma*sigma));
        g(k) = (1/(sigma*sqrt(2*pi))) * exp(-aux);

        % modulating the gaussian
        complex_h(k) = g(k) * (cos(2*pi*freq*k) + 1i*sin(2*pi*freq*k));
        cos_h(k) = g(k) * cos(2*pi*freq*k);
        sin_h(k) = g(k) * sin(2*pi*freq*k);
    end
end