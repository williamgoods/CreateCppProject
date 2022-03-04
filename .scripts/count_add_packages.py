























if __name__ == "__main__":
    import sys
    import re
    cmake_root_dir = sys.argv[1]
    cmakefile = cmake_root_dir + "/CMakeLists.txt"
    count = 0
    
    with open(cmakefile) as f:
        for line in f:
            m = re.match(r'^add_packages\(.*\s.*\)$', line)
            if m:
                count += 1

    sys.stderr.flush()
    print(count, file=sys.stderr)

            


