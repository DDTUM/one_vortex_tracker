function v_tan_mean = f_Radial_profile_win2(frame, x0, y0, num, r0)
%% Вычисление тангенциальной средней скорости
px = frame.px{num}-x0-mean(frame.px{1}, 'all');
py = frame.py{num}-y0-mean(frame.py{1}, 'all');
vx = frame.vx{num};
vy = frame.vy{num};
ind_r0 = abs(px+i*py)<r0;
[theta rho] = cart2pol(px,py);
% v_rad =  vx.*cos(theta) + vy.*sin(theta);
v_tan = -vx.*sin(theta) + vy.*cos(theta);
v_tan_mean = nanmean(v_tan(ind_r0), 'all');

