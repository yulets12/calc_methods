function lab4()
    clc;
    show_points = 1;
    N = 0;
    a = 0;
    b = 1;
    eps = 1e-2;
    delta = 1e-2;
    x0 = (a+b)/2;
    f0 = f(x0);
    fr = f(x0+delta);
    fl = f(x0-delta);
    f1 = (fr-fl)/(2*delta);
    f2 = (fr - 2*f0+fl)/(delta^2);
    iter = 1;
    xarr = [x0];
    yarr = [f0];
    fprintf("Итерация %d: x0=%.10f, f0=%.10f\n", iter, x0, f0);
    while abs(f1) >= eps
        x0 = x0 - f1/f2;
        xarr = [xarr x0];
        f0 = f(x0); %N = N -1;
        yarr = [yarr f0];
        iter = iter + 1;
        fprintf("Итерация %d: x0=%.10f, f0=%.10f\n", iter, x0, f0);
        fr = f(x0+delta);
        fl = f(x0-delta);
        f1 = (fr-fl)/(2*delta);
    end
    iter = iter + 1;
    fprintf("Итерация %d: x0=%.10f, f0=%.10f\n", iter, x0, f0);
    fprintf("x*=%.10f, f*=%.10f\n",  x0, f0);
    fprintf("Количество вызовов f: %d\n", N);
    %x0 - 0.111
    
    figure
    x = 0:1e-2:1;
    y = arrayfun(@(xi) f(xi), x);
    if show_points
        plot(x, y, x0, f0, '*', xarr, yarr, 'o');
    else
        plot(x, y, x0, f0, '*');
    end
    
    function y=f(x)
       % y = exp((x^4 + x^2 - x + 5^(1/2))/5) + sinh((x^3 + 21*x +9)/(21*x + 6)) + 3.0;
        y = (x-0.111)^4;
        N = N+1;
    end
end
    