function [current_status,previous_status,super_previous_status]=update_status(current_status_now,previous_status_now,khana_index,legal,capturing,final_file,final_rank,castling,castling_side,promotion,promotion_piece_index)
% if the move is legal.
[m,~]=size(current_status_now);
super_previous_status=previous_status_now;
if legal==1
    previous_status=current_status_now;
     if capturing==1
        for i=1:m,
            if current_status_now(i).rank==final_rank && current_status_now(i).file==final_file
                index=i;
                break
            end
        end
        current_status_now(index).status='Dead';
        current_status_now(khana_index).file=final_file;
        current_status_now(khana_index).rank=final_rank;
        current_status_now(khana_index).displacement='Yes';
        current_status=current_status_now;
        
     elseif castling==1
        if strcmp(castling_side,'queen')                                    % if the castling is on queen side
            if strcmp(current_status_now(khana_index).color,'White')        % if the castling king color is white
                current_status_now(1).file=current_status_now(1).file+3;
                current_status_now(1).displacement='Yes';
                
            elseif strcmp(current_status_now(khana_index).color,'Black')    % if the castling king color is black
                current_status_now(17).file=current_status_now(17).file+3;
                current_status_now(17).displacement='Yes';
            end
                
        elseif strcmp(castling_side,'king')                                 % if the castling side is king side
            if strcmp(current_status_now(khana_index).color,'White')        % if the castling king color is white
                current_status_now(8).file=current_status_now(1).file-2;
                current_status_now(8).displacement='Yes';
                
            elseif strcmp(current_status_now(khana_index).color,'Black')    % if the castling king color is black
                current_status_now(24).file=current_status_now(17).file-2;
                current_status_now(24).displacement='Yes';
            end
        end
            
        current_status_now(khana_index).file=final_file;
        current_status_now(khana_index).rank=final_rank;
        current_status_now(khana_index).displacement='Yes';
        current_status=current_status_now;
         
     elseif promotion==1
         current_status_now(khana_index).status='Dead';
         current_status_now(promotion_piece_index).status='Alive';
         current_status_now(promotion_piece_index).rank=final_rank;
         current_status_now(promotion-piece_index).file=final_file;
         current_status=current_status_now;
         
     
     else
        current_status_now(khana_index).file=final_file;
        current_status_now(khana_index).rank=final_rank;
        current_status_now(khana_index).displacement='Yes';
        current_status=current_status_now;
     end
   
% if the move is illegal.
else
    fprintf('The move is illegal by the player. Please check the move.');
    current_status=current_status_now;
    previous_status=previous_status_now;
end
end