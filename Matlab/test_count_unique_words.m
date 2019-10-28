
function test_count_unique_words(file_name)

    fprintf('--------------------------------------\n')
    fprintf('Counting the number of unique words in:  %s \n', file_name)
    fprintf('--------------------------------------\n')

    tic

    % Import the words from the text file into a cell array

    file = fopen(file_name);
    words = textscan(file, '%s');
    status = fclose(file);

    % Get rid of all the characters that are not letters
    for i=1:numel(words{1,1})
        ind = find(isstrprop(words{1,1}{i,1}, 'alpha') == 0);
        words{1,1}{i,1}(ind)=[];
        words{1,1}{i,1} = lower(words{1,1}{i,1});
        %S = lower(words{1,1}{i,1});
        %words{1,1}{i,1} = S(isstrprop(S,'alpha'));
    end

    % Remove entries in words that have zero characters
    for i = 1:numel(words{1,1})
        if size(words{1,1}{i,1}, 2) == 0
            words{1,1}{i,1} = ' ';
        end
    end

    % Now count the number of times each word appears
    unique_words = unique(words{1,1});   % remove duplication

    fprintf('Number of unique words is:  %d \n', numel(unique_words))

    toc

exit;
