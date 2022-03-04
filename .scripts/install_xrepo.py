























if __name__ == "__main__":
    import sys
    import subprocess
    cmake_root_dir = sys.argv[1]
    xrepo_url = "https://github.com/williamgoods/xrepo-cmake.git"
    xrepo_dir = cmake_root_dir + "/.xrepo/"
    
    print("xrepo_dir is ", xrepo_dir)
    
    # python $cmake_root_dir/.scripts/clone.py $xrepo_url $xrepo_dir
    clone_py = cmake_root_dir + "/.scripts/clone.py" 
    subprocess.run(["python", clone_py, xrepo_url, xrepo_dir])
