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