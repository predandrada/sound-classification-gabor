% Ex 5 -- fast filtering

function [result_mat] = get_stride_conv(sounds, cos_filters, sin_filters, exp_filters, dataset_sz, fs, samples, M)
window_sz = floor(fs * 25 / 1000);
block_sz = floor(fs * 35 / 1000);
F = floor(samples/block_sz);
result_mat = zeros(dataset_sz, 2*M);

% iterating through each of the sounds
for i = 1:dataset_sz
    o = zeros(F, M); % for each sound
    % looping through each window
    for j = 1:F
        % iterating through every filter
        for n = 1:M
            current_win = sounds(((j-1)*block_sz + 1):((j-1)*block_sz + window_sz), i);
            
            % reversing the filter is redundant due to its symmetry
            o_c = cos_filters(n, :) * current_win;
            o_s = sin_filters(n, :) * current_win;
            o_e = exp_filters(n, :) * current_win;
            
            o(j, n) = sqrt(o_c^2 + o_s^2);
            
            % displaying the difference
            if abs(o - abs(o_e)) >= 10^(-10)
                disp('no');
            end
        end
    end
    % start computing the mean & standard deviation for sound i
    % looping through "columns"
    for j = 1:M
        result_mat(i, j*2-1) = mean(o(:, j));
        result_mat(i, j*2) = std(o(:, j));
    end
end
end