#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>

int main(int argc, char **argv) {
    int filehandle;
    unsigned int sum=0, i=0;
    char buffer[28];

	if(argc > 1 && access(argv[1], F_OK) != -1) {
		if((filehandle = open(argv[1], O_RDWR))) {
			if(read(filehandle, &buffer, 28)) {
				for(; i<28; i+=4) {
					sum += *((int*)(buffer+i));
				}
				sum = (~sum) + 1;

				lseek(filehandle, 28, SEEK_SET);
				if(write(filehandle, &sum, 4)) {
					printf("Checksum added to firmware file\n");
					return 1;
				}
			}
			else {
				
			}
			close(filehandle);
		}
	}
	printf("Error: Firmware file could not be read\n");
    return 0;
}

