# This assumes the container is running on a system with a CUDA GPU
FROM tensorflow/tensorflow:latest-gpu

# Set working directory
WORKDIR /volume

# Install required system dependencies for Open3D and X11
RUN apt-get update && apt-get install -y python3-pip libgl1-mesa-glx libx11-6 && rm -rf /var/lib/apt/lists/*

# Upgrade pip first to avoid dependency issues
RUN python3 -m pip install --upgrade pip setuptools wheel

# Install Python dependencies
RUN pip install --ignore-installed -U jupyterlab pandas matplotlib numpy scikit-learn open3d loess plyfile ipykernel

# Expose JupyterLab port
EXPOSE 8888

# Run JupyterLab on container start
ENTRYPOINT ["jupyter", "lab","--ip=0.0.0.0","--allow-root","--no-browser"]
