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

addGPU_wrong:
	nvcc tutorials/addGPU_wrong.cu -o build/addGPU_wrong
	./build/addGPU_wrong

addCPU_event_float:
	nvcc tutorials/addCPU_event.cu -o build/addCPU_event
	./build/addCPU_event

addCPU_event_double:
	nvcc tutorials/addCPU_event.cu -DUSE_DP -o build/addCPU_event
	./build/addCPU_event