import os
import re
import subprocess
import sys

def clone(url, path, bar_len=40, title='Please wait'):
    output = subprocess.Popen(['git', 'clone', '--progress', url, path], stderr=subprocess.PIPE, stdout=subprocess.PIPE)

    fd = output.stderr.fileno()
    while True:
        lines = os.read(fd,1000).decode('utf-8')
        lines = re.split('\n|\r', lines)
        for l in lines:
            if l != '':
                m = re.match(r'^Receiving objects:\s*(\d*)%\s*\(\d*/\d*\),\s*(\d+\.\d+)\s*MiB\s*\|\s*(\d+\.\d+).*', l)
                if m:
                    progress = m.group(1)
                    data_size = m.group(2)
                    speed = m.group(3)
                    # print("progress: ", progress, "%,data size: ", data_size, "MiB, speed: ", speed, "MiB/s")
                    percent_done = float(progress)
                    done = round(percent_done/(100/bar_len))
                    togo = bar_len-done

                    done_str = '█'*int(done)
                    togo_str = '░'*int(togo)

                    state = '⏳'

                    if round(percent_done) == 100:
                        state = '✅'
                    
                    print(f'    {state}{title}: [{done_str}{togo_str}] {speed} MiB/s Received {data_size} MiB {percent_done}% done', end='\r')

        if len(lines) == 1:
                break

if __name__ == "__main__":
    clone_url = sys.argv[1]
    if len(sys.argv) >= 3:
        clone_path = sys.argv[2]
    else:
        raise Exception( f'You should set the clone path' )

    if os.path.isdir(clone_path):
        wd = os.getcwd()
        os.chdir(clone_path)
        pull = subprocess.run( ['git', 'pull'])
        if pull.returncode != 0:
            raise Exception( f'There is a error in {clone_path}, cause can not pull lastest code!' )
        os.chdir(wd)
    else:
        clone(clone_url, clone_path)
