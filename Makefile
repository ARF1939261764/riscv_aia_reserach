.PHONY : default clean  cleanall run debug init

TESTNAME := case0

QEMU := ./qemu/qemu-10.2.0-rc1/build/qemu-system-riscv64 

default:
	@make -C ./app/${TESTNAME}
	cp ./app/${TESTNAME}/build/ ./build/${TESTNAME} -rf

clean:
	@make -C ./app/${TESTNAME} clean

cleanall:
	@make -C ./app/${TESTNAME} clean
	@make -C ./opensbi/opensbi_v1p7/ distclean
	@make -C ./qemu/qemu-10.2.0-rc1/ distclean

run:
	${QEMU} -M virt,aia=aplic -cpu rv64,svpbmt=on -m 2G -nographic -device loader,file=./build/${TESTNAME}/smoke/main.bin,addr=0x80000000 

debug:
	${QEMU} -M virt,aia=aplic -cpu rv64,svpbmt=on -m 2G -nographic -device loader,file=./build/${TESTNAME}/smoke/main.bin,addr=0x80000000  -s -S

init:
	@+make -C ./opensbi/opensbi_v1p7/ PLATFORM=generic CROSS_COMPILE=riscv64-unknown-linux-gnu-  all -s
	@cd ./qemu/qemu-10.2.0-rc1/ &&\
	./configure  --enable-debug --target-list=riscv64-softmmu -j 16 && \
	make -j 16 && \
	cd ../../


