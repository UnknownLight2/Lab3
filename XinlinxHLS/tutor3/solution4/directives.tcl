############################################################
## This file is generated automatically by Vitis HLS.
## Please DO NOT edit it.
## Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
## Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
############################################################
set_directive_top -name matrix_mult "matrix_mult"
set_directive_pipeline "matrix_mult/Col"
set_directive_array_reshape -dim 2 -type complete "matrix_mult" a
set_directive_array_reshape -dim 1 -type complete "matrix_mult" b
