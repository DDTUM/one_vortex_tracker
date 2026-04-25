function [xx0, yy0] = processing_find_center(xcent, ycent,numbergrid, tim, frame, frameVel)
area = 5; %ищем минимум в области 10 на 10 отсчетов
%%Следующие уточнения необходимы, чтобы узнать точные координаты на сетке,
%%где будем искать центр вихря
%% Уточнение координаты х. 
miin=999; 
for(ind =1:numbergrid)
    if(miin> min(abs(xcent-frameVel.px(1,ind))))
        
    miin= min(abs(xcent-frameVel.px(1,ind)));
    inds = ind;
    end
    
end

xcent = frameVel.px(1,inds);
if((inds-area) < 1)
    xgran = frameVel.px(1,1:inds+area); %% координаты х области поиска
    disp("Ищем в левом краю.")
elseif((inds+area) > numbergrid)
    xgran = frameVel.px(1,inds-area:numbergrid); %% координаты х области поиска
    disp("Ищем в правом краю.")
else    
xgran = frameVel.px(1,inds-area:inds+area); %% координаты х области поиска
end

%% Уточнение координаты у.
miin=999;
for(ind =1:numbergrid)
    if(miin > min(abs(ycent-frameVel.py(ind,1))))
        
    miin= min(abs(ycent-frameVel.py(ind,1)));
    inds = ind;
    end
    
end


ycent = frameVel.py(inds,1);
if((inds-area) < 1)
    ygran = frameVel.py(1:inds+area,1)'; %% координаты у области поиска
    disp("Ищем снизу.")
elseif((inds+area) > numbergrid)
    ygran = frameVel.py(inds-area:numbergrid,1)'; %% координаты у области поиска
    disp("Ищем сверху.")
else   
    ygran = frameVel.py(inds-area:inds+area,1)'; %% координаты у области поиска
end

%% Указание и создание области поиска центра.
x0 =xgran;% xmin : (100/209) : xmax;
y0 =ygran;% ymin : (100/209) : ymax;
[XX,YY] = meshgrid(x0, y0);
%% Создание области фиттинга
fit=zeros(size(meshgrid(x0, y0)));
fit = fit./0;
%% Приступаем к поиску
k=0;
for x0=xgran%xmin:(100/209):xmax
    for y0=ygran%ymin:(100/209):ymax
        for iii=1:1
    rmax=2.5;
         %Вычисление самого значения средней тангенциальной скорости
        [loss_mean] = f_Radial_profile_win2(frame, x0, y0,tim,rmax);
        %[mean_alpha, loss_mean] = f_Radial_profile_win_absvelocity(x0, y0,tim,numer, frameVel,0,0,frame);
        
        index = find((XX == x0) & (YY == y0));
        k=k+1;
        fit(k)=loss_mean;
        
        
        %disp("index = " + index + "x0 = " + x0 + "; y0 = " + y0 + " || " + k + "/" + length(XX)*length(XX) + "  " + k*100/(length(XX)*length(XX)) + " || " + "los_mean = " + loss_mean); 
        
    
        end
    end 
end
%% модуль отображения сих значений тангенциальных скоростей
% figure(6);
% surf(XX, YY ,fit);
% %caxis([-0.5 0]);
% view(2);
% colorbar;
%% Важная часть! Ищем ли мы желтые вихри, которые вращаются против часовой стрелке
%% Либо же синие, которые вращаются по часовой стрелке
 ind_ans = find(-fit == min(min(-fit))); %for @__> yellow
%ind_ans = find(fit == min(min(fit)));  %for @__< blue

% disp("�� loss: " + XX(ind_ans));
% disp("�� loss: " + YY(ind_ans));

% Сами координаты
xx0=XX(ind_ans(1));
yy0= YY(ind_ans(1));


clearvars -except xx0 yy0 r_mean_in_vortex v_tan_mean_in_vortex E_in_vortex E_tan_in_vortex
end
