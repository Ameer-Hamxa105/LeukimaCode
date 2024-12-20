function [output, attentionMaps] = forward1(obj, dlX)
    % Forward pass of the Vision Transformer
    [output, intermediateData] = obj.Model.forward(dlX);
    
    % Extract attention maps from intermediate data
    attentionMaps = extractAttentionMaps(intermediateData); % Implement this function
end