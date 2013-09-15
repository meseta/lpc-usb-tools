#include <stdio.h>
#include <fcntl.h>

int main(int argc, char **argv) {
    int filehandle;
    unsigned int sum=0, i=0;
    char buffer[28];

    filehandle = open(argv[1], O_RDWR);
    if(read(filehandle, &buffer, 28)) {

        for(; i<28; i+=4) {
            sum += *((int*)(buffer+i));
        }
        sum = (~sum) + 1;

        lseek(filehandle, 28, SEEK_SET);
        write(filehandle, &sum, 4);
        printf("Checksum added to firmware file\n");
    }
    else {
        printf("Error: Firmware file could not be read\n");
    }
    close(filehandle);

    return 0;
}
