function yp = lotka(t,y)
    
    yp = diag([1 - .01*y(2), -1 + .02*y(1)])*y;

end