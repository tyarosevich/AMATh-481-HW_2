xspan = -4:.02:4;
A = diag(-2/.02^2 - xspan);
off_diags = ones(1,length(xspan) - 1)/.02^2;
A_upper = diag(off_diags, 1);
A_lower = diag(off_diags, -1);
A = A + A_upper + A_lower;
A(1,1) = 2/.02^3 - 16;
A(1, 2) = -5/.02^3;
A(1,3) = 4/.02^3;
A(1,4) = -1/.02^3;
A(end, end -3) = -1/.02^3;
A(end, end-2) = 4/.02^3;
A(end, end-1) = -5/.02^3;
A(end, end) = 2/.02^3 - 16;
[V,D] = eigs(A, 5, 'sm');


