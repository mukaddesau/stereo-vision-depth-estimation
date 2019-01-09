% STEREO VISION - DISPARITY COMPUTATION %
clc
clear all
close all 

viewL_ori=imread('C:\Users\Mukaddes\Dropbox\About Master\Bilgisayarlarla Görme\zzz Ödev\Odev_3_Proje\viewL.png');
% imshow(viewL_ori);

viewL_ori = im2double(viewL_ori);
viewL = rgb2gray(viewL_ori);

viewR_ori=imread('C:\Users\Mukaddes\Dropbox\About Master\Bilgisayarlarla Görme\zzz Ödev\Odev_3_Proje\viewR.png');
% figure, imshow(viewR_ori);

viewR_ori = im2double(viewR_ori);
viewR = rgb2gray(viewR_ori);

w = 7; % Correlation window size = w*2+1 %
d = 80; % Search region size = d*2+1 %

viewR = padarray(viewR,[d d]); % Zero-Padding for image borders %
viewL = padarray(viewL,[d d]);

g = load ('disp.mat'); 
ground_truth = g.L;

% tic
% SSD_disp_mat = uint8(sumOfSquarredDistance(w, d, viewL, viewR));
% toc

% tic
% SSD_disp_mat = uint8(normalizedCrossCorrelation(w, d, viewL, viewR));
% toc 

tic
SSD_disp_mat = uint8(simpleCrossCorrelation(w, d, viewL, viewR));
toc

img = mat2gray(SSD_disp_mat); 
figure

SSD_err = double(ground_truth-SSD_disp_mat);
min_SSD_err = min(SSD_err(:))
max_SSD_err = max(SSD_err(:))
mean_SSD_err = mean2(SSD_err)
std_SSD_err = std(SSD_err(:))


