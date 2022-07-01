function fmin()
    clc;
    N = 0;
    a = 0;
    b = 1;
    options = optimset('Display','iter','TolX', 1e-6);
    [x0, f0] = fminbnd(@f, a, b, options);
    fprintf("x*=%.10f, f*=%.10f\n",  x0, f0);
    fprintf("Количество вызовов f: %d\n", N);
    
    function y=f(x)
        y = exp((x^4 + x^2 - x + 5^(1/2))/5) + sinh((x^3 + 21*x +9)/(21*x + 6)) + 3.0;
        %y = (x-0.111)^8;
        N = N+1;
    end
end
    