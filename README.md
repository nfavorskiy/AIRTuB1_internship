# AIRTuB1-internship
Repository for a AIRTuB 1 follow-up internship

## 🚀 Usage

1. Make sure you have [Docker Desktop](https://www.docker.com/products/docker-desktop/) installed. 
2. Launch it. 
3. Clone this repository.
4. Open Terminal in the project folder and run:
```sh
docker-compose up --build
```
Running this for the first time may take some time to download all dependencies. 
When it's ready you will see a "Jupyter Server is running" message in the terminal.


<img width="854" alt="image" src="https://github.com/NikolaySirenko/AIRTuB1-internship/assets/43823270/cb9ab295-5784-40ef-a5a0-09a2b8b727cc">


5. Go to [http://127.0.0.1:8888/lab/workspaces/auto-7/tree/volume](http://127.0.0.1:8888/lab/workspaces/auto-7/tree/volume)

6. Create a folder named __scanData__ in the project folder. You can put scan files in it.

## ✨ Misc

If you want, you can use [VS Code](https://code.visualstudio.com/) as developing environment. 
You will need these extensions for it:
- [Jupyter](https://marketplace.visualstudio.com/items?itemName=ms-toolsai.jupyter)
- [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

When the Docker container is running go to the VS Code Command Palette by pressing <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd>.

Select __Dev Containers: Attach to Running Container...__ and choose __/internship-jupyter-lab-1__.

Enjoy!
