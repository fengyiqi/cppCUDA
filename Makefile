hello:
	nvcc tutorials/hello.cu -o build/hello
	./build/hello

hello_id:
	nvcc tutorials/hello_id.cu -o build/hello_id
	./build/hello_id

addGPU:
	nvcc tutorials/addGPU.cu -o build/addGPU
	./build/addGPU

addCPU:
	nvcc tutorials/addCPU.cu -o build/addCPU
	./build/addCPU

addGPU_check:
	nvcc tutorials/addGPU_check.cu -o build/addGPU_check
	./build/addGPU_check

addCPU_event_float:
	nvcc -O3 tutorials/addCPU_event.cu -o build/addCPU_event_float
	./build/addCPU_event_float

addCPU_event_double:
	nvcc -O3 tutorials/addCPU_event.cu -DUSE_DP -o build/addCPU_event_double
	./build/addCPU_event_double

addGPU_event_float:
	nvcc -O3 tutorials/addGPU_event.cu -o build/addGPU_event_float
	./build/addGPU_event_float

addGPU_event_float_sm:
	nvcc -O3 --ptxas-options=-v tutorials/addGPU_event.cu -o build/addGPU_event_float_sm
	./build/addGPU_event_float_sm

addGPU_event_double:
	nvcc -O3 tutorials/addGPU_event.cu -DUSE_DP -o build/addGPU_event_double
	./build/addGPU_event_double

addGPU_eventmemcpy_float:
	nvcc -O3 tutorials/addGPU_eventmemcpy.cu -o build/addGPU_eventmemcpy_float
	./build/addGPU_eventmemcpy_float

addGPU_eventmemcpy_double:
	nvcc -O3 tutorials/addGPU_eventmemcpy.cu -DUSE_DP -o build/addGPU_eventmemcpy_double
	./build/addGPU_eventmemcpy_double


static:
	nvcc tutorials/static.cu -o build/static
	./build/static

query:
	nvcc tutorials/query.cu -o build/query
	./build/query

matrix:
	nvcc -arch=sm_35 -O3 tutorials/matrix.cu -o build/matrix
	./build/matrix 10000

reduceCPU_double:
	nvcc -DUSE_DP -O3 tutorials/reduceCPU.cu -o build/reduceCPU_double
	./build/reduceCPU_double

reduceCPU_float:
	nvcc -O3 tutorials/reduceCPU.cu -o build/reduceCPU_float
	./build/reduceCPU_float

reduceGPU_float:
	nvcc -arch=sm_75 -O3 tutorials/reduceGPU.cu -o build/reduceGPU_float
	./build/reduceGPU_float

reduceGPU_double:
	nvcc -arch=sm_75 -O3 -DUSE_DP tutorials/reduceGPU.cu -o build/reduceGPU_double
	./build/reduceGPU_double

matrix_bank:
	nvcc -arch=sm_75 -O3 tutorials/matrix_bank.cu -o build/matrix_bank
	./build/matrix_bank 10000

reduceGPU_atomic:
	nvcc -arch=sm_75 -O3 tutorials/reduceGPU_atomic.cu -o build/reduceGPU_atomic
	./build/reduceGPU_atomic

neighborCPU:
	nvcc -arch=sm_75 -O3 tutorials/neighborCPU.cu -o build/neighborCPU
	cd build; ./neighborCPU

neighborGPU:
	nvcc -arch=sm_75 -O3 tutorials/neighborGPU.cu -o build/neighborGPU
	cd build; ./neighborGPU

reduceGPU_warp:
	nvcc -arch=sm_75 -O3 tutorials/reduceGPU_warp.cu -o build/reduceGPU_warp
	./build/reduceGPU_warp

warp_func:
	nvcc tutorials/warp_func.cu -o build/warp_func
	./build/warp_func

reduceGPU_stride:
	nvcc -arch=sm_75 -O3 tutorials/reduceGPU_stride.cu -o build/reduceGPU_stride
	./build/reduceGPU_stride

reduceGPU_static:
	nvcc -arch=sm_75 -O3 tutorials/reduceGPU_static.cu -o build/reduceGPU_static
	./build/reduceGPU_static

host_kernel:
	nvcc -arch=sm_75 -O3 tutorials/host_kernel.cu -o build/host_kernel
	./build/host_kernel

kernel_kernel:
	nvcc -arch=sm_75 -O3 tutorials/kernel_kernel.cu -o build/kernel_kernel
	./build/
	
kernel_transfer:
	nvcc -arch=sm_75 -O3 tutorials/kernel_transfer.cu -o build/kernel_transfer
	./build/kernel_transfer