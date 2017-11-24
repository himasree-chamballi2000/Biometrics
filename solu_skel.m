clear;
tic()

% Reading input from train data file
f_train = fopen('train_data.txt','r');

% Initially empty matrix
train_seq = [];

for i = 1: 1: 20 % As 20 Video seq
    % Write your code here
    % Use fscanf (carefully read the documentation from internet)
    % Insert the training data into train_seq matrix (will be 5 column matrix)		
    PF = fscanf(f_train,'%d %d', [2 1]);
    no_of_frame = PF(2,1);
    P = PF(1,1);
    cord = fscanf(f_train, '%f %f %f', [3 20 * no_of_frame])';
    train_seq = [train_seq; ones(20*no_of_frame,1).*P, ones(20*no_of_frame,1).*i, cord];  %[P, seq no, x, y, z]
	
end

fclose(f_train);


% Generate features from train data for each video sequence

F_tr = []; % To store training features for all video seq

for i = 1: 1: 20 % As 20 Video seq
    
    % Select all data from train_seq with video sequence number == i
    
    % call distance_joint function 
    % [my_mean, my_std] = distance_joint(?,?,?);
    
    % insert into the F_tr 
    data = [];
    idx = (train_seq(:,2)==i);
    data = train_seq(idx,:);
    [m1, s1] = distance_joint(data, 15,18);
    [m2, s2] = distance_joint(data, 16,19);
    [m3, s3] = distance_joint(data, 7,10);
    [m4, s4] = distance_joint(data, 5,8);
    [m5, s5] = distance_joint(data, 17,20);  
    
    F_tr = [F_tr; m1, s1, m2, s2, m3, s3, m4, s4, m5, s5, data(i, 1)];
    
end


% Reading input from test data file
f_test = fopen('test_data.txt','r');

% Initially empty matrix
test_seq = [];

for i = 1: 1: 10 % As 10 Video seq
    % Write your code here
    % Use fscanf (carefully read the documentation from internet)
    % Insert the testing data into test_seq matrix (will be 4 column matrix, as person # is not given)	
    frame = fscanf(f_test,'%d', [1,1]);
    frame = frame(1,1);
    cord = fscanf(f_test, '%f %f %f', [3 20 * frame])';
    test_seq = [test_seq; ones(20*frame,1).*i, cord];
end

fclose(f_test);

% Generate features from test data for each sequence

F_te = []; % To store test features for all video seq

for i = 1: 1: 10 % As 10 test Video seq
    
    % Select all data from test_seq with video sequence number == i
    
    % call distance_joint function 
    % [my_mean, my_std] = distance_joint(?,?,?);
    
    % insert into the F_te 
    
    data = [];
    idx = (test_seq(:,1)==i);
    data = test_seq(idx,:);
    [m1, s1] = distance_joint(data, 15,18);
    [m2, s2] = distance_joint(data, 16,19);
    [m3, s3] = distance_joint(data, 7,10);
    [m4, s4] = distance_joint(data, 5,8);
    [m5, s5] = distance_joint(data, 17,20);    
    
    F_te = [F_te; m1, s1, m2, s2, m3, s3, m4, s4, m5, s5];
    
    
    
end

% Matching between video sequences
for i = 1:1:10 % for each test feature vector
    %...
    %...
    P = 0; % best_match_person # (initially zero as default value);
    min = 1000;
    for j = 1:1:20 % for each training features vector
       % Calculate euclidean distance
       % Track the person no. P with minimum distance       
       d1 = norm(F_te(i, :) - F_tr(j, 1:10));
       if(d1 < min)
           P = F_tr(j, 11);
           min = d1;
       end
       
    end
    
    str = strcat('Sequence--',int2str(i),' is best matched with person--', int2str(P));
    disp(str);
end

toc()