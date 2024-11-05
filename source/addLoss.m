function lossy_coeffs = addLoss(coeffs,sigma)
syms s

p = poly2sym(coeffs,s);
new_p = subs(p,s,s+sigma);
lossy_coeffs = sym2poly(new_p);

end