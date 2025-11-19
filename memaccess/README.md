# Little Computer 3(LC3) README file - Memory Access Stage
This README includes

1. how to gen a UVM testbench using UVM Framework with yaml file
2. how to run the mem_access stage simulation(TBD)


## 1. How to gen a UVM testbench using UVM Framework with yaml file

# Step 1: Download latest version of UVMF library 

We can download it(UVMF_2023.4_2) locally from the following website:
```
https://verificationacademy.com/topics/uvm-universal-verification-methodology/uvmf/
```

# Step 2: Extract the UVMF_2023.4_2 library and put it in the working dir
I put it at 
```
/mnt/ncsudrive/c/chsiao4/Fall2025/UVM/group6_p3/UVMF_2023.4_2
```


# Step 3: Set up the env varible in te bashrc(UVMF env setup)
```
nano ~/.bashrc
```

Put the following lines at the end the bashrc
```
export UVMF_HOME=/mnt/ncsudrive/c/chsiao4/Fall2025/UVM/group6_p3/UVMF_2023.4_2
export PATH=$UVMF_HOME/scripts:$PATH
```

Then source the config
```
source ~/.bashrc  
```

We can test if UVMF are accessible by typing
```
which yaml2uvmf.py
```

# Step 4: Run python3.9 With pre-built yaml file(i.e.,memaccess_in_interface.yaml)
Note: python version matter(as well as the yaml file syntax)
Note: Make sure we set the existing_library_component to 'False' so that it wont skip code generation
```
python3.9 $UVMF_HOME/scripts/yaml2uvmf.py memaccess_in_interface.yaml
```

We can also gen all the code at once by
```
python3.9 $UVMF_HOME/scripts/yaml2uvmf.py memaccess_in_interface.yaml memaccess_out_interface.yaml memaccess_util_comp_memaccess_predictor.yaml memaccess_environment.yaml 
```

Notice: there are some dependency, make sure that the order of yaml files is correct