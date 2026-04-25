load('Frame_ex.mat')
% структура frame
% px py - координатная сетка
% vx vy -скорость
% tt - время
% freq - частота кадров
% Lx Ly - размер системы
% 
numbergrid= size(frame.px{1},1);
num_time_exp = length(frame.px);



x0 = nan(1,num_time_exp);
y0 = nan(1,num_time_exp);
% задаем первоначальные координаты того вихря, который хотим отслеживать
x0(1)=20;
y0(1) = -23;
% Уточняем его центры
% алгоритм основан на поиске экстремума тангенциальной скорости
frameVel = calcVel(frame, 1, 1); %это часть всего лишь нужна, чтобы координата 0,0 соответсвовала центру frame
[x0(1),y0(1)] =processing_find_center(x0(1), y0(1),numbergrid, 1, frame, frameVel); % само уточнение
%% блок отрисовки
% clf
%     showVort(frame,1);
%     hold on
%     plot3(x0(1),y0(1),100, '*r');
%     pause(0.001)

% name = "aaa"
% mkdir(name)
for ii = 2:num_time_exp
    frameVel = calcVel(frame, ii, 1); %
    %закидываем координаты прошлого кадра и ищем в округе где может находится новый центр. 
    % алгоритм основан на поиске экстремума тангенциальной скорости
    [x0(ii),y0(ii)] =processing_find_center(x0(ii-1), y0(ii-1),numbergrid, ii, frame, frameVel); 
    disp("Уточнение на (см): " + ((x0(ii) - x0(ii-1))^2 + (y0(ii) - y0(ii-1))^2)^0.5);
    %% Блок отрисовки
%     clf
%     showVort(frame,ii);
%     hold on
%     plot3(x0(ii),y0(ii),100, '*r');
%     pause(0.001)
%     cd(name)
%     I = frame2im(getframe(gcf));
%     imwrite(I, ("20_N7_num_" + ii + ".jpg"));
%     cd ..
end

