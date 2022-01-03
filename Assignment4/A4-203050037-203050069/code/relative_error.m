% https://www.intechopen.com/books/matlab-a-fundamental-tool-for-scientific-computing-and-engineering-applications-volume-1/image-reconstruction-methods-for-matlab-users-a-moore-penrose-inverse-approach
function [error] = relative_error(sig1,sig2)
    error = norm((sig1-sig2))/norm(sig1);
end

