clc; clear all; close all;

xspan = -4:.02:4;
x_interior = xspan(2:end-1);
A = diag(2/.02^2 + x_interior.^2);
off_diags = -1 * ones(1,length(x_interior) - 1)/.02^2;
A_upper = diag(off_diags, 1);
A_lower = diag(off_diags, -1);
A = A + A_upper + A_lower;
A(1,1) = 2/(3*.02^2) + 3.98^2;
A(1,2) = -2/(3*.02^2);
A(end,end) = 2/(3*.02^2) + 3.98^2;
A(end, end - 1) = -2/(3*.02^2);
[V,D] = eigs(A, 5, 'sm');
solution_eigs = (diag(D));

new_row = zeros(1,5);

eig_functions = [new_row; V];
eig_functions = [eig_functions; new_row];
for n = 1:5
    eig_functions(1,n) = (4/3)*eig_functions(2,n) - (1/3) * eig_functions(3,n);
    eig_functions(end,n) = eig_functions(1,n);
end
plot(xspan, eig_functions(:,1))