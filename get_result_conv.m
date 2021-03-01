% Ex 4 -- convolution
function [result_mat] = get_result_conv(sounds, cos_filters, dataset_sz, M)
result_mat = zeros(dataset_sz, 2*M);
% going through each sound
for i = 1:dataset_sz
    % doing the convolution with each filter
    for j = 1:M
        y = conv(cos_filters(j, :), sounds(:, i));
        % computing the mean & std for y
        result_mat(i, j*2-1) = mean(y);
        result_mat(i, j*2) = std(y);
    end
end
end