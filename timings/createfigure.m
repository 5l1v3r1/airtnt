function createfigure(X, Y, measure, legend_title, log_scale, smooth_plot)
%CREATEFIGURE(X1, Y1)
%  X1:  vector of x data
%  Y1:  vector of y data

%  Auto-generated by MATLAB on 03-May-2018 11:43:43


% Line width
if smooth_plot
    line_width = 2;
else
    line_width = 1.5;
end
marker_size = 10;
font_size = 12;

line_color = [
    0 0 0;
    0 0.447058826684952 0.74117648601532;
    0.850980401039124 0.325490206480026 0.0980392172932625;
    0.929411768913269 0.694117665290833 0.125490203499794;
    ];
light_gray = [0.501960813999176 0.501960813999176 0.501960813999176];
dark_gray = [0.313725501298904 0.313725501298904 0.313725501298904];

% Font weight
font_weight = 'normal'; % 'bold'

% Create figure
figure;
p = zeros(1,size(Y,2));
for i=1:size(Y,2)
    x = X;
    y = Y(:,i);
    
    % Create plot
    if log_scale
        semilogy(x,y,...
            'MarkerFaceColor',line_color(i+1,:),...
            'MarkerEdgeColor',line_color(i+1,:),... 
            'Marker','.',...
            'MarkerSize',marker_size, ...
            'LineWidth',line_width,...
            'LineStyle','none');
    else
        plot(x,y,...
            'MarkerFaceColor',line_color(i+1,:),...
            'MarkerEdgeColor',line_color(i+1,:),...
            'Marker','.',...
            'MarkerSize',marker_size, ...
            'LineWidth',line_width,...
            'LineStyle','none');
    end

    % Hold
    hold on;

    % Interpolation / smooth plot
    if smooth_plot
        xx = x;
        yy = smooth(y);
    else
        xx = linspace(x(1),x(end),1000);
        yy = spline(x,y,xx);
        mask = yy<0;
        yy(mask) = 0;
    end
    if log_scale
       p(i) = semilogy(xx,yy,...
            'Color',line_color(i+1,:),...
            'LineStyle','-','LineWidth',line_width);
    else
       p(i) = plot(xx,yy,...
           'Color',line_color(i+1,:),...
           'LineStyle','-','LineWidth',line_width);
    end
    
    % Hold
    hold on;
end

% Set the remaining axes properties
set(gca,'FontSize',font_size,'FontWeight',font_weight,...
    'XColor',light_gray,'YColor',light_gray,'ZColor',light_gray, ...
    'XGrid','off', 'YGrid','on',...
    'Box', 'on');

% Axes labels
xlabel('Cycles');
ylabel(measure);

% Legend
if ~isempty(legend_title)
    legend1 = legend(p,legend_title);
    set(legend1,...
        'TextColor',dark_gray,...
        'FontSize',font_size,...
        'FontWeight',font_weight,...
        'Location','northwest',...
        'EdgeColor',[1 1 1]);
end

% Window size
fig = gcf;
fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 6 3];
%print('5by3DimensionsFigure','-dpng','-r0')


