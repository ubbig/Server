sudo apt update
sudo apt upgrade -y

sudo apt install -y vim curl htop build-essential gcc g++ make gdb gdbserver rsync wget clang valgrind ccache binutils-dev libssl-dev git

sudo apt install -y cmake

sudo apt-get install -y manpages-dev

sudo apt install -y gobjc++

sudo apt install -y apache2

sudo apt-get install -y php7.4-gd

sudo apt install -y gcc-multilib

sudo apt install -y hdf5

sudo apt install -y libgd-dev

sudo apt-get -y install netcdf-bin

sudo apt-get -y install mpich

sudo apt install -y imagemagick

sudo apt install -y zlib1g

sudo apt install -y zlib1g-dev

# zlib 심볼릭링크 ZLIB1.2.9 문제 해결
# cd /usr/local/lib/
# sudo mv libz.so.1 libz.so.1.old
# sudo ln -s /lib/x86_64-linux-gnu/libz.so.1