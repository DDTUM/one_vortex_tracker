function frameVel = calcVel(frame, num, mult)
%% Впринцципе тут можно усреднять скорость по кадрам, но в данном случае это нужно для 
%% центрирования координаты 0,0 по центру куба
    if ~exist('frame', 'var')
        disp('function showVelQ(frame, num, mult)');
        return
    end
    
    if exist('num', 'var')==0 
        num = 1:numel(frame.px);
    end    
    
    if exist('mult', 'var')==0 
        mult = 4;
    end        
    oVx = nanmean(cat(3, frame.vx{num}),3);
    oVy = nanmean(cat(3, frame.vy{num}),3);
    px = frame.px{num(1)};
    py = frame.py{num(1)};
    px = px - mean(px(:));
    py = py - mean(py(:));

    sizex = floor(size(oVx,2)/mult)*mult;
    sizey = floor(size(oVx,1)/mult)*mult;
    frameVel.oVx = avermult(oVx(1:sizey,1:sizex), mult);
    frameVel.oVy = avermult(oVy(1:sizey,1:sizex), mult);
    frameVel.px = avermult(px(1:sizey,1:sizex), mult);
    frameVel.py = avermult(py(1:sizey,1:sizex), mult);
    
    frameVel.tt(1:numel(num)) = frame.tt(num);
    frameVel.Lx = frame.Lx;    
    frameVel.Ly = frame.Ly; 
    frameVel.freq = frame.freq;
%     
%     scale = 1;
%     q = quiver3(px, py, 100*ones(size(px)), oVx*scale, oVy*scale,zeros(size(px)), 'r'); view(2)
%     title(num2str(max(max(abs(oVx+i*oVy)))))
%     set(q, 'AutoScale', 'on')
%     set(q, 'AutoScaleFactor', .8)        
%     xlim([-1 1]*frame.Lx/2);
%     ylim([-1 1]*frame.Ly/2);
%     set(gca, 'fontsize', 15);
%     pr_right = 14;
%     pr_top = 12;  
%     set(gcf, 'PaperPosition', [0, 0, pr_right, pr_top]);
% 
%     xlabel('x, cm', 'fontsize', 15);
%     ylabel('y, cm', 'fontsize', 15);  
%     drawnow;

