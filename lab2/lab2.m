function lab2()
    clc;
    show_points = 1;
    flag = 2; % для отрисовки отрезков
    N = -2;  % для отрисовки отрезков
    a = 0;
    b = 1;
    eps = 1e-6;
    tau = (5^(1/2) - 1)/2;
    l = b - a;
    x1 = b - tau*l;
    f1 = f(x1);
    x2 = a + tau*l;
    f2 = f(x2);
    iter = 1;
    xarr = [a b];
    yarr = [f(a) f(b)];
    fprintf("Итерация %d: x1=%.10f, x2=%.10f, l=%.10f\n", iter, x1, x2, l);
    while l > 2*eps
        if f1 >= f2
            if flag == 1 % для отрисовки отрезков
                xarr = [xarr b];
                yarr = [yarr f(b)];
                N = N - 1;
            end
            flag = 1;
            xarr = [xarr x1];
            yarr = [yarr f1];
            a = x1;
            l = b - a;
            x1 = x2;
            f1 = f2;
            x2 = a + tau*l;
            f2 = f(x2);        
        else
            if flag == 2 % для отрисовки отрезков
                xarr = [xarr a];
                yarr = [yarr f(a)];
                N = N - 1;
            end
            flag = 2;
            xarr = [xarr x2];
            yarr = [yarr f2];
            b = x2;
            l = b - a;
            x2 = x1;
            f2 = f1;
            x1 = b - tau*l;
            f1 = f(x1);
        end         
        iter = iter + 1;
        fprintf("Итерация %d: x1=%.10f, x2=%.10f, l=%.10f\n", iter, x1, x2, l);
    end
    iter = iter + 1;
    fprintf("Итерация %d: x1=%.10f, x2=%.10f, l=%.10f\n", iter, x1, x2, l);
    
    x0 = (a+b)/2;
    f0 = f(x0);
    fprintf("x*=%.10f, f*=%.10f\n",  x0, f0);
    fprintf("Количество вызовов f: %d\n", N);
    %x0 - 0.111

    figure
    x = 0:1e-2:1;
    y = arrayfun(@(xi) f(xi), x);
    if show_points
        plot(x, y, x0, f0, '*', xarr, yarr, 'black-');
    else
        plot(x, y, x0, f0, '*');
    end
    
    function y=f(x)
        %y = exp((x^4 + x^2 - x + 5^(1/2))/5) + sinh((x^3 + 21*x +9)/(21*x + 6)) + 3.0;
        y = (x-0.111)^8;
        N = N +1;
    end
end
    