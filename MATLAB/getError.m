function [ Err ] = getError( U,correctsolution )
%%% Estimating error
[l,k] = size(U);
Err = zeros(1,k);
for i = 1:k
    %if min(abs(correctsolution(:,i))) < 1e-15
    %    Err(i) = norm(correctsolution(:,i)-U(:,i) ,Inf);
    %else
    %Err(i) = max(abs(correctsolution(:,i)-U(:,i)))/max(max(abs(correctsolution(:,i))),max(abs(U(:,i))));
    Err(i) = max(abs(correctsolution(:,i)-U(:,i)))/max(abs(correctsolution(:,i)));
    %Err(i) = norm(correctsolution(:,i)-U(:,i) ,Inf)/max(max(abs(correctsolution(:,:))));
    %end
end
%Err = max(abs(U-correctsolution));
%err
end

