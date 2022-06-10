%generates n x m matrix with k x l zeros in the center
function filter = generateEdgeRemovalFilter(n,m,k,l)
filter = zeros(17,17);
for i = 1:n
  for j = 1:m

        if  i >= (n-k)/2 && i <= (n - k)/2 + k && j >= (m-l)/2 && j <= (m-l)/2 + l
            filter(i,j) = 0;
        else
            filter(i,j) = 1/(n*m - k*l);
        end
  end    
end
return
end

