function avg_arr = evaluate(dimension, solution_number, problem_type, set_number, num_vector, seed, reference_point)
    % Load result
    result_set_file_name = sprintf('result_set_%d_%s_numVec_%d_seed_%d_numSol_%d_%d.mat', dimension, problem_type, num_vector, seed, solution_number, reference_point);

    if exist(result_set_file_name) == 0
        avg_arr = 0;
        return;
    end
    result_set = load(result_set_file_name);
    result_set = result_set.x;
    % Initialize
    total_consis_R2C_1 = 0;
    total_consis_newR2C_1 = 0;
    total_consis_mcsim = 0;
    total_correct_R2C_1 = 0;
    total_correct_newR2C_1 = 0;
    total_correct_mcsim = 0;
    
    % Evaluate
    for i = 1:set_number
        % Slice
        HVC = result_set(1, :, i);
        R2C = result_set(2, :, i);
        newR2C = result_set(3, :, i);
        mcsim = result_set(4, :, i);
        % Calculate consistency
        [r1, r2, r3] = consistency(HVC, R2C, newR2C, mcsim ,1);
        total_consis_R2C_1 = total_consis_R2C_1 + r1;
        total_consis_newR2C_1 = total_consis_newR2C_1 + r2;
        total_consis_mcsim = total_consis_mcsim + r3;
        
        % Calculate worst point
        [r1, r2,r3] = isWorstSame(HVC, R2C, newR2C,mcsim, 1);
        total_correct_R2C_1 = total_correct_R2C_1 + r1;
        total_correct_newR2C_1 = total_correct_newR2C_1 + r2;
        total_correct_mcsim = total_correct_mcsim + r3;
    end
    
    avg_consis_R2C_1 = total_consis_R2C_1/set_number;
    avg_consis_newR2C_1 = total_consis_newR2C_1/set_number;
    avg_consis_mcsim = total_consis_mcsim/set_number;
    avg_correct_R2C_1 = total_correct_R2C_1/set_number;
    avg_correct_newR2C_1 = total_correct_newR2C_1/set_number;
    avg_correct_mcsim = total_correct_mcsim/set_number;
    avg_arr = [avg_consis_R2C_1, avg_consis_newR2C_1,avg_consis_mcsim, avg_correct_R2C_1, avg_correct_newR2C_1,avg_correct_mcsim];
    
end