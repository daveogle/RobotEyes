function [C] = Absolute(W1, W2)

    dif = W1-W2;
    C = abs(dif);
    sum(C);
    
end