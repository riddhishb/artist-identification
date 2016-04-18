function [ output_image ] = detect_edges( input_image_path )
%Detects Edges
%   Uses EDISON
    gen_command = ['python edison/genEdisonScript.py ' input_image_path];
    [~, gen_cmdout] = system(gen_command);
    mv_command = 'mv script_edison.ed edison/';
    [~, ~] = system(mv_command);
    edison_command = './edison/edison ./edison/script_edison.ed';
    [~, ~] = system(edison_command);
    edge_map = ['edge_maps/' gen_cmdout];
    edge_map = deblank(edge_map);
    output_image = imread(edge_map);
end

