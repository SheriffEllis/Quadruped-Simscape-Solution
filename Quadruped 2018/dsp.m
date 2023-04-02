for N = 1:6
    G = tf(1,[(1/(0.25*pi))^(2*N) 1])
    
    bode(G)
    figure
end