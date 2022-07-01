function lab1()
    clc;
    show_points = 1;
    N = 0;
    a = 0;
    b = 1;
    eps = 1e-6;
    x0 = a;
    f0 = f(a);
    delta = a-b;
    iter = 1;
    xarr = [];
    yarr = [];
    while abs(delta) > eps
        delta = -delta/4;
        fprintf("Итерация %d: x0=%.10f, f0=%.10f, delta=%.10f\n", iter, x0, f0, delta);
        xarr = [xarr x0];
        yarr = [yarr f0];
        iter = iter + 1;
        x1 = x0 + delta;
        f1 = f(x1);
        while f0>f1 && a<=x1 && x1<=b
            x0 = x1;
            f0 = f1;
            xarr = [xarr x0];
            yarr = [yarr f0];
            x1 = x0 + delta;
            f1 = f(x1);
            fprintf("Итерация %d: x0=%.10f, f0=%.10f, delta=%.10f\n", iter, x0, f0, delta);
            iter = iter + 1;
        end
        x0 = x1;
        f0 = f1;
    end
    fprintf("x*=%.10f, f*=%.10f\n",  x0, f0);
    fprintf("Количество вызовов f: %d\n", N);
    x0 - 0.111
    
    figure
    x = 0:1e-2:1;
    y = arrayfun(@(xi) f(xi), x);
    if show_points
        plot(x, y, x0, f0, '*', xarr, yarr, 'o');
    else
        plot(x, y, x0, f0, '*');
    end
    
    function y=f(x)
        %y = exp((x^4 + x^2 - x + 5^(1/2))/5) + sinh((x^3 + 21*x +9)/(21*x + 6)) + 3.0;
        y = (x-0.111)^8;
        N = N+1;
    end
end
    