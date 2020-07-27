function figure=plot_velocity_vs_power(V,P,options)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Plots velocity vs power along with a polynomial fit 
%     
% Parameters
% ------------
%     V: array
%         Velocity [m/s] 
%         
%     P: array 
%          Power [W]
%
%     title: string (optional)
%          title for the plot
%          to call: plot_velocity_vs_power(P,F,"title",title)
%
%     savepath: string (optional)
%          path and filename to save figure.
%          to call: plot_velocity_vs_power(P,F,"savepath",savepath)
%
%     polynomial_coeff: array (optional)
%          polynomial coefficients which can be computed from 
%          polynomial_fit.m. Expects poly.coef
%          to call: plot_velocity_vs_power(P,F,"polynomial_coeff",polynomial_coeff)
% 
% Returns
% ---------
%   figure: plot of velocity vs. power
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

arguments
    V
    P
    options.title = "";
    options.savepath = "";
    options.polynomial_coeff = [];
end

figure=plot(V,P,'o');
hold on
grid on
xlabel('Velocity m/s]','FontSize',20)
ylabel('Power [W]','FontSize',20)

% if nargin == 3
%     if isstring(varargin{1})
%         title(varargin{1})
%     elseif isnumeric(varargin{1})
%         mi=min(V);
%         
%         ma=max(V);
%         si=size(varargin{1});
%         x=linspace(mi(1),ma(1),100);
%         hold on
%         p2=plot(x,polyval(varargin{1},x),'--');
%         legend(p2,{'Polynomial Fit'},'Location','northwest')
%     else
%         ME = MException('MATLAB:plot_velocity_vs_power','Variable argument is of the wrong type');
%         throw(ME);
%     end
%     
% elseif nargin ==4 
%     mi=min(V);
%     ma=max(V);
%     if isstring(varargin{1}) & isnumeric(varargin{2})
%         si=size(varargin{2});
%         x=linspace(mi(1),ma(1),100);
%         hold on
%         p2=plot(x,polyval(varargin{2},x),'--');
%         legend(p2,{'Polynomial Fit'},'Location','northwest')
%         title(varargin{1})
%     elseif isstring(varargin{2}) & isnumeric(varargin{1})
%         si=size(varargin{1});
%         x=linspace(min(V),max(V),100);
%         hold on
%         p2=plot(x,polyval(varargin{1},x),'--');
%         legend(p2,{'Polynomial Fit'},'Location','northwest')
%         title(varargin{2})
%     else
%         ME = MException('MATLAB:plot_velocity_vs_power','Variable argument is of the wrong type');
%         throw(ME);
%     end
% elseif nargin > 4
%     ME = MException('MATLAB:plot_velocity_vs_power','Too many arguments given');
%         throw(ME);
% end

title(options.title)
mi=min(V);
ma=max(V);
len = strlength(options.savepath);
lenp = length(options.polynomial_coeff);

if lenp > 1
   x=linspace(mi(1),ma(1),100);
   p2=plot(x,polyval(options.polynomial_coeff,x),'--');
   legend(p2,{'Polynomial Fit'},'Location','northwest') 
end

if len > 1
    saveas(figure, options.savepath);
end 



hold off    
