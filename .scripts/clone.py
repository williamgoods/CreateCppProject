import os
import re
import subprocess
import sys

def clone(url, bar_len=40, title='Please wait'):
    # url = 'https://github.com/vuejs/vue.git'
    print('\nclone ', url)

    output = subprocess.Popen(['git', 'clone', '--progress', url], stderr=subprocess.PIPE, stdout=subprocess.PIPE)

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
                        # print('\t✅')
                        state = '✅'
                    
                    print(f'    {state}{title}: [{done_str}{togo_str}] {speed} MiB/s Received {data_size} MiB {percent_done}% done', end='\r')

        if len(lines) == 1:
                break

    print("\nclone end!\n")

if __name__ == "__main__":
    for url in sys.argv[1:]:
        clone(url)
