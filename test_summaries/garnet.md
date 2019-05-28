<pre>
Fetched https://travis-ci.com/StanfordAHA/garnet/builds/113359834 28-May-2019
============= 43 passed, 1 skipped, 12 warnings in 344.27 seconds ==============

============================= test session starts ==============================

collateral_pass/test_config_reg.py                     PASSED   [  2%]  
collateral_pass/test_config_reg.py::test_config_re     PASSED   [  4%]  
garnet/test_garnet.py                                  PASSED   [  6%]  
garnet/test_garnet.py::test_garnet                     PASSED   [  9%]  
global_buffer/test_cfg_controller_verilator_sim.py     PASSED   [ 11%]  
global_buffer/test_cfg_controller_verilator_sim.py     PASSED   [ 13%]  
global_buffer/test_global_buffer_int_verilator_sim     PASSED   [ 15%]  
global_buffer/test_global_buffer_int_verilator_sim     PASSED   [ 18%]  
global_buffer/test_io_controller_verilator_sim.py      PASSED   [ 20%]  
global_buffer/test_io_controller_verilator_sim.py:     PASSED   [ 22%]  
global_buffer/verilator_sim.py                         PASSED   [ 25%]  
global_controller/test_global_controller.py            PASSED   [ 27%]  
global_controller/test_global_controller.py::test_     PASSED   [ 29%]  
global_controller/test_global_controller_genesis2.     PASSED   [ 31%]  
global_controller/test_global_controller_genesis2.     PASSED   [ 34%]  
global_controller/test_global_controller_verilog_s     PASSED   [ 36%]  
global_controller/test_global_controller_verilog_s     SKIPPED  [ 38%]  
interconnect/test_interconnect_cgra.py                 PASSED   [ 40%]  
interconnect/test_interconnect_cgra.py::test_inter     PASSED   [ 43%]  
interconnect/test_interconnect_cgra.py::test_inter     PASSED   [ 45%]  
interconnect/test_interconnect_cgra.py::test_inter     PASSED   [ 47%]  
interconnect/test_interconnect_cgra.py::test_inter     PASSED   [ 50%]  
interconnect/test_interconnect_cgra.py::test_inter     PASSED   [ 52%]  
interconnect/test_interconnect_cgra.py::test_inter     PASSED   [ 54%]  
interconnect/test_reset.py                             PASSED   [ 56%]  
interconnect/test_reset.py::test_interconnect_rese     PASSED   [ 59%]  
io_core/test_io_core.py                                PASSED   [ 61%]  
io_core/test_io_core.py::test_io_core_functional_m     PASSED   [ 63%]  
io_core/test_io_core_magma.py                          PASSED   [ 65%]  
io_core/test_io_core_magma.py::test_regression         PASSED   [ 68%]  
mapper/test_mapper.py                                  PASSED   [ 70%]  
mapper/test_mapper.py::test_pointwise                  PASSED   [ 72%]  
memory_core/test_memory_core.py                        PASSED   [ 75%]  
memory_core/test_memory_core.py::test_passthru_fif     PASSED   [ 77%]  
memory_core/test_memory_core.py::test_fifo_arb         PASSED   [ 79%]  
memory_core/test_memory_core.py::test_general_fifo     PASSED   [ 81%]  
memory_core/test_memory_core.py::test_db_basic_rea     PASSED   [ 84%]  
memory_core/test_memory_core.py::test_db_long_read     PASSED   [ 86%]  
memory_core/test_memory_core.py::test_db_read_mode     PASSED   [ 88%]  
memory_core/test_memory_core.py::test_db_arbitrary     PASSED   [ 90%]  
memory_core/test_memory_core.py::test_db_arbitrary     PASSED   [ 93%]  
memory_core/test_memory_core.py::test_db_auto          PASSED   [ 95%]  
memory_core/test_memory_core.py::test_db_auto2         PASSED   [ 97%]  
memory_core/test_memory_core.py::test_sram_magma       PASSED   [100%]  

=============================== warnings summary ===============================
global_controller/test_global_controller.py::test_global_controller_functional_model
memory_core/test_memory_core.py::test_passthru_fifo
memory_core/test_memory_core.py::test_fifo_arb
memory_core/test_memory_core.py::test_general_fifo
memory_core/test_memory_core.py::test_db_basic_read
memory_core/test_memory_core.py::test_db_long_read
memory_core/test_memory_core.py::test_db_read_mode
memory_core/test_memory_core.py::test_db_arbitrary_rw_addr
memory_core/test_memory_core.py::test_db_arbitrary_addr
memory_core/test_memory_core.py::test_db_auto
memory_core/test_memory_core.py::test_db_auto2
memory_core/test_memory_core.py::test_sram_magma
  /usr/local/lib/python3.7/dist-packages/hwtypes/bit_vector_abc.py:48: UserWarning: DEPRECATION WARNING: Use of BitVectorT(value, size) is deprecated
    warnings.warn('DEPRECATION WARNING: Use of BitVectorT(value, size) is deprecated')

-- Docs: https://docs.pytest.org/en/latest/warnings.html

----------- coverage: platform linux, python 3.7.3-final-0 -----------
Name                                  Stmts   Miss  Cover   Missing
-------------------------------------------------------------------
io_core/io_core.py                       16      0   100%
io_core/io_core_magma.py                 18      0   100%
memory_core/__init__.py                   0      0   100%
memory_core/memory_core.py              125     10    92%   31-33, 38, 42-48, 91, 173
memory_core/memory_core_genesis2.py       7      0   100%
memory_core/memory_core_magma.py        128      3    98%   29, 234, 237
-------------------------------------------------------------------
TOTAL                                   294     13    96%

============= 43 passed, 1 skipped, 12 warnings in 344.27 seconds ==============
The command "docker exec -i garnet bash -c "/garnet/.travis/run.sh"" exited with 0.

after_success
0.77s$ docker exec -i garnet bash -c "cd /garnet/ &amp;&amp; coveralls"
INFO:coveralls:422
INFO:coveralls:{"message":"Couldn't find a repository matching this job.","error":true}

Done. Your build exited with 0.
<pre>
