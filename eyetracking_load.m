% just uploading the eyetracking data now 
close all
clear all 

%eye_track_data = dlmread('example_data/sub-01_ses-movie_task-movie_run-1_recording-eyegaze_physio.tsv');

subjs = {'01', '02', '03', '04', '05', '06', '09', '10', '14','15','16', '17','18','19','20'};
%x_eye = [];
%y_eye = [];
run = '4';
for ii = 1:length(subjs)
    eye_track_data = dlmread(['/Users/afranco/TEMP/BLAH/sub-' subjs{ii} '_ses-movie_task-movie_run-' run '_recording-eyegaze_physio.tsv']);
    x_eye{ii} = eye_track_data(:,1);
    y_eye{ii} = eye_track_data(:,2);
    
end


% The temporal resolution of the eye gaze recording was 1000?Hz
% These data have been normalized such that all gaze coordinates are in 
% native movie frame pixels, with (0,0) being located at the top-left 
%corner of the movie frame (excluding the gray bars) and the lower-right 
%corner (again without the bar) located at (1280,546)

x_eye_clean = x_eye;
y_eye_clean = y_eye;


for ii = 1:length(subjs)
    
    x_eye_clean{ii}(x_eye{ii}<=0) = nan;
    x_eye_clean{ii}(x_eye{ii}>1280) = nan;

    y_eye_clean{ii}(y_eye{ii}<=0) = nan;
    y_eye_clean{ii}(y_eye{ii}>545) = nan;
    
    
   figure 
   plot(x_eye{ii},y_eye{ii},'-*',x_eye_clean{ii},y_eye_clean{ii},'-*');
   title(['subj'  subjs{ii}])  
   
   axis([-100 1600 -100 1000 ]);
   
end
   


%% Good subject 
% Good subjects for run 4:
good_subjects =[1 2 3 4 7 9 11 12 13 14];

% get length of eye tracking data 
x_eye_length = [];
for ii = good_subjects
   x_eye_length(ii) =  length(x_eye_clean{ii});
end

x_eye_length(x_eye_length==0) = nan;
min_x_eye_length = min(x_eye_length);

jj =1 ;
x_eye_good = [];
for ii = good_subjects
    x_eye_clean{ii} = x_eye_clean{ii}(1:min_x_eye_length);
    x_eye_good(:,jj) = x_eye_clean{ii};
    jj = jj + 1;
end


x_eye_good_mean = mean(x_eye_good,2);
x_eye_good_median = median(x_eye_good,2);
x_eye_good_sdev = nanstd(x_eye_good');

bin_x_good = x_eye_good_sdev<50;
x_eye_good_mean_lowsdev = x_eye_good_mean;
x_eye_good_mean_lowsdev(not(bin_x_good)) = 0;

figure 
plot(t,x_eye_good_mean_lowsdev,'-*')



