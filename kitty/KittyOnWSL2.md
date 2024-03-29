# Kitty on WSL2

1. Install latest mesa inside the WSL2 installation (tested with ubuntu 20.04) See: https://launchpad.net/~kisak/+archive/ubuntu/kisak-mesa

```
sudo add-apt-repository ppa:kisak/kisak-mesa
# sudo apt-get update    seems not to be necessary, at least it was automatically done on my installation
sudo apt upgrade     #  this should ask to install multiple mesa packages from kisak
```

2. helpful but also not strictly necessary: sudo apt install mesa-utils and run glxinfo -B.
Example output:
```
name of display: 172.17.112.1:0
display: 172.17.112.1:0  screen: 0
direct rendering: Yes
Extended renderer info (GLX_MESA_query_renderer):
    Vendor: Microsoft Corporation (0xffffffff)
    Device: D3D12 (NVIDIA GeForce RTX 2060) (0xffffffff)
    Version: 22.1.4
    Accelerated: yes
    Video memory: 14090MB
    Unified memory: no
    Preferred profile: core (0x1)
    Max core profile version: 4.2
    Max compat profile version: 4.2
    Max GLES1 profile version: 1.1
    Max GLES[23] profile version: 3.1
OpenGL vendor string: Microsoft Corporation
OpenGL renderer string: D3D12 (NVIDIA GeForce RTX 2060)
OpenGL core profile version string: 4.2 (Core Profile) Mesa 22.1.4 - kisak-mesa PPA
OpenGL core profile shading language version string: 4.20
OpenGL core profile context flags: (none)
OpenGL core profile profile mask: core profile

OpenGL version string: 4.2 (Compatibility Profile) Mesa 22.1.4 - kisak-mesa PPA
OpenGL shading language version string: 4.20
OpenGL context flags: (none)
OpenGL profile mask: compatibility profile

OpenGL ES profile version string: OpenGL ES 3.1 Mesa 22.1.4 - kisak-mesa PPA
OpenGL ES profile shading language version string: OpenGL ES GLSL ES 3.10
```
3. Install Kitty
4. Run VcXsrv on Window (Multiple windows, No client, not using native opengl, disable access control)
5. You can make different config.xlaunch files, e.g. config1.xlaunch and starting in silencemode in commandline with:
```
Xlaunch.exe -run config.xlaunch
```
6. add these to .zshrc
```
export LIBGL_ALWAYS_INDIRECT=0
export DISPLAY=$(ip route list default | awk '{print $3}'):0
```
7. Setup batch file to open all things together
```
@echo off
start "VcXsrv" "C:\Program Files\VcXsrv\config.xlaunch"
wsl -e zsh -lic "cd ~ ; kitty &"
```
Windows only allow to pin .exe files to start. So we create a shortcut as cmd
```
cmd /c "PATH_TO_BAT_FILE"
```
8. There might be issues, references:
- https://github.com/microsoft/WSL/issues/7915
- https://www.unixtutorial.org/how-to-install-ttf-fonts-in-linux/
- https://gitlab.freedesktop.org/mesa/mesa/-/issues/7584
- Install fonts inside Linux by downloading TTF file and put into shared font folder (fc-list) and fc-cache -f -v
- Disable WSLg to be able to run VcXsrc by
    - https://learn.microsoft.com/en-us/windows/wsl/wsl-config#wslconfig
    - Create `.wslconfig` in %UserProfile% (C:\Users\<username>)
```
[wsl2]
guiApplications=false
```
9. Enjoy !!!


