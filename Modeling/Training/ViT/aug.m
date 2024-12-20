file=dir('E:\Leukemia paper\C-NMC_Leukemia\training update\non-cancer\');
for i=3 : size(file,1)
s='E:\Leukemia paper\C-NMC_Leukemia\training update\non-cancer\';
f=imread([s file(i).name]);
f=imresize(f, [256 256]);
      % f1=fliplr(f);
        % f1=flipud(f);
       % f1=flip(f,4);
        f1=rot90(f);

 imwrite(f1,[file(i).name]);

end