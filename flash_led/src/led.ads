package led is

    type state is (low, high);
    for state use (low => 0, high => 1);
    for state'size use 32;

end led;