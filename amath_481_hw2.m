clc; clear all; close all;

xspan = -4:.02:4;
x_interior = xspan(2:end-1);
A = diag(2/.02^2 + x_interior.^2);
off_diags = -1 * ones(1,length(x_interior) - 1)/.02^2;
A_upper = diag(off_diags, 1);
A_lower = diag(off_diags, -1);
A = A + A_upper + A_lower;
A(1,1) = 2/(3*(.02^2)) + 3.98^2;
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
for n = 1:5
    norm = trapz(xspan, eig_functions(:,n).^2); % Think my norm is wrong?
    eig_functions(:,n) = eig_functions(:,n)/norm;
end
% plot(xspan, eig_functions(:,5))

A1 = sortrows(abs(eig_functions)')';
A2 = sort(solution_eigs);
save A1.dat A1 -ascii
save A2.dat A2 -ascii
%plot(xspan, A1(:,5))

%%
clc; clear all; close all;
% delta_x = 13+1/3; delta_y = 8.5714;
% A = -2/delta_x^2 - 2/delta_y^2;
% B = 1/delta_x^2;
% C = 1/delta_y^2;
% Thought I heard him say something about just using integers in class?
A = -4; B = 1; C = 1;
center_diag = A*ones(32,1);
upper_1 = C * ones(32,1); 
lower_1 = upper_1;
upper_2 = B * ones(32,1);
lower_2 = upper_2;
upper_3 = upper_2;
lower_3 = upper_2;
M = full(spdiags([center_diag upper_1 upper_2 upper_3 lower_1 lower_2 lower_3], [0 1 8 24 -1 -8 -24], 32, 32));
for n = 0:3
    if n < 3
        M((n+1)*8,9+8*n) = 0;
    end
    M((n+1)*8,(n)* 8 +1) = C; 
    if n <3
    M((n+1)*8 +1, (n+1)*8) = 0;
    M((n+1)*8 +1, 8*(n+2)) = C;
    end
end
A3 = M;
save A3.dat A3 -ascii
    
    
    
