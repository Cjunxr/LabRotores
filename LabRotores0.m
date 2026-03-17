%% Analise de Vibracao-Lab de rotores 2026.1 CACSJR - Fiat Argo 2018
clear; clc; close all;

% Leitura do arquivo exportado pelo aplicativo
T = readtable('acceleration_2026-03-04_18-08-47.csv');

% Separando os vetores
tempo = T.time;
ax = T.ax;
ay = T.ay;
az = T.az;

%% Separando os intervalos do ensaio
% 0–15 s -> marcha lenta
% 15–30 s -> oscilacoes de RPM

idx_marcha_lenta = tempo <= 15;
idx_variacao_rpm = tempo > 15;

%% Grafico geral do ensaio completo

figure
plot(tempo, ax); hold on
plot(tempo, ay)
plot(tempo, az)
grid on
xlabel('Tempo (s)')
ylabel('Aceleracao (m/s^2)')
title('Aceleracao nos eixos X, Y e Z - Ensaio Completo')
legend('Eixo X','Eixo Y','Eixo Z')

%% ==============================
% Analise estatistica - Marcha Lenta
% ==============================

media_ml = [mean(ax(idx_marcha_lenta)) ...
            mean(ay(idx_marcha_lenta)) ...
            mean(az(idx_marcha_lenta))];

desvio_ml = [std(ax(idx_marcha_lenta)) ...
             std(ay(idx_marcha_lenta)) ...
             std(az(idx_marcha_lenta))];

amp_ml = [max(abs(ax(idx_marcha_lenta))) ...
          max(abs(ay(idx_marcha_lenta))) ...
          max(abs(az(idx_marcha_lenta)))];

%% ==============================
% Analise estatistica - Variacao de RPM
% ==============================

media_rpm = [mean(ax(idx_variacao_rpm)) ...
             mean(ay(idx_variacao_rpm)) ...
             mean(az(idx_variacao_rpm))];

desvio_rpm = [std(ax(idx_variacao_rpm)) ...
              std(ay(idx_variacao_rpm)) ...
              std(az(idx_variacao_rpm))];

amp_rpm = [max(abs(ax(idx_variacao_rpm))) ...
           max(abs(ay(idx_variacao_rpm))) ...
           max(abs(az(idx_variacao_rpm)))];

%% Exibindo resultados na janela de comando

disp('===== MARCHA LENTA (0-15 s) =====')
disp('Media:')
disp(media_ml)
disp('Desvio padrao:')
disp(desvio_ml)
disp('Amplitude maxima:')
disp(amp_ml)

disp('===== VARIACAO DE RPM (15-30 s) =====')
disp('Media:')
disp(media_rpm)
disp('Desvio padrao:')
disp(desvio_rpm)
disp('Amplitude maxima:')
disp(amp_rpm)