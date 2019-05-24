<pre>
Fetched https://travis-ci.com/StanfordAHA/garnet/builds/113150269 24-May-2019
======== 7 failed, 34 passed, 1 skipped, 12 warnings in 329.09 seconds =========

============================= test session starts ==============================

garnet.py                                                        PASSED   [  2%]  
garnet.py::test_garnet                                           PASSED   [  4%]  
cfg_controller_verilator_sim.py                                  PASSED   [  7%]  
cfg_controller_verilator_sim.py::test_cfg_controller_verilator[verilog_params0] PASSED   [  9%]  
global_buffer_int_verilator_sim.py                               PASSED   [ 11%]  
global_buffer_int_verilator_sim.py::test_global_buffer_int_verilator[verilog_params0] PASSED   [ 14%]  
io_controller_verilator_sim.py                                   PASSED   [ 16%]  
io_controller_verilator_sim.py::test_io_controller_verilator[verilog_params0] PASSED   [ 19%]  
global_buffer/verilator_sim.py                                   PASSED   [ 21%]  
global_controller.py                                             PASSED   [ 23%]  
global_controller.py::test_global_controller_functional_model    PASSED   [ 26%]  
global_controller_genesis2.py                                    PASSED   [ 28%]  
global_controller_genesis2.py::test_global_controller_genesis2   PASSED   [ 30%]  
global_controller_verilog_sim.py                                 PASSED   [ 33%]  
global_controller_verilog_sim.py::test_global_controller_verilog_sim[params0] SKIPPED  [ 35%]  
interconnect_cgra.py                                             PASSED   [ 38%]  
interconnect_cgra.py::test_interconnect_point_wise[True-100]     PASSED   [ 40%]  
interconnect_cgra.py::test_interconnect_point_wise[False-100]    PASSED   [ 42%]  
interconnect_cgra.py::test_interconnect_line_buffer[True]        PASSED   [ 45%]  
interconnect_cgra.py::test_interconnect_line_buffer[False]       PASSED   [ 47%]  
interconnect_cgra.py::test_interconnect_sram[True]               PASSED   [ 50%]  
interconnect_cgra.py::test_interconnect_sram[False]              PASSED   [ 52%]  
reset.py                                                         PASSED   [ 54%]  
reset.py::test_interconnect_reset[True-100]                      PASSED   [ 57%]  
io_core.py                                                       PASSED   [ 59%]  
io_core.py::test_io_core_functional_model                        PASSED   [ 61%]  
io_core_magma.py                                                 PASSED   [ 64%]  
io_core_magma.py::test_regression                                PASSED   [ 66%]  
mapper.py                                                        PASSED   [ 69%]  
mapper.py::test_pointwise                                        PASSED   [ 71%]  
memory_core.py                                                   PASSED   [ 73%]  
memory_core.py::test_passthru_fifo                               PASSED   [ 76%]  
memory_core.py::test_fifo_arb                                    PASSED   [ 78%]  
memory_core.py::test_general_fifo                                PASSED   [ 80%]  
memory_core.py::test_db_basic_read                               FAILED   [ 83%]  
memory_core.py::test_db_long_read                                FAILED   [ 85%]  
memory_core.py::test_db_read_mode                                FAILED   [ 88%]  
memory_core.py::test_db_arbitrary_rw_addr                        FAILED   [ 90%]  
memory_core.py::test_db_arbitrary_addr                           FAILED   [ 92%]  
memory_core.py::test_db_auto                                     FAILED   [ 95%]  
memory_core.py::test_db_auto2                                    FAILED   [ 97%]  
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
memory_core/memory_core.py              125     22    82%   31-33, 38, 42-48, 91, 94-96, 106-108, 120, 155, 165-168, 173
memory_core/memory_core_genesis2.py       7      0   100%
memory_core/memory_core_magma.py        118      2    98%   215, 218
-------------------------------------------------------------------
TOTAL                                   284     24    92%

======== 7 failed, 34 passed, 1 skipped, 12 warnings in 329.09 seconds =========
The command "docker exec -i garnet bash -c "/garnet/.travis/run.sh"" exited with 1.



Done. Your build exited with 1.
<pre>
