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
	nvcc -O3 tutorials/addCPU_event.cu -o build/addCPU_event
	./build/addCPU_event

addCPU_event_double:
	nvcc -O3 tutorials/addCPU_event.cu -DUSE_DP -o build/addCPU_event
	./build/addCPU_event

addGPU_event_float:
	nvcc -O3 tutorials/addGPU_event.cu -o build/addGPU_event
	./build/addGPU_event

addGPU_event_double:
	nvcc -O3 tutorials/addGPU_event.cu -DUSE_DP -o build/addGPU_event
	./build/addGPU_event