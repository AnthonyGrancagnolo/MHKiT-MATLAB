function figure=plot_chakrabarti(H, lambda_w, D, options)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Plots, in the style of Chakrabarti (2005), relative importance of viscous,
%     inertia, and diffraction phemonena
% 
%     Chakrabarti, Subrata. Handbook of Offshore Engineering (2-volume set).
%     Elsevier, 2005.
% 
% Parameters
% ------------
%   H: integer, double or vector
%         Wave height [m]
%
%   lambda_w: integer, double or vector
%         Wave length [m]
%
%    D: integer, double or vector of 
%         Characteristic length [m]
%
%    savepath: string (optional)
%         path and filename to save figure.
%         to call: plot_chakrabarti(H,lambda_w,D,"savepath",savepath)
%         
% Returns
% ---------
%	figure: figure
%       Plots wave force regime as Keulegan-Carpenter parameter versus
%       diffraction parameter
%
% Examples
%     --------
%     **Using Integers**
%     >> D = 5
%     >> H = 8
%     >> lambda_w = 200
%     >> plot_chakrabarti(H,lambda_w,D)
% 
%     **Using vector**
%     >> D = linspace(5,15,5)
%     >> H = 8*ones(size(D))
%     >> lambda_w = 200*ones(size(D))
%     >> plot_chakrabarti(H,lambda_w,D)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

arguments
    H
    lambda_w
    D
    options.savepath = "";
end

szD = size(D);
KC = zeros(szD);
Diffraction = zeros(szD);
for i=1:max(szD)
    KC(i) = H(i) ./ D(i);
    Diffraction(i) = pi.*D(i) ./ lambda_w(i);
    txt = ('H='+string(H(i))+', {\lambda_w}='+string(lambda_w(i))+', D='+string(D(i)));
    figure = loglog(Diffraction(i), KC(i),'o', 'DisplayName', txt);
    legend('Location', 'northeast', 'NumColumns', 2);
    xlabel('Diffraction parameter, $\frac{\pi*D}{\lambda_w}$','Interpreter','latex')
    ylabel('KC parameter, $\frac{H}{D}$','Interpreter','latex')
    set(figure, 'markerfacecolor', get(figure, 'color'))
    hold on
end

if any(KC>=10) || any(KC<=.02) || any(Diffraction>=50) || any(lambda_w >= 1000)
    axis auto
else
    xlim([0.01 10])
    ylim([0.01 50])
end

%check to see if the characteristic length D is a number
if any(~isnumeric(D))
    ME = MException('MATLAB:plot_chakrabarti','D must be a number');
    throw(ME);
end

%check to see if the wave height H is a number
if any(~isnumeric(H))
    ME = MException('MATLAB:plot_chakrabarti','H must be a number');
    throw(ME);
end

%check to see if the wave length lambda_w is a number
if any(~isnumeric(lambda_w))
    ME = MException('MATLAB:plot_chakrabarti','lambda_w must be a number');
    throw(ME);
end

%check to see if D, H, and lambda_w are the same size
if any(~isequal(size(D),size(H),size(lambda_w)))
    ME = MException('MATLAB:plot_chakrabarti','D, H, and lambda_w must be the same size');
    throw(ME);
end

legend show
legend('AutoUpdate','off')

x1 = xlim;
if x1(1) >= 0.01
    graphScale_x = 0.01;
    xDrag = 0.0125;
    xInertiaDrag = 0.02;
    yDrag = 25;
    yInertiaDrag = 8;
%     xWaveBreaking1 = 
    yWaveBreaking1 = 2;
%     xWaveBreaking2 = 
    yWaveBreaking2 = 1.25;
else
    graphScale_x = x1(1);
    xDrag = 0.003;
    xInertiaDrag = 0.008;
    yDrag = 40;
    yInertiaDrag = 8;
%     xWaveBreaking1 = 
    yWaveBreaking1 = 8;
%     xWaveBreaking2 = 
    yWaveBreaking2 = 4.5;
end

hold on
% deep water breaking limit (H/lambda_w = 0.14)
x1 = logspace(1,log10(graphScale_x),2);
y_breaking = 0.14*pi./x1;
plot(x1, y_breaking, 'k')
text(1,yWaveBreaking1,'{\it Wave Breaking}','HorizontalAlignment','center','FontSize',8)
text(1,yWaveBreaking2,'$\frac{H}{\lambda_w} > 0.14$','Interpreter','latex','HorizontalAlignment','center','FontSize',8)

hold on
% upper bound of low drag region
    ldv = 20;
    ldh = 0.14*pi/ldv;
    line([graphScale_x,ldh],[ldv,ldv], 'Color','k','LineStyle','--')
%     x2 = 0.14*pi/ldv;
%     y_small_drag = 20;
%     plot(x2, y_small_drag,'--k')
    text(xDrag,yDrag,'{\it Drag}','HorizontalAlignment','center','FontSize',8)

hold on
% upper bound of small drag region
    sdv = 1.5;
    sdh = 0.14*pi/sdv;
    line([graphScale_x,sdh],[sdv,sdv], 'Color','k','LineStyle','--')
    text(xInertiaDrag,yInertiaDrag,'{\it Inertia & Drag}','HorizontalAlignment','center','FontSize',8)

hold on        
% upper bound of negligible drag region
    ndv = 0.25;
    ndh = 0.14*pi/ndv;
    line([graphScale_x,ndh],[ndv,ndv], 'Color','k','LineStyle','--')
    text(8*graphScale_x,0.7,'{\it Large Inertia}','HorizontalAlignment','center','FontSize',8)

    text(8*graphScale_x,6e-2,'{\it All Inertia}','HorizontalAlignment','center','FontSize',8)
    
hold on
% left bound of diffraction region
    drh = 0.5;
    drv = 0.14*pi/drh;
    line([drh,drh],[graphScale_x,drv], 'Color','k','LineStyle','--')
    text(2,6e-2,'{\it Diffraction}','HorizontalAlignment','center','FontSize',8)

len = strlength(options.savepath);
if len > 1
    saveas(figure, options.savepath);
end 
