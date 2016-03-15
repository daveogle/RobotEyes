function [C] = Euclidian(W1, W2)

    dif = W1-W2;
    C = gcd(dif);
    sum(C);
    
end