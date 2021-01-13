function dirs = getRoots()

name = getenv('COMPUTERNAME');
switch name
    case 'homePC'
        dirs.root = fullfile('J:','Data & Analysis');
       
    case 'PNI-F4W2YM2'
        dirs.root = fullfile('C:','Data');
        dirs.code = fullfile('C:','Users','mjs20','Documents','GitHub');
end