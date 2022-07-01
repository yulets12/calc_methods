function lab3()
    clc;
    NN = 0;
    show_points = 1;
    zs = 1;
    otr = 3;
    N = 0;  
    a = 0;
    b = 1;
    eps = 1e-6;
    if zs
        [x1, x2, x3, f1, f2, f3] = zol_sech(a, b, eps);
    else
        x1 = a;
        x2 = (a+b)/2;
        x3 = b;
        f1 = f(x1);
        f2 = f(x2);
        f3 = f(x3);
    end
    %N = 3; 
    iter = 1;
    xarr = [x1 x3];
    yarr = [f1 f3];
    a1 = (f2-f1)/(x2-x1);
    a2 = ((f3-f1)/(x3-x1)-(f2-f1)/(x2-x1))/(x3-x2);
    xmin = (x1+x2 - a1/a2)/2; 
    fmin = f(xmin);
    fprintf("Итерация %d: x1=%.10f, x2=%.10f, x3=%.10f, xmin=%.10f\n", iter, x1, x2, x3, xmin);
    x0 = make_iter();
    while abs(xmin-x0) > eps
        fprintf("Итерация %d: x1=%.10f, x2=%.10f, x3=%.10f, xmin=%.10f\n", iter, x1, x2, x3, xmin);
        x0 = make_iter();
    end
    fprintf("Итерация %d: x1=%.10f, x2=%.10f, x3=%.10f, xmin=%.10f\n", iter, x1, x2, x3, xmin);
    iter = iter + 1;    
    x0 = xmin;
    f0 = fmin;
    fprintf("x*=%.10f, f*=%.10f\n",  x0, f0);
    fprintf("Количество вызовов f: %d\n", N);
    %x0 - 0.111
    NN

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
        N = N+1000;
        NN = NN+1;
    end

    function x0=make_iter()
        iter = iter+1;
        x0 = xmin;
        if xmin < x2
            if fmin > f2
                if otr == 1 % для печати отрезков
                    xarr = [xarr x3];
                    yarr = [yarr f3];
                end
                otr = 1;
                x1 = xmin;
                f1 = fmin;
                xarr = [xarr x1];
                yarr = [yarr f1];
            else
                if otr == 3 % для печати отрезков
                    xarr = [xarr x1];
                    yarr = [yarr f1];
                end
                otr = 3;
                x3 = x2;
                f3 = f2;
                x2 = xmin;
                f2 = fmin;
                xarr = [xarr x3];
                yarr = [yarr f3];
            end
        else
            if fmin > f2
                if otr == 3 % для печати отрезков
                    xarr = [xarr x1];
                    yarr = [yarr f1];
                end
                otr = 3;
                x3 = xmin;
                f3 = fmin;
                xarr = [xarr x3];
                yarr = [yarr f3];
            else
                if otr == 1 % для печати отрезков
                    xarr = [xarr x3];
                    yarr = [yarr f3];
                end
                otr = 1;
                x1 = x2;
                f1 = f2;
                x2 = xmin;
                f2 = fmin;
                xarr = [xarr x1];
                yarr = [yarr f1];
            end            
        end
        a1 = (f2-f1)/(x2-x1);
        a2 = ((f3-f1)/(x3-x1)-(f2-f1)/(x2-x1))/(x3-x2);
        xmin = (x1+x2 - a1/a2)/2; 
        fmin = f(xmin);       
    end

    function [x1, x2, x3, f1, f2, f3]=zol_sech(a, b, eps)
        flag = 1;
        tau = (5^(1/2) - 1)/2;
        l = b - a;
        xl = b - tau*l;
        fl = f(xl);
        xr = a + tau*l;
        fr = f(xr);
        while l > 2*eps
            if fl >= fr
                fb = f(b);
                if fr < fb
                    x1 = xl; f1 = fl;
                    x2 = xr; f2 = fr;
                    x3 = b; f3 = fb;
                    flag = 0;
                    break;
                end
                a = xl;
                l = b - a;
                xl = xr;
                fl = fr;
                xr = a + tau*l;
                fr = f(xr);        
            else
                fa = f(a);
                if f(a) >= fl
                    x1 = a; f1 = fa;
                    x2 = xl; f2 = fl;
                    x3 = xr; f3 = fr;
                    flag = 0;
                    break;
                end                
                b = xr;
                l = b - a;
                xr = xl;
                fr = fl;
                xl = b - tau*l;
                fl = f(xl);
            end         
        end
        if flag
            x1 = a; f1 = f(a);
            x2 = (a+b)/2; f2 = f(x2);
            x3 = b; f3 = f(b);
        end       
    end
end
    