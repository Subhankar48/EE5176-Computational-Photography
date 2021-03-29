function A_matrix = blur_matrix(code_seq, N)
    exposure_time = length(code_seq);
    N_prime = N + (exposure_time-1);
    A_matrix = zeros(N_prime, N);
    for i = 1:N
        movement = (i-1);
        A_matrix(1+movement:exposure_time+movement, i) = code_seq;
    end
    A_matrix = A_matrix/sum(code_seq);
end