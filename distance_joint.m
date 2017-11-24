function [m,sd] = distance_joint(data,joint_1,joint_2)
    % default value
    m = 0;
    sd = 0;
    dis_j1_j2 = [];
    [r,c] = size(data);
    if(c == 5)
        x = 3;
        y = 4;
        z = 5;     

    elseif(c == 4)
        x = 2;
        y = 3;
        z = 4;     
    end
    
    r = r - 20;
    for i = 0 : 20 : r
        xyz1 = [];
        xyz2 = [];
        j1 = i + joint_1;
        j2 = i + joint_2;
        xyz1 = [data(j1, x), data(j1, y), data(j1, z)];   % creates a [x, y, z] vector
        xyz2 = [data(j2, x), data(j2, y), data(j2, z)];
        
        dist = norm(xyz1 - xyz2);
        dis_j1_j2 = [dis_j1_j2, dist];
    end
    m = mean(dis_j1_j2);
    sd = std(dis_j1_j2);
    
    % calculate the euclidean distance between joint_1 and joint_2 in all frames
    % m = mean(dis_j1_j2) % find the mean of all these distance
    % sd = std(dis_j1_j2) % find the standard deviation of all these distance
end

