
%----------------------------------------------------------
%      Construct the look and say sequence of order num and
%      starting sequence, startSeq (string).
%----------------------------------------------------------

function test_look_and_say(num)
    fprintf('--------------------------\n')
    fprintf('Look and say sequence:  %5g \n', num)
    fprintf('--------------------------\n')

    tic

    start_sequence = '1223334444';
    i = 1;

    while (i <= num)
        if (i == 1)
            current_sequence = start_sequence;
        else
            count = 1;
            temp_series = '';
            for j=2:length(current_sequence)
                if (current_sequence(j) == current_sequence(j-1))
                    count = count + 1;
                else
                    temp_series = strcat(temp_series, num2str(count), current_sequence(j-1));
                    count = 1;
                end
            end
            temp_series = strcat(temp_series, num2str(count),  current_sequence(length(current_sequence)));
            current_sequence = temp_series;
        end 
        i = i + 1;
    end
    %fprintf(' %s \n', current_sequence);

    toc
exit;