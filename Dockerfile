# Usa la imagen oficial de Python
FROM python:3.9-slim

# Configura el entorno
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Instala librerías necesarias para OpenCV y otras dependencias
RUN apt-get update && \
    apt-get install -y libgl1-mesa-glx libglib2.0-0 && \
    rm -rf /var/lib/apt/lists/*

# Crea y establece el directorio de trabajo
WORKDIR /app

# Copia los archivos de requerimientos e instala las dependencias
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Copia el resto de los archivos de la aplicación
COPY src /app/src

# Expone el puerto que utilizará FastAPI
EXPOSE 8000

# Ejecuta el servidor FastAPI con Uvicorn
CMD ["uvicorn", "src.app:app", "--host", "0.0.0.0", "--port", "8000"]
