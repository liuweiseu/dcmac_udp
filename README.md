# dcmac_udp vivado project generation
The scripts here are used for generating vivado project for dcmac_udp tests.
## How to use it?
There are two sets of tcl scripts in `full-proj` and `separate-proj`. 
### full-proj
TODO: The scripts is based on a created project, so it's not good.
### seperate-proj
1. clone the vhdl source code repo
    ```
    git clone -b rx-implement git@github.com:liuweiseu/fourhundred_gbe.git
    ```
    Let's assume the repo is clone under the home directory(~/).
2. cd to the vivado tcl scripts directory
    ```
    cd separate-proj/2023.2
    or
    cd separate-proj/2023.1
    
    ```
3. source settings.sh
    ```
    source /tools/Xilinx/Vivado/2023.2/settings64.sh
    or 
    source /tools/Xilinx/Vivado/2023.1/settings64.sh
    ```
4. run the scripts to generate the proj
    ```
    vivado -mode batch -source create_proj.tcl -tclargs --origin_dir ~/ --project_name test
    ```
    **Note:** (1) "--origin_dir": it's the path for the vhdl source code;  
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(2) "--project_name": it's the project name.  
    The project will be generated under the current dir, so you may need to move it to somewhere else.
