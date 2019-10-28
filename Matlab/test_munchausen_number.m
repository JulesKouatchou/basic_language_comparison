 
function test_munchausen_number()

fprintf('--------------------------\n')
fprintf('Determine the first four Munchausen numbers \n')
fprintf('--------------------------\n')

tic

count = 0;
i = 0;
while(count < 4)
    n = i;
    % list(map(int,str(i)))
    num = 0;
    while(n > 0)
        k=mod(n,10);
        if (k == 0)
            answer=k;
        else
            answer=k^k;
        end
        num = num + answer;
        n = floor(n/10);
    end

    if (num == i)
        count = count + 1;
        fprintf('Munchausen number %2g: %12g \n', count, i)
    end
    i = i + 1;
end

toc
 
exit;
