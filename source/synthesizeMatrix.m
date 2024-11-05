function M_trans = synthesizeMatrix(n,y21_num, y22_num, y_denum, Kinf)

[r21 ,~] = residue(y21_num,y_denum);
[r22 ,jlambda] = residue(y22_num,y_denum);

lambda = real(jlambda/1j);

[lamdba_sorted, idx] = sort(lambda);
r21 = real(r21(idx));
r22 = real(r22(idx));

Mkk = -lamdba_sorted;
MSk = r21./sqrt(r22);
MSL = Kinf;
MLk = sqrt(r22);

M_trans = zeros(n+2,n+2);
M_trans(1,end) = MSL; % top right element
M_trans(end,1) = MSL; % bottom left element
M_trans(1,2:end-1) = MSk; % first row
M_trans(2:end-1,1) = MSk; % first column
M_trans(2:end-1,end) = MLk; % last column
M_trans(end,2:end-1) = MLk; % last row
M_trans(2:end-1,2:end-1) = diag(Mkk);

end