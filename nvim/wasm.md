# Instructions

1. Install zig and add it to the path
curl -LO https://ziglang.org/download/0.16.0/zig-x86_64-linux-0.16.0.tar.xz
mkdir -p ~/zig
tar -xf zig-x86_64-linux-0.16.0.tar.xz -C ~/zig --strip-components=1
export PATH=$HOME/zig:$PATH
zig version

2. Install and activate emsdk
git clone https://github.com/emscripten-core/emsdk.git                   
cd emsdk
./emsdk install latest
./emsdk activate latest
source ./emsdk_env.sh

3. clone neovim
git clone https://github.com/neovim/neovim.git

4. Build
rm -rf .zig-cache
zig build nvim_bin \
  -Dtarget=wasm32-emscripten \
  -Dcpu=generic+atomics+bulk_memory+mutable_globals \
  -Doptimize=ReleaseFast \
  -Demscripten-sysroot=$EMSDK/upstream/emscripten/cache/sysroot
