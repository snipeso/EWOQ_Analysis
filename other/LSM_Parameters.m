addpath('C:\Users\colas\Projects\EWOQ_Analysis\')

Path = struct();



Path.Main = ['C:\Users\colas\Projects\LSMsite\'];
Path.Participants = [Path.Main, 'LSM\'];
Path.CSV = [Path.Main, 'tables\'];

if not(exist(Path.CSV, 'dir'))
    mkdir(Path.CSV)
end