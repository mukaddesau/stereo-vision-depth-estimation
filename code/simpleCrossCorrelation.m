function [disp_mat1] = simpleCrossCorrelation(w, d, viewL, viewR)
[height width] = size(viewL);

% Window Allocation
corr_win = zeros(w+1,w+1);
search_win = zeros(w+1,w+1);

SCC = 0;
    for i = d+1 : height-d
       for j = d+1 : width-d
           max = 0;
           
           % Correlation window coordinates %
           c_low_row = i - w; 
           c_high_row = i + w; 
           c_low_col= j - w; 
           c_high_col = j + w; 
           
           % Crop correlation window from viewL % 
           corr_win = viewL((c_low_row : c_high_row) , (c_low_col : c_high_col));
           
           % (search region only x direction) %
           for k = j-d+w : j+d-w
                
               %Search window coordinates %
               s_low_row = i - w; 
               s_high_row = i + w;
               s_low_col = k - w;
               s_high_col = k + w;              
               
               % Crop search window from viewR % 
               search_win = viewR((s_low_row : s_high_row) , (s_low_col : s_high_col));           
               
%                corr_win = double(corr_win);
%                search_win = double(search_win);
                
               mean_corr = mean2(corr_win);
               mean_search = mean2(search_win);
%                std_corr = std(corr_win(:));
%                std_search = std(search_win(:));
               
               SCC = sum(sum((corr_win-mean_corr).*(search_win-mean_search)));               
               
               if SCC > max
                  max = SCC;
                  % Calculate and record disparity %
                  disp_mat(i,j) = abs(j - k);
               end
           end
       end
    end
 
% Remove padding
disp_mat1 = disp_mat(d+1 : height-d ,d+1 : width-d);
end