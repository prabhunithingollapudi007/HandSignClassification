for folder_index = 0:9
    img_path = strcat('../raw_data/data/rgb_', num2str(folder_index), '/');
    depth_path = strcat('../raw_data/data/depth_', num2str(folder_index), '/');
    dest_path = strcat('../raw_data/data/depth_rgb_combined_files_', num2str(folder_index), '/');
    for file_index = 0:15
        rgb_img = imread(strcat(img_path, 'rgb_image_', num2str(file_index), '.jpg'));
        depth_img = imread(strcat(depth_path, 'depth_image_', num2str(file_index), '.jpg'));
        rgb_img = rgb_img(:, 9:end, :);
        depth_img = depth_img(:, 1:end-8, :);
        final_file = fopen(strcat(dest_path, 'combined_value_', num2str(file_index), '.txt'), 'w');
        
        for small_idx = 1:480
            for large_idx = 1:632
                fprintf(final_file, '%d %d %d %d \n', rgb_img(small_idx, large_idx, 1), rgb_img(small_idx, large_idx, 2), rgb_img(small_idx, large_idx, 3), depth_img(small_idx, large_idx, 1) ); 
            end
        end
        
        fclose(final_file);
    end
end