%% Combine all bodyjoints of one participant and one scenario.


intcounter = 1;

while intcounter <= 3
    
    c = intcounter + extcounter;
    
    CombinedStream(c,:) = Bodypart_cleaned(intcounter,:);
    
    intcounter = intcounter + 1;

end


extcounter = extcounter + 3;

bodypart_pointer = bodypart_pointer + 1;