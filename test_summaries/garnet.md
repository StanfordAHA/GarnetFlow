<pre>
Fetched https://travis-ci.com/StanfordAHA/garnet/builds/113359834 28-May-2019
============= 43 passed, 1 skipped, 12 warnings in 344.27 seconds ==============

============================= test session starts ==============================

config_reg.py                                                    PASSED   [  2%]  
config_reg.py::test_config_register                              PASSED   [  4%]  
garnet.py                                                        PASSED   [  6%]  
garnet.py::test_garnet                                           PASSED   [  9%]  
cfg_controller_verilator_sim.py                                  PASSED   [ 11%]  
cfg_controller_verilator_sim.py::test_cfg_controller_verilator[verilog_params0] PASSED   [ 13%]  
global_buffer_int_verilator_sim.py                               PASSED   [ 15%]  
global_buffer_int_verilator_sim.py::test_global_buffer_int_verilator[verilog_params0] PASSED   [ 18%]  
io_controller_verilator_sim.py                                   PASSED   [ 20%]  
io_controller_verilator_sim.py::test_io_controller_verilator[verilog_params0] PASSED   [ 22%]  
global_buffer/verilator_sim.py                                   PASSED   [ 25%]  
global_controller.py                                             PASSED   [ 27%]  
global_controller.py::test_global_controller_functional_model    PASSED   [ 29%]  
global_controller_genesis2.py                                    PASSED   [ 31%]  
global_controller_genesis2.py::test_global_controller_genesis2   PASSED   [ 34%]  
global_controller_verilog_sim.py                                 PASSED   [ 36%]  
global_controller_verilog_sim.py::test_global_controller_verilog_sim[params0] SKIPPED  [ 38%]  
interconnect_cgra.py                                             PASSED   [ 40%]  
interconnect_cgra.py::test_interconnect_point_wise[True-100]     PASSED   [ 43%]  
interconnect_cgra.py::test_interconnect_point_wise[False-100]    PASSED   [ 45%]  
interconnect_cgra.py::test_interconnect_line_buffer[True]        PASSED   [ 47%]  
interconnect_cgra.py::test_interconnect_line_buffer[False]       PASSED   [ 50%]  
interconnect_cgra.py::test_interconnect_sram[True]               PASSED   [ 52%]  
interconnect_cgra.py::test_interconnect_sram[False]              PASSED   [ 54%]  
reset.py                                                         PASSED   [ 56%]  
reset.py::test_interconnect_reset[True-100]                      PASSED   [ 59%]  
io_core.py                                                       PASSED   [ 61%]  
io_core.py::test_io_core_functional_model                        PASSED   [ 63%]  
io_core_magma.py                                                 PASSED   [ 65%]  
io_core_magma.py::test_regression                                PASSED   [ 68%]  
mapper.py                                                        PASSED   [ 70%]  
mapper.py::test_pointwise                                        PASSED   [ 72%]  
memory_core.py                                                   PASSED   [ 75%]  
memory_core.py::test_passthru_fifo                               PASSED   [ 77%]  
memory_core.py::test_fifo_arb                                    PASSED   [ 79%]  
memory_core.py::test_general_fifo                                PASSED   [ 81%]  
memory_core.py::test_db_basic_read                               PASSED   [ 84%]  
memory_core.py::test_db_long_read                                PASSED   [ 86%]  
memory_core.py::test_db_read_mode                                PASSED   [ 88%]  
memory_core.py::test_db_arbitrary_rw_addr                        PASSED   [ 90%]  
memory_core.py::test_db_arbitrary_addr                           PASSED   [ 93%]  
memory_core.py::test_db_auto                                     PASSED   [ 95%]  
memory_core.py::test_db_auto2                                    PASSED   [ 97%]  
memory_core.py::test_sram_magma                                  PASSED   [100%]  

=============================== warnings summary ===============================
global_controller.py::test_global_controller_functional_model
memory_core.py::test_passthru_fifo
memory_core.py::test_fifo_arb
memory_core.py::test_general_fifo
memory_core.py::test_db_basic_read
memory_core.py::test_db_long_read
memory_core.py::test_db_read_mode
memory_core.py::test_db_arbitrary_rw_addr
memory_core.py::test_db_arbitrary_addr
memory_core.py::test_db_auto
memory_core.py::test_db_auto2
memory_core.py::test_sram_magma
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
