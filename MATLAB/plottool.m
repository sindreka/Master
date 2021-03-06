function plottool(m,n,simtime,K,k,eqn,alg,int,restart,prob,conv,para,data,type,help,name,save,option,placement,PMint)
%plottool(m,n,simtime,K,k,'eqn',alg,int,restart,prob,conv,para,[data],{'type'},[help],{'name'},save,option,EToption,PMint)
% a tool that helps make plotting easier.
%input
% m: number of points in eqch spacial direction X
% n: restart variable (size of orthogonal space) X
% k: number of space in time. X
% eqn: says something about with algorithm to solve
% alg(1,2,3): declares with ortogonalisation method to use X
% int(1,2,3): declares with integration method to use X
% restart(0,1): should the method restart or not X
% prob: says smoething about with particular problem to solve
% conv: convergence criterion used in arnoldi og KPM X
% para: currently nothing
% data(1,2,3,4,5,6): what data is relevant to plot
% type: with kind of plot
% help(0 or [1,smth]): adds a helpline increasing with smth exponetial
% name: name of saved picture
% save(0,1): boolean value for saving or not
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Special:
% This tool can plot several diffenet plots.
% start a list X with -1 to make this be the differnent points on the x axis
% Start a list with -2 to make it diffenret graphs.
if nargin < 18
    option = 1;
end
if length(help) < 3 && help(1)
    help(3) = 1;
end
if help == 0
    help = zeros(length(data),3);
end
if ~exist('PMint','var')
    PMint = 1;
end
if ~exist('placement','var')
    placement = 'Best';
end
if placement == 0
    placement = 'Best';
end




linetype = {'b:o','r:x','g:+','m:.','c:*','y:s','k:d','k:^','k:v','k:<','k:>','k:p','k:h'};




[p,bc] = getPandB(m,n,simtime,K,k,alg,int,restart,prob,conv,para,PMint);
ant1 = length(p)-1; ant2 = length(bc)-1;
a = 1; b = 1; c = 1; d = 1; e = 1; f = 1; g = 1; h = 1; aa = 1; bb = 1; cc = 1; dd = 1;
utdata = zeros(ant2,ant1,14);
for i = 1:ant1
    [a0,b0,c0,d0,e0,f0,g0,h0,aa0,bb0,cc0,dd0] = addOne(m,n,simtime,K,k,alg,int,restart,prob,conv,para,PMint,a,c,b,d,e,f,g,h,aa,bb,cc,dd,-1);
    a = max(1,a0*(a0-a)); b = max(1,b0*(b0-b)); c = max(1,c0*(c0-c)); d = max(1,d0*(d0-d)); e = max(1,e0*(e0-e)); f = max(1,f0*(f0-f)); g = max(1,g0*(g0-g)); h = max(1,h0*(h0-h)); aa = max(1,aa0*(aa0-aa)); bb = max(1,bb0*(bb0-bb)); cc = max(1,cc0*(cc0-cc)); dd = max(1,dd0*(dd0-dd));
    for j = 1:ant2
        [a,b,c,d,e,f,g,h,aa,bb,cc,dd] = addOne(m,n,simtime,K,k,alg,int,restart,prob,conv,para,PMint,a,c,b,d,e,f,g,h,aa,bb,cc,dd,-2);
        %if option == 1
            utdata(j,i,:) = solver(m(a),n(b),simtime(bb),K(cc),k(c),eqn,alg(f),int(aa),restart(g),prob(h),conv(d),para(e),0,PMint(dd));
        %elseif option == 2 % energyTest(m,n,k,simtime,eqn,restart,prob,conv,figvar)
        %    return 
        %    utdata(j,i,:) = energyTest(m(a),n(b),simtime(bb),k(c),eqn,int(aa),restart(g),prob(h),conv(d),0,EToption,0,0,PMint(dd));
        %end
        %utdata(j,i,:) = energyTest(m(a),n(b),k(c),eqn,alg(f),int(aa),restart(g),prob(h),conv(d),para(e));
    end
end
if data(1) == -3
        close all
    pause(0.5)
    j = 1;
    for i = data(2:end)
        if strcmp(type,'plot')
            plot(p(2:end),utdata(1,:,i),char(linetype(j)),'LineWidth',4)
        elseif strcmp(type,'loglog')
            loglog(p(2:end),utdata(1,:,i),char(linetype(j)),'LineWidth',4)
        elseif strcmp(type,'semilogx')
            semilogx(p(2:end),utdata(1,:,i),char(linetype(j)),'LineWidth',4)
        elseif strcmp(type,'semilogy')
            semilogy(p(2:end),utdata(1,:,i),char(linetype(j)),'LineWidth',4)
        elseif strcmp(type, 'table')
            format long
            format shortEng
            format compact
            outdata = ([bc',[p(2:end);utdata(:,:,i)]])'
            format short
            break
        end
        j = j + 1;
        hold on
    end
    iter = num2str(max(max(utdata(:,:,1))));
    [ylab,xlab,leg,additionalInfo,helpinfo] = getLabels(ant2,m,n,simtime,K,k,eqn,alg,int,restart,prob,conv,para,data,PMint,iter);
    if help(1)
        plot(p(2:end),p(2:end).^help(i,2)*help(i,3),'k-')
        number = num2str(help(kk,2));
        if number == '1'
            stri = ['\propto', helpinfo];    
        else
            stri = ['\propto', helpinfo , '^{',number,'}'];
        end
        leg(end+1) = {stri};
    end
    ylabel(ylab);
    xlabel(xlab);
    %title(char(additionalInfo))
    
    legend(char(leg),'location',placement);
    h = set(findall(gcf,'-property','FontSize'), 'Fontsize',24);
    %set(h,'Location','NE');
    if save
        pause(0.5)
        drawnow
        pause(0.5)
        location = strcat('/home/shomeb/s/sindreka/Master/MATLAB/fig/',char(name));
        saveas(gcf,location,'fig');
        saveas(gcf,location,'jpeg');
    end

    %close all
else
for kk = 1:length(data)
    close all
    pause(0.5)
    for i = 1:ant2
        if (~length(alg) == 1 && length(alg(i+1)) ~= 3) && (data(kk) == 1 || data(kk) == 5 || data(kk) == 6) && alg(i+1) == 3
            continue
        elseif strcmp(type(kk),'plot')
            plot(p(2:end),utdata(i,:,data(kk)),char(linetype(i)),'LineWidth',4)
        elseif strcmp(type(kk),'loglog')
            loglog(p(2:end),utdata(i,:,data(kk)),char(linetype(i)),'LineWidth',4)
        elseif strcmp(type(kk),'semilogx')
            semilogx(p(2:end),utdata(i,:,data(kk)),char(linetype(i)),'LineWidth',4)
        elseif strcmp(type(kk),'semilogy')
            semilogy(p(2:end),utdata(i,:,data(kk)),char(linetype(i)),'LineWidth',4)
        elseif strcmp(type(kk), 'table')
            format long
            format shortEng
            format compact
            outdata = ([bc',[p(2:end);utdata(:,:,data(kk))]])'
            format short
            break
        end
        hold on
    end
    if strcmp(type(kk), 'table')
        continue
    end
    %iter = max(max(utdata(1,:,:)));
    [ylab,xlab,leg,additionalInfo,helpinfo] = getLabels(ant2,m,n,simtime,K,k,eqn,alg,int,restart,prob,conv,para,data(kk),PMint,conv);
    if help(kk,1)
        plot(p(2:end),p(2:end).^help(kk,2)*help(kk,3),'k-')
        number = num2str(help(kk,2));
        if number == '1'
            stri = ['\propto', helpinfo];    
        else
            stri = ['\propto', helpinfo , '^{',number,'}'];
        end
        leg(end+1) = {stri};
    end
    ylabel(ylab);
    xlabel(xlab);
    %title(char(additionalInfo))
    
    legend(char(leg), 'location', placement);
    h = set(findall(gcf,'-property','FontSize'), 'Fontsize',24);
    %set(h,'Location','NE');
    if save
        pause(0.5)
        drawnow
        pause(0.5)
        location = strcat('/home/shomeb/s/sindreka/Master/MATLAB/fig/',char(name(kk)));
        saveas(gcf,location,'fig');
        saveas(gcf,location,'jpeg');
    end

    %close all
end
end
end

function [p,b] = getPandB(m,n,simtime,K,k,alg,int,restart,prob,conv,para,PMint)
if length(m) > 1
    if m(1) == -1
        p = m;
    elseif m(1) == -2
        b = m;
    end
end

if length(n) > 1
    if n(1) == -1
        p = n;
    elseif n(1) == -2
        b = n;
    end
end


if length(K) > 1
    if K(1) == -1
        p = K;
    elseif K(1) == -2
        b = K;
    end
end


if length(k) > 1
    if k(1) == -1
        p = k;
    elseif k(1) == -2
        b = k;
    end
end

if length(para) > 1
    if para(1) == -1
        p = para;
    elseif para(1) == -2
        b = para;
    end
end
if length(alg) > 1
    if alg(1) == -1
        p = alg;
    elseif alg(1) == -2
        b = alg;
    end
end
if length(int) > 1
    if int(1) == -1
        p = int;
    elseif int(1) == -2
        b = int;
    end
end
if length(restart) > 1
    if restart(1) == -1
        p = restart;
    elseif restart(1) == -2
        b = restart;
    end
end
if length(prob) > 1
    if prob(1) == -1
        p = prob;
    elseif prob(1) == -2
        b = prob;
    end
end

if length(simtime) > 1
    if simtime(1) == -1
        p = simtime;
    elseif simtime(1) == -2
        b = simtime;
    end
end

if exist('p','var') && exist('b','var')
    return
end
if length(conv) > 1
    if conv(1) == -1
        p = conv;
    elseif conv(1) == -2
        b = conv;
    end
end

if length(PMint) > 1
    if PMint(1) == -1
        p = PMint;
    elseif PMint(1) == -2
        b = PMint;
    end
end

end

function [a,b,c,d,e,f,g,h,aa,bb,cc,dd] = addOne(m,n,simtime,K,k,alg,int,restart,prob,conv,para,PMint,a,c,b,d,e,f,g,h,aa,bb,cc,dd,var)
if m(1) == var
    a = a + 1;
end
if n(1) == var
    b = b + 1;
end
if simtime(1) == var
    bb = bb + 1;
end
if K(1) == var
    cc = cc + 1;
end
if k(1) == var
    c = c + 1;
end
if conv(1) == var
    d = d + 1;
end
if para(1) == var
    e = e + 1;
end
if alg(1) == var
    f = f + 1;
end
if restart(1) == var
    g = g + 1;
end
if prob(1) == var
    h = h + 1;
end
if int(1) == var
    aa = aa + 1;
end

if PMint(1) == var
    dd = dd + 1;
end

end

