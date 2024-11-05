function M = transversal2Folded(N,M)
    for k=1:1:(N+2)/2                          
        for j=N+2-k:-1:k+2                     
            R=eye(N+2);
            theta=-atan(M(k,j)/M(k,j-1));
            R(j,j)=cos(theta);
            R(j-1,j-1)=cos(theta);
            R(j-1,j)=-sin(theta);
            R(j,j-1)=sin(theta);
            M=R*M*R';
        end
        for i=k+2:1:N+2-(k+1)                         
            R=eye(N+2);                                
            theta=atan(M(i,N+2-k+1)/M(i+1,N+2-k+1));
            R(i,i)=cos(theta);
            R(i+1,i+1)=cos(theta);
            R(i,i+1)=-sin(theta);
            R(i+1,i)=sin(theta);
            M=R*M*R';
        end
    end
end